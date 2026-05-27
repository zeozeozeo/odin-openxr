#+feature dynamic-literals
package openxr_odin

import "core:log"
// The following changes were made to xr.xml to ensure encoding/xml could parse it.
// 1. Lines 2-4 inclusive were commented out
// 2. Elements with attribute values multiple lines (typically long descriptions) were collapsed onto single lines

import "core:encoding/xml"
import "core:fmt"
import "core:os"
import "core:strconv"
import "core:strings"


KNOWN_SUFFIXES :: [?]string{"KHR", "EXT", "FB", "MSFT", "HTC", "META", "ULTRALEAP", "EXTX", "ALMALENCE"}


main :: proc() {
    when ODIN_DEBUG {
        context.logger = log.create_console_logger()
    }
    doc, err := xml.load_from_file("xr.xml")
    if err != .None {
        log.panic("Failed to Parse xr.xml:", err)
    }

    gen_core_odin(doc)
    gen_enums_odin(doc)
    gen_structs_odin(doc)
    gen_procedures_odin(doc)
    gen_loader_odin(doc)
}

el_get_attrib :: proc(el: xml.Element, key: string) -> string {
    for attr in el.attribs {
        if attr.key != key { continue }
        return attr.val
    }
    log.panic("attribute not found on element:", key)
}

el_has_attrib :: proc(el: xml.Element, key: string) -> bool {
    for attr in el.attribs {
        if attr.key != key { continue }
        return true
    }
    return false
}

el_try_get_attrib :: proc(el: xml.Element, key: string) -> (string, bool) {
    for attr in el.attribs {
        if attr.key != key { continue }
        return attr.val, true
    }
    return "", false
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                               CORE.ODIN                                                                 //
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Generates the full core.odin file and writes it out
gen_core_odin :: proc(doc: ^xml.Document) {
    builder := strings.builder_make()
    strings.write_string(&builder, "package openxr\n")
    strings.write_string(&builder, CORE_HELPERS)

    for id in doc.elements[0].value {
        switch id in id {
        case xml.Element_ID:
            el := doc.elements[id]
            el_name, ok := el_try_get_attrib(el, "name")
            if el.ident != "enums" || el_name != "API Constants" { continue }
            gen_constants(&builder, doc, el)
        case string:
        }
    }

    for id in doc.elements[0].value {
        switch id in id {
        case xml.Element_ID:
            el := doc.elements[id]
            if el.ident != "types" { continue }
            gen_core_types(&builder, doc, el)
        case string:
        }
    }

    for id in doc.elements[0].value {
        switch id in id {
        case xml.Element_ID:
            el := doc.elements[id]
            if el.ident != "extensions" { continue }
            gen_extension_constants(&builder, doc, el)
        case string:
        }
    }

    os.write_entire_file("core.odin", builder.buf[:])
}

// Generates odin constants from the "API Constants" <enums> element
gen_constants :: proc(builder: ^strings.Builder, doc: ^xml.Document, el: xml.Element) {
    strings.write_string(builder, "// Base constants\n")

    for id in el.value {
        switch child in id {
        case xml.Element_ID:
            gen_constant(builder, doc, doc.elements[child])
        case string:
        }
    }
    strings.write_string(builder, "\n")
}

// Generate an odin constant from an <enum>
gen_constant :: proc(builder: ^strings.Builder, doc: ^xml.Document, el: xml.Element) {
    full_name := el_get_attrib(el, "name")
    name := strings.trim_prefix(full_name, "XR_")
    value := el_get_attrib(el, "value")

    if name == "TRUE" || name == "FALSE" {
        return
    }

    strings.write_string(builder, fmt.aprintln(name, "::", value))
}

// Generates odin constants from the "API Constants" <enums> element
gen_core_types :: proc(builder: ^strings.Builder, doc: ^xml.Document, el: xml.Element) {
    strings.write_string(builder, "// Handle Types\n")

    for id in el.value {
        switch child in id {
        case xml.Element_ID:
            elem := doc.elements[child]
            category, _ := el_try_get_attrib(elem, "category")
            if category != "handle" { continue }

            // Find the name element by searching for ident "name"
            name_element_id: xml.Element_ID
            for v in elem.value {
                if eid, ok := v.(xml.Element_ID); ok {
                    if doc.elements[eid].ident == "name" {
                        name_element_id = eid
                        break
                    }
                }
            }

            // Get the name string from the name element
            full_name := ""
            for v in doc.elements[name_element_id].value {
                if s, ok := v.(string); ok {
                    full_name = s
                    break
                }
            }

            name := strings.trim_left(full_name, "Xr")
            strings.write_string(builder, fmt.aprintf("{} :: distinct Handle\n", name))
        case string:
        }
    }

    strings.write_string(builder, "\n")
}

// Generates odin constants from the <extensions> element
gen_extension_constants :: proc(builder: ^strings.Builder, doc: ^xml.Document, el: xml.Element) {
    strings.write_string(builder, "// Extension constants\n")

    for child in el.value {
        switch id in child {
        case xml.Element_ID:
            gen_extension_constant(builder, doc, doc.elements[id])
        case string:
        }
    }
    strings.write_string(builder, "\n")
}

// Generates odin constants from the <extensions> element
gen_extension_constant :: proc(builder: ^strings.Builder, doc: ^xml.Document, el: xml.Element) {
    full_name := el_get_attrib(el, "name")
    name := strings.trim_prefix(full_name, "XR_")
    number := el_get_attrib(el, "number")

    // Find the require element
    require_element_id: xml.Element_ID
    for v in el.value {
        if eid, ok := v.(xml.Element_ID); ok {
            if doc.elements[eid].ident == "require" {
                require_element_id = eid
                break
            }
        }
    }
    require_el := doc.elements[require_element_id]

    // Find the first enum element within require (for spec version)
    spec_element_id: xml.Element_ID
    for v in require_el.value {
        if eid, ok := v.(xml.Element_ID); ok {
            if doc.elements[eid].ident == "enum" {
                spec_element_id = eid
                break
            }
        }
    }
    spec_element := doc.elements[spec_element_id]
    spec_version := el_get_attrib(spec_element, "value")
    screaming_name := strings.to_screaming_snake_case(name)

    strings.write_string(builder, fmt.aprintf("{} :: {}\n", name, number))
    strings.write_string(builder, fmt.aprintf("{}_EXTENSION_NAME :: \"{}\"\n", screaming_name, full_name))
    // strings.write_string(builder, fmt.aprintf("{}_SPEC_VERSION :: {}\n", screaming_name, spec_version))

    for id in require_el.value {
        switch id in id {
        case xml.Element_ID:
            // We're looking for enums with a value field
            child_el := doc.elements[id]
            if child_el.ident != "enum" || !el_has_attrib(child_el, "value") { continue }
            child_full_name := el_get_attrib(child_el, "name")
            child_value := el_get_attrib(child_el, "value")
            if strings.has_suffix(child_full_name, "_NAME") { continue }
            child_name := strings.to_screaming_snake_case(strings.trim_prefix(child_full_name, "XR_"))
            strings.write_string(builder, fmt.aprintf("{} :: {}\n", child_name, child_value))
        case string:
        }
    }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                               ENUMS.ODIN                                                                //
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

Extended_Enum :: struct {
    name:  string,
    value: int,
}

// Generates the full enums.odin file and writes it out
gen_enums_odin :: proc(doc: ^xml.Document) {
    builder := strings.builder_make()
    strings.write_string(&builder, "package openxr\n\n")
    strings.write_string(&builder, "import \"core:c\"\n\n")

    // Get extension enum values
    ext_map: map[string][dynamic]Extended_Enum
    for id in doc.elements[0].value {
        switch id in id {
        case xml.Element_ID:
            el := doc.elements[id]
            if el.ident != "extensions" { continue }
            ext_map = get_enum_extensions(doc, el)
        case string:
        }
    }

    // Generate enums using <enums> element
    for id in doc.elements[0].value {
        switch id in id {
        case xml.Element_ID:
            el := doc.elements[id]
            if el.ident != "enums" { continue }
            gen_enums(&builder, doc, el, ext_map)
        case string:
        }
    }

    // Now generate our flags types
    for id in doc.elements[0].value {
        switch id in id {
        case xml.Element_ID:
            el := doc.elements[id]
            if el.ident != "types" { continue }
            gen_enums_types(&builder, doc, el)
        case string:
        }
    }


    os.write_entire_file("enums.odin", builder.buf[:])
}

// Builds a map of extended enum values from the <extensions> element
get_enum_extensions :: proc(doc: ^xml.Document, el: xml.Element) -> (ext_map: map[string][dynamic]Extended_Enum) {
    for id in el.value {
        switch id in id {
        case xml.Element_ID:
            get_enum_extension(doc, doc.elements[id], &ext_map)
        case string:
        }
    }

    return ext_map
}

// Finds extended enum values from a single <extension> element
get_enum_extension :: proc(doc: ^xml.Document, el: xml.Element, ext_map: ^map[string][dynamic]Extended_Enum) {
    ext_number, ok := strconv.parse_int(el_get_attrib(el, "number"), 10)
    assert(ok,"operation failed unexpectedly")

    // Find the require element
    require_element_id: xml.Element_ID
    for v in el.value {
        if eid, pok := v.(xml.Element_ID); pok {
            if doc.elements[eid].ident == "require" {
                require_element_id = eid
                break
            }
        }
    }
    require_el := doc.elements[require_element_id]

    for id in require_el.value {
        switch id in id {
        case xml.Element_ID:
            child_el := doc.elements[id]
            if child_el.ident != "enum" { continue }
            if !el_has_attrib(child_el, "extends") { continue }
            extends := el_get_attrib(child_el, "extends")
            if extends == "XrSwapchainUsageFlagBits" { continue }     // Special case bitfield extension
            if el_has_attrib(child_el, "alias") { continue }     // Skip Aliases
            if el_has_attrib(child_el, "bitpos") { continue }     // Skip flag bits (they use bitpos instead of offset)
            if !el_has_attrib(child_el, "offset") { continue }     // Skip enums without offset

            name := el_get_attrib(child_el, "name")
            offset, pok := strconv.parse_int(el_get_attrib(child_el, "offset"), 10)
            assert(pok,"expected condition: pok")

            if extends not_in ext_map {
                ext_map[extends] = make([dynamic]Extended_Enum, 0)
            }

            // The strategy for valuing extended enums is
            // 1000000000 Offset for all extensions
            // + (ext_number - 1) * 1000, Offset for each extension
            // offset, per enum value offset
            value := 1000000000 + 1000 * (ext_number - 1) + offset
            append(&ext_map[extends], Extended_Enum{name, value})
        case string:
        }
    }
}
is_digit :: proc(r: rune) -> bool {
    if '0' <= r && r <= '9' {
        return true
    }
    return false
}

// Generates odin code from an <enums> element
gen_enums :: proc(
    builder: ^strings.Builder,
    doc: ^xml.Document,
    el: xml.Element,
    ext_map: map[string][dynamic]Extended_Enum,
) {
    el_name := el_get_attrib(el, "name")

    // Handle API Constants special case
    if el_name == "API Constants" { return }

    // Handle actual enums
    el_type := el_get_attrib(el, "type")
    if el_type == "enum" {
        gen_enums_enum(builder, doc, el, ext_map)
        return
    } else if el_type == "bitmask" {
        gen_enums_bitfield(builder, doc, el)
        return
    }

    log.panic("Unknown <enums> of type", el_type)
}


// Generates an odin enum type from an <enums> element of type="enum"
gen_enums_enum :: proc(
    builder: ^strings.Builder,
    doc: ^xml.Document,
    el: xml.Element,
    ext_map: map[string][dynamic]Extended_Enum,
) {
    full_name := el_get_attrib(el, "name")
    name := strings.trim_prefix(full_name, "Xr")
    prefix, suffix := enum_name_to_prefix_suffix(full_name)

    strings.write_string(builder, fmt.aprintf("{} :: enum c.int {{\n", name))

    for child in el.value {
        switch id in child {
        case xml.Element_ID:
            gen_enums_enum_value(builder, doc, doc.elements[id], prefix, suffix)
        case string:
        }
    }

    // Now write any extension values
    extended_enums: [dynamic]Extended_Enum
    if full_name in ext_map {
        extended_enums = ext_map[full_name]
    }
    for ext_enum in extended_enums {
        gen_enums_enum_extended(builder, ext_enum, prefix, suffix)
    }

    strings.write_string(builder, "}\n\n")
}

// Generates code for a single value in an enum declaration
gen_enums_enum_value :: proc(builder: ^strings.Builder, doc: ^xml.Document, el: xml.Element, prefix, suffix: string) {
    if el.ident != "enum" {
        return
    }

    name := strings.trim_prefix(strings.trim_suffix(el_get_attrib(el, "name"), suffix), prefix)

    if is_digit(rune(name[0])) {
        name = strings.concatenate({"_", name})
    }
    value := el_get_attrib(el, "value")
    comment, has_comment := el_try_get_attrib(el, "comment")

    strings.write_string(builder, fmt.aprintf("\t{} = {},", name, value))
    if has_comment {
        strings.write_string(builder, fmt.aprintf(" // {}", comment))
    }
    strings.write_string(builder, "\n")
}

// Generates code for a single extension value in an enum declaration
gen_enums_enum_extended :: proc(builder: ^strings.Builder, ext_enum: Extended_Enum, prefix, suffix: string) {
    name := strings.trim_prefix(strings.trim_suffix(ext_enum.name, suffix), prefix)
    value := ext_enum.value
    strings.write_string(builder, fmt.aprintf("\t{} = {},", name, value))
    strings.write_string(builder, "\n")
}

// Generates an odin bitfield type from an <enums> element of type="bitmask"
gen_enums_bitfield :: proc(builder: ^strings.Builder, doc: ^xml.Document, el: xml.Element) {
    full_name := el_get_attrib(el, "name")
    flags, flag := trim_bitfield_typename(full_name)
    prefix, suffix := bitfield_name_to_prefix_suffix(full_name)

    strings.write_string(builder, fmt.aprintf("{} :: enum Flags64 {{\n", flag))

    for child in el.value {
        switch id in child {
        case xml.Element_ID:
            gen_enums_bitfield_value(builder, doc, doc.elements[id], prefix, suffix)
        case string:
        }
    }

    // Handle XrSwapchainUsageFlagBits special case
    if full_name == "XrSwapchainUsageFlagBits" {
        strings.write_string(builder, "\tINPUT_ATTACHMENT_MND = 7,\n")
    }


    strings.write_string(builder, "}\n\n")
}

// Generates code for a single value in a bitfield
gen_enums_bitfield_value :: proc(
    builder: ^strings.Builder,
    doc: ^xml.Document,
    el: xml.Element,
    prefix, suffix: string,
) {
    if el.ident != "enum" {
        return
    }

    name := strings.trim_prefix(strings.trim_suffix(el_get_attrib(el, "name"), suffix), prefix)
    value := el_get_attrib(el, "bitpos")
    comment, has_comment := el_try_get_attrib(el, "comment")

    strings.write_string(builder, fmt.aprintf("\t{} = {},", name, value))
    if has_comment {
        strings.write_string(builder, fmt.aprintf(" // {}", comment))
    }
    strings.write_string(builder, "\n")
}

// Converts a full OpenXR enum type name to a prefix and suffix string to trim from its members
enum_name_to_prefix_suffix :: proc(name: string) -> (string, string) {
    // Handle weird cases
    if name == "XrStructureType" { return "XR_TYPE_", "" }
    if name == "XrResult" { return "XR_", "" }
    if name == "XrPerfSettingsNotificationLevelEXT" { return "XR_PERF_SETTINGS_NOTIF_LEVEL_", "_EXT" }

    // Determine if the type name has a known suffix
    suffix := ""
    for known in KNOWN_SUFFIXES {
        if !strings.has_suffix(name, known) { continue }
        suffix = known
    }

    // Now remove that suffix from the name and convert it to screaming snake case
    prefix := strings.trim_suffix(name, suffix)
    prefix = fmt.aprintf("{}_", strings.to_screaming_snake_case(prefix))
    suffix = fmt.aprintf("_{}", suffix)
    return prefix, suffix
}

// Converts a full OpenXR enum type name to a prefix and suffix string to trim from its members
trim_bitfield_typename :: proc(_name: string) -> (string, string) {
    // Determine vendor suffix
    suffix := ""
    for known in KNOWN_SUFFIXES {
        if !strings.has_suffix(_name, known) { continue }
        suffix = known
    }

    // Remove Vendor and "Bits" suffix, and Xr prefix
    name := strings.trim_suffix(strings.trim_suffix(_name, suffix), "Bits")
    name = strings.trim_prefix(name, "Xr")

    // Build FooBarFlagsVENDOR and FooBarFlagVENDOR variants
    flags := fmt.aprintf("{}s{}", name, suffix)
    flag := fmt.aprintf("{}{}", name, suffix)
    return flags, flag
}

// Converts a full OpenXR enum type name to a prefix and suffix string to trim from its members
bitfield_name_to_prefix_suffix :: proc(name: string) -> (string, string) {
    // Determine if the type name has a known suffix
    suffix := ""
    for known in KNOWN_SUFFIXES {
        if !strings.has_suffix(name, known) { continue }
        suffix = known
    }

    // Now remove that suffix from the name, along with Bits and convert it to screaming snake case
    prefix := strings.trim_suffix(strings.trim_suffix(name, suffix), "FlagBits")
    prefix = fmt.aprintf("{}_", strings.to_screaming_snake_case(prefix))
    suffix = suffix == "" ? "_BIT" : fmt.aprintf("_BIT_{}", suffix)
    return prefix, suffix
}

// Generates odin code from an <enums> element
gen_enums_types :: proc(builder: ^strings.Builder, doc: ^xml.Document, el: xml.Element) {
    for id in el.value {
        switch id in id {
        case xml.Element_ID:
            gen_enums_type(builder, doc, doc.elements[id])
        case string:
        }
    }
}

// Generates code for an enum bitset type
gen_enums_type :: proc(builder: ^strings.Builder, doc: ^xml.Document, el: xml.Element) {
    category, ok := el_try_get_attrib(el, "category")
    if category != "bitmask" { return }
    bitvalues := el_get_attrib(el, "bitvalues")

    flags, flag := trim_bitfield_typename(bitvalues)

    strings.write_string(builder, fmt.aprintf("{} :: distinct bit_set[{}; Flags64]\n", flags, flag))
}


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                               STRUCTS.ODIN                                                              //
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Mapping from C to odin type names
TYPE_ALIASES := map[string]string {
    "float"    = "f32",
    "double"   = "f64",
    "int8_t"   = "i8",
    "int16_t"  = "i16",
    "int32_t"  = "i32",
    "int64_t"  = "i64",
    "uint8_t"  = "u8",
    "uint16_t" = "u16",
    "uint32_t" = "u32",
    "uint64_t" = "u64",
    "XrBool32" = "b32",
    "int"      = "c.int",
    // "char"     = "u8",
}

// Mapping from C to odin type names
NAME_ALIASES := map[string]string {
    "map"     = "_map",
    "type"    = "sType",
    "context" = "ctx",
    "dynamic" = "fovDynamic",
}

UNSUPPORTED_STRUCTS :: [?]string {
    "XrGraphicsBindingOpenGLXlibKHR",
    "XrGraphicsBindingOpenGLXcbKHR",
    "XrGraphicsBindingOpenGLWaylandKHR",
    "XrGraphicsBindingOpenGLESAndroidKHR",
    "XrGraphicsBindingEGLMNDX",
}

// Generates the full enums.odin file and writes it out
gen_structs_odin :: proc(doc: ^xml.Document) {
    builder := strings.builder_make()
    strings.write_string(&builder, "package openxr\n\n")

    strings.write_string(&builder, STRUCT_OS_TYPES)

    for id in doc.elements[0].value {
        switch id in id {
        case xml.Element_ID:
            el := doc.elements[id]
            if el.ident != "types" { continue }
            gen_struct_types(&builder, doc, el)
        case string:
        }
    }

    os.write_entire_file("structs.odin", builder.buf[:])
}

// Generates struct declaration code from the <types> element
gen_struct_types :: proc(builder: ^strings.Builder, doc: ^xml.Document, _el: xml.Element) {
    for id in _el.value {
        switch id in id {
        case xml.Element_ID:
            el := doc.elements[id]
            category, _ := el_try_get_attrib(el, "category")
            if category != "struct" { continue }
            gen_struct_type(builder, doc, el)
        case string:
        }
    }
}

gen_struct_type :: proc(builder: ^strings.Builder, doc: ^xml.Document, el: xml.Element) {
    full_name := el_get_attrib(el, "name")
    for unsupported in UNSUPPORTED_STRUCTS {
        if full_name == unsupported { return }
    }

    name := strings.trim_left(full_name, "Xr")

    strings.write_string(builder, fmt.aprintf("{} :: struct {{\n", name))

    for id in el.value {
        switch id in id {
        case xml.Element_ID:
            gen_struct_member(builder, doc, doc.elements[id])
        case string:
        }
    }

    strings.write_string(builder, "}\n\n")
}

gen_struct_member :: proc(builder: ^strings.Builder, doc: ^xml.Document, el: xml.Element) {
    if el.ident != "member" { return }

    // Find type and name elements by their ident, not by position
    type_element_id: xml.Element_ID
    name_element_id: xml.Element_ID
    for v in el.value {
        if eid, ok := v.(xml.Element_ID); ok {
            if doc.elements[eid].ident == "type" {
                type_element_id = eid
            } else if doc.elements[eid].ident == "name" {
                name_element_id = eid
            }
        }
    }

    // Get type and name strings
    type_str := ""
    name_str := ""
    for v in doc.elements[type_element_id].value {
        if s, ok := v.(string); ok {
            type_str = s
            break
        }
    }
    for v in doc.elements[name_element_id].value {
        if s, ok := v.(string); ok {
            name_str = s
            break
        }
    }

    // Apply alias and trim Xr prefix
    if type_str in TYPE_ALIASES {
        type_str = TYPE_ALIASES[type_str]
    }
    type_str = strings.trim_prefix(type_str, "Xr")
    if strings.has_prefix(type_str, "PFN_xr") {
        type_str = strings.trim_prefix(type_str, "PFN_xr")
        type_str = fmt.aprintf("Proc{}", type_str)
    }

    // Handle Vk prefixes
    if strings.has_prefix(type_str, "Vk") {
        type_str = strings.trim_prefix(type_str, "Vk")
        type_str = fmt.aprintf("vk.{}", type_str)
    }
    if strings.has_prefix(type_str, "PFN_vk") {
        type_str = strings.trim_prefix(type_str, "PFN_vk")
        type_str = fmt.aprintf("vk.Proc{}", type_str)
    }

    // Handle Arrayness
    // The XML handles arrayness inconsistently
    // The array size can be in an <enum> element or embedded in the text

    // Find text content in el.value (skip Element_IDs)
    // Concatenate all string nodes (text can be split across multiple nodes)
    array_text := ""
    for v in el.value {
        if text, ok := v.(string); ok {
            array_text = strings.concatenate({array_text, text})
        }
    }

    // Check if there's an array (contains "[")
    if strings.contains(array_text, "[") {
        // First check if there's an <enum> child element with the array size
        enum_element_id: xml.Element_ID
        has_enum := false
        for v in el.value {
            if eid, ok := v.(xml.Element_ID); ok {
                if doc.elements[eid].ident == "enum" {
                    enum_element_id = eid
                    has_enum = true
                    break
                }
            }
        }

        if has_enum {
            // Get the enum constant name from the <enum> element
            enum_str := ""
            for v in doc.elements[enum_element_id].value {
                if s, ok := v.(string); ok {
                    enum_str = s
                    break
                }
            }
            type_str = fmt.aprintf("[{}]{}", strings.trim_prefix(enum_str, "XR_"), type_str)
        } else if strings.contains(array_text, "]") {
            // Literal array size in the text (e.g., "[16]" or "[4000]" or "[XR_SOME_CONST]")
            size_str := strings.trim_prefix(strings.trim_suffix(array_text, "]"), "[")
            size_str = strings.trim_space(size_str)
            // Also trim XR_ prefix from constants
            size_str = strings.trim_prefix(size_str, "XR_")
            if len(size_str) > 0 {
                type_str = fmt.aprintf("[{}]{}", size_str, type_str)
            }
        }
    }

    // Handle Pointerness / char* ness
    ptr_count := strings.count(array_text, "*")
    if ptr_count == 1 {
        if type_str == "char" {
            type_str = "cstring"
        } else {
            type_str = fmt.aprintf("^{}", type_str)
        }
    }
    if ptr_count == 2 {
        if type_str == "char" {
            type_str = "[^]cstring"
        } else {
            type_str = fmt.aprintf("^^{}", type_str)
        }
    }

    if strings.has_suffix(type_str, "char") {
        type_str = fmt.aprintf("{}u8", strings.trim_suffix(type_str, "char"))
    }

    // Now handle void pointers
    if type_str == "^void" {
        type_str = "rawptr"
    }
    if type_str == "^^void" {
        type_str = "^rawptr"
    }

    // Alias reserved words
    if name_str in NAME_ALIASES {
        name_str = NAME_ALIASES[name_str]
    }

    strings.write_string(builder, fmt.aprintf("\t{}: {},\n", name_str, type_str))
}


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                               PROCEDURES.ODIN                                                           //
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Generates the full enums.odin file and writes it out
gen_procedures_odin :: proc(doc: ^xml.Document) {
    builder := strings.builder_make()
    strings.write_string(&builder, "package openxr\n\n")
    strings.write_string(&builder, PROC_OS_TYPES)

    for id in doc.elements[0].value {
        switch id in id {
        case xml.Element_ID:
            el := doc.elements[id]
            if el.ident != "commands" { continue }
            gen_procedures(&builder, doc, el)
        case string:
        }
    }

    os.write_entire_file("procedures.odin", builder.buf[:])
}

gen_procedures :: proc(builder: ^strings.Builder, doc: ^xml.Document, el: xml.Element) {
    for id in el.value {
        switch id in id {
        case xml.Element_ID:
            child_el := doc.elements[id]
            if child_el.ident != "command" { continue }
            gen_procedure_type(builder, doc, child_el)
        case string:
        }
    }

    strings.write_string(builder, "\n\n")

    for id in el.value {
        switch id in id {
        case xml.Element_ID:
            child_el := doc.elements[id]
            if child_el.ident != "command" { continue }
            gen_procedure(builder, doc, child_el)
        case string:
        }
    }
}

gen_procedure_type :: proc(builder: ^strings.Builder, doc: ^xml.Document, el: xml.Element) {
    // Handle aliased commands special case. Just xrGetVulkanGraphicsRequirements2KHR as of writing
    if el_has_attrib(el, "alias") { return }

    // Function name and return type are in first child (proto element)
    // Find the proto element
    proto_element_id: xml.Element_ID
    for v in el.value {
        if eid, ok := v.(xml.Element_ID); ok {
            if doc.elements[eid].ident == "proto" {
                proto_element_id = eid
                break
            }
        }
    }
    proto_el := doc.elements[proto_element_id]

    // Find type and name elements within proto
    type_element_id: xml.Element_ID
    name_element_id: xml.Element_ID
    for v in proto_el.value {
        if eid, ok := v.(xml.Element_ID); ok {
            if doc.elements[eid].ident == "type" {
                type_element_id = eid
            } else if doc.elements[eid].ident == "name" {
                name_element_id = eid
            }
        }
    }

    // Extract full_name and full_return_type
    full_name := ""
    full_return_type := ""
    for v in doc.elements[name_element_id].value {
        if s, ok := v.(string); ok {
            full_name = s
            break
        }
    }
    for v in doc.elements[type_element_id].value {
        if s, ok := v.(string); ok {
            full_return_type = s
            break
        }
    }

    if full_name == "xrGetInstanceProcAddr" { return }     // Skip this since we manually link it
    name := strings.trim_prefix(full_name, "xr")
    return_type := strings.trim_prefix(full_return_type, "Xr")

    strings.write_string(builder, fmt.aprintf("Proc{} :: #type proc \"system\" (\n", name))
    // Iterate over all children and process param elements
    for id in el.value {
        switch id in id {
        case xml.Element_ID:
            child_el := doc.elements[id]
            if child_el.ident != "param" { continue }
            gen_procedure_arg(builder, doc, doc.elements[id])
        case string:
        }
    }

    strings.write_string(builder, fmt.aprintf(") -> {}\n\n", return_type))
}

gen_procedure_arg :: proc(builder: ^strings.Builder, doc: ^xml.Document, el: xml.Element) {

    // Find type and name elements by their ident, not by position
    type_element_id: xml.Element_ID
    name_element_id: xml.Element_ID
    for v in el.value {
        if eid, ok := v.(xml.Element_ID); ok {
            if doc.elements[eid].ident == "type" {
                type_element_id = eid
            } else if doc.elements[eid].ident == "name" {
                name_element_id = eid
            }
        }
    }

    // Get type and name strings
    type_str := ""
    name_str := ""
    for v in doc.elements[type_element_id].value {
        if s, ok := v.(string); ok {
            type_str = s
            break
        }
    }
    for v in doc.elements[name_element_id].value {
        if s, ok := v.(string); ok {
            name_str = s
            break
        }
    }

    // Find text content in el.value for array/pointer handling
    // Concatenate all string nodes (text can be split across multiple nodes)
    array_text := ""
    for v in el.value {
        if text, ok := v.(string); ok {
            array_text = strings.concatenate({array_text, text})
        }
    }

    // Apply alias and trim Xr prefix
    if type_str in TYPE_ALIASES {
        type_str = TYPE_ALIASES[type_str]
    }
    type_str = strings.trim_prefix(type_str, "Xr")
    if strings.has_prefix(type_str, "PFN_xr") {
        type_str = strings.trim_prefix(type_str, "PFN_xr")
        type_str = fmt.aprintf("Proc{}", type_str)
    }

    // Handle Vk prefixes
    if strings.has_prefix(type_str, "Vk") {
        type_str = strings.trim_prefix(type_str, "Vk")
        type_str = fmt.aprintf("vk.{}", type_str)
    }
    if strings.has_prefix(type_str, "PFN_vk") {
        type_str = strings.trim_prefix(type_str, "PFN_vk")
        type_str = fmt.aprintf("vk.Proc{}", type_str)
    }

    // Handle Arrayness
    if strings.contains(array_text, "[") || strings.contains(array_text, "]") {
        type_str = fmt.aprintf("[^]{}", type_str)
    }

    // Handle Pointerness / char* ness
    ptr_count := strings.count(array_text, "*")
    if ptr_count == 1 {
        if type_str == "char" {
            type_str = "cstring"
        } else {
            type_str = fmt.aprintf("^{}", type_str)
        }
    }
    if ptr_count == 2 {
        if type_str == "char" {
            type_str = "[^]cstring"
        } else {
            type_str = fmt.aprintf("^^{}", type_str)
        }
    }

    if strings.has_suffix(type_str, "char") {
        type_str = fmt.aprintf("{}u8", strings.trim_suffix(type_str, "char"))
    }

    // Now handle void pointers
    if type_str == "^void" {
        type_str = "rawptr"
    }
    if type_str == "^^void" {
        type_str = "^rawptr"
    }

    if name_str in NAME_ALIASES {
        name_str = NAME_ALIASES[name_str]
    }
    strings.write_string(builder, fmt.aprintf("\t{}: {},\n", name_str, type_str))
}

gen_procedure :: proc(builder: ^strings.Builder, doc: ^xml.Document, el: xml.Element) {
    // Handle aliased commands special case. Just xrGetVulkanGraphicsRequirements2KHR as of writing
    if el_has_attrib(el, "alias") {
        full_name := el_get_attrib(el, "name")
        full_alias_name := el_get_attrib(el, "alias")
        name := strings.trim_prefix(full_name, "xr")
        alias_name := strings.trim_prefix(full_alias_name, "xr")
        strings.write_string(builder, fmt.aprintf("{}: Proc{}\n", name, alias_name))
        return
    }

    // Find the proto element
    proto_element_id: xml.Element_ID
    for v in el.value {
        if eid, ok := v.(xml.Element_ID); ok {
            if doc.elements[eid].ident == "proto" {
                proto_element_id = eid
                break
            }
        }
    }
    proto_el := doc.elements[proto_element_id]

    // Find name element within proto
    name_element_id: xml.Element_ID
    for v in proto_el.value {
        if eid, ok := v.(xml.Element_ID); ok {
            if doc.elements[eid].ident == "name" {
                name_element_id = eid
                break
            }
        }
    }

    // Extract full_name
    full_name := ""
    for v in doc.elements[name_element_id].value {
        if s, ok := v.(string); ok {
            full_name = s
            break
        }
    }

    if full_name == "xrGetInstanceProcAddr" { return }     // Skip this since we manually link it
    name := strings.trim_prefix(full_name, "xr")

    strings.write_string(builder, fmt.aprintf("{}: Proc{}\n", name, name))
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                               LOADER.ODIN                                                               //
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

is_base_proc :: proc(name: string) -> bool {
    for proc_name in BASE_PROCS {
        if name != proc_name { continue }
        return true
    }
    return false
}

// Generates the full enums.odin file and writes it out
gen_loader_odin :: proc(doc: ^xml.Document) {
    builder := strings.builder_make()
    strings.write_string(&builder, "package openxr\n\n")
    strings.write_string(&builder, LOADER_LINKS)

    gen_base_loader(&builder, doc)
    gen_instance_loader(&builder, doc)

    os.write_entire_file("loader.odin", builder.buf[:])
}

gen_base_loader :: proc(builder: ^strings.Builder, doc: ^xml.Document) {
    strings.write_string(builder, BASE_LOADER_START)

    for full_name in BASE_PROCS {
        if full_name == "xrGetInstanceProcAddr" { continue }
        name := strings.trim_prefix(full_name, "xr")
        strings.write_string(builder, fmt.aprintf("\tGetInstanceProcAddr(nil, \"{}\", &out_function)\n", full_name))
        strings.write_string(builder, fmt.aprintf("\t{} = auto_cast out_function\n", name))
    }

    strings.write_string(builder, "}\n\n")
}

gen_instance_loader :: proc(builder: ^strings.Builder, doc: ^xml.Document) {
    strings.write_string(builder, INSTANCE_LOADER_START)
    commands_el: xml.Element
    for id in doc.elements[0].value {
        switch id in id {
        case xml.Element_ID:
            if doc.elements[id].ident != "commands" { continue }
            commands_el = doc.elements[id]
        case string:
        }
    }

    for id in commands_el.value {
        switch id in id {
        case xml.Element_ID:
            child_el := doc.elements[id]
            if child_el.ident != "command" { continue }
            // Handle aliased commands special case. Just xrGetVulkanGraphicsRequirements2KHR as of writing
            if el_has_attrib(child_el, "alias") {
                full_name := el_get_attrib(child_el, "name")
                name := strings.trim_prefix(full_name, "xr")
                get_str := fmt.aprintf("\tGetInstanceProcAddr(instance, \"{}\", &out_function)\n", full_name)
                strings.write_string(builder, get_str)
                strings.write_string(builder, fmt.aprintf("\t{} = auto_cast out_function\n", name))
                continue
            }
            // Find the proto element
            proto_element_id: xml.Element_ID
            for v in child_el.value {
                if eid, ok := v.(xml.Element_ID); ok {
                    if doc.elements[eid].ident == "proto" {
                        proto_element_id = eid
                        break
                    }
                }
            }
            proto_el := doc.elements[proto_element_id]

            // Find name element within proto
            name_element_id: xml.Element_ID
            for v in proto_el.value {
                if eid, ok := v.(xml.Element_ID); ok {
                    if doc.elements[eid].ident == "name" {
                        name_element_id = eid
                        break
                    }
                }
            }

            // Extract full_name
            full_name := ""
            for v in doc.elements[name_element_id].value {
                if s, ok := v.(string); ok {
                    full_name = s
                    break
                }
            }

            if is_base_proc(full_name) { continue }
            if full_name == "xrGetInstanceProcAddr" { continue }
            name := strings.trim_prefix(full_name, "xr")
            strings.write_string(
                builder,
                fmt.aprintf("\tGetInstanceProcAddr(instance, \"{}\", &out_function)\n", full_name),
            )
            strings.write_string(builder, fmt.aprintf("\t{} = auto_cast out_function\n", name))
        case string:
        }
    }

    strings.write_string(builder, "}\n\n")
}

STRUCT_OS_TYPES :: `
import "core:c"

// Vulkan Types
import vk "vendor:vulkan"

// OpenGL Types
EGLenum :: c.int

// Windows specific OS / API types
when ODIN_OS == .Windows {
	import win32 "core:sys/windows"
        HDC :: win32.HDC
        HGLRC :: win32.HGLRC
	LUID  :: win32.LUID
        IUnknown :: win32.IUnknown

        D3D_FEATURE_LEVEL :: c.int

        import D3D11 "vendor:directx/d3d11"
        ID3D11Device :: D3D11.IDevice
        ID3D11Texture2D :: D3D11.ITexture2D
        
        import D3D12 "vendor:directx/d3d12"
        ID3D12Device :: D3D12.IDevice
        ID3D12CommandQueue :: D3D12.ICommandQueue
        ID3D12Resource :: D3D12.IResource
} else {
        HDC :: distinct rawptr
        HGLRC :: distinct rawptr
	LUID   :: struct {
		LowPart:  DWORD,
		HighPart: LONG,
	}
        IUnknown :: distinct rawptr

        D3D_FEATURE_LEVEL :: c.int
        
        ID3D11Device :: distinct rawptr
        ID3D11Texture2D :: distinct rawptr
        
        ID3D12Device :: distinct rawptr
        ID3D12CommandQueue :: distinct rawptr
        ID3D12Resource :: distinct rawptr
}

`

PROC_OS_TYPES :: `
import "core:c"
import "core:c/libc"

// Vulkan Types
import vk "vendor:vulkan"

timespec :: libc.timespec
wchar_t :: libc.wchar_t
jobject :: rawptr

when ODIN_OS == .Windows {
	import win32 "core:sys/windows"
        LARGE_INTEGER :: win32.LARGE_INTEGER
} else {
        LARGE_INTEGER :: distinct distinct c.longlong
}

`

LOADER_LINKS :: `
when ODIN_OS == .Windows {
    foreign import openxr_loader "openxr_loader.lib"
} else when ODIN_OS == .Darwin {
    foreign import openxr_loader "libopenxr_loader.dylib"
} else when ODIN_OS == .Linux {
    when ODIN_ARCH == .amd64 {
        foreign import openxr_loader "linux_x64/libopenxr_loader.so"
    } else when ODIN_ARCH == .arm64 {
        foreign import openxr_loader "linux_arm64/libopenxr_loader.so"
    } else {
        #panic("vendor/xr supports only linux amd64/arm64")
    }
}
// Link just the proc address loader
foreign openxr_loader {
	@(link_name = "xrGetInstanceProcAddr")
	GetInstanceProcAddr :: proc "system" (
		instance: Instance,
		name: cstring,
		function: ^ProcVoidFunction,
	) -> Result ---
}

`

BASE_PROCS := [?]string{"xrCreateInstance", "xrEnumerateApiLayerProperties", "xrEnumerateInstanceExtensionProperties"}

BASE_LOADER_START :: `
// Loads all the base procedures which don't require an instance
load_base_procs :: proc() {
	out_function : ProcVoidFunction

`

INSTANCE_LOADER_START :: `
// Load all the instance procedures
load_instance_procs :: proc(instance: Instance) {
        out_function : ProcVoidFunction

`

CORE_HELPERS :: `
// Version Helpers
CURRENT_API_VERSION :: (1<<48) | (0<<12) | (32)
MAKE_VERSION :: proc(major, minor, patch: u64) -> u64 {
    return (major<<48) | (minor<<32) | (patch)
}

// Base Types
Handle          :: distinct rawptr
Atom            :: distinct u64
Flags64         :: distinct u64
Time            :: i64
Duration        :: i64
Version         :: u64

// Atom Types
Path                    :: distinct Atom
SystemId                :: distinct Atom
ControllerModelKeyMSFT  :: distinct Atom
AsyncRequestIdFB        :: distinct Atom
RenderModelKeyFB        :: distinct Atom

// Helper function for generating fixed buffer strings
make_string :: proc(str: string, $n: int) -> [n]u8 {
	result: [n]u8
	copy(result[:], str)
	return result
}

// Function pointer types
ProcSetProcAddress :: #type proc "c" (p: rawptr, name: cstring)
ProcVoidFunction :: #type proc "c" () -> rawptr
ProcDebugUtilsMessengerCallbackEXT :: #type proc "c" (
	messageSeverity: DebugUtilsMessageSeverityFlagsEXT,
	messageTypes: DebugUtilsMessageTypeFlagsEXT,
	callbackData: ^DebugUtilsMessengerCallbackDataEXT,
	userData: rawptr,
) -> rawptr
`
