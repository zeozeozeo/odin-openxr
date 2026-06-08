# odin-openxr

OpenXR bindings for Odin, forked over from `catermujo/odin-openxr` and `cshenton/openxr_odin`.

> [!NOTE]
> Currently targeting OpenXR SDK `1.1.60`.

## Usage

Copy this repository into your Odin project and import it as a package:

```odin
import xr "openxr"
```

The only statically linked OpenXR symbol is `xrGetInstanceProcAddr`. All other functions are loaded
through the generated helpers:

- `xr.load_base_procs()` loads the instance creation and enumeration functions.
- `xr.load_instance_procs(instance)` loads instance-level and extension functions.

Minimal instance setup:

```odin
package xr_example

import xr "openxr"

main :: proc() {
	xr.load_base_procs()

	app_info := xr.ApplicationInfo {
		applicationName    = xr.make_string("Example Application", xr.MAX_APPLICATION_NAME_SIZE),
		applicationVersion = 1,
		engineName         = xr.make_string("Example Engine", xr.MAX_ENGINE_NAME_SIZE),
		engineVersion      = 1,
		apiVersion         = xr.CURRENT_API_VERSION,
	}

	create_info := xr.InstanceCreateInfo {
		sType           = .INSTANCE_CREATE_INFO,
		applicationInfo = app_info,
	}

	instance: xr.Instance
	result := xr.CreateInstance(&create_info, &instance)
	if result != .SUCCESS {
		panic("xrCreateInstance failed")
	}
	defer xr.DestroyInstance(instance)

	xr.load_instance_procs(instance)

	// Continue...
}
```

## Loader binaries

Vendored loader binaries are stored by target:

- `windows_x64/openxr_loader.lib`
- `windows_arm64/openxr_loader.lib`
- `linux_x64/libopenxr_loader.so`
- `linux_arm64/libopenxr_loader.so`
- `macos_x64/libopenxr_loader.dylib`
- `macos_arm64/libopenxr_loader.dylib`

On Windows, the bindings will additionally link against `Advapi32.lib`.

## Building loader binaries

You will need Python installed for this.

List supported targets:

```sh
python build.py --list-targets
```

Build all targets supported from the current host:

```sh
python build.py --all
```

Build specific targets:

```sh
python build.py windows_x64 windows_arm64
python build.py linux_x64 linux_arm64
python build.py macos_x64 macos_arm64
```

On Windows, use `build.bat` to automatically detect a Python installation:

```bat
build.bat --all
build.bat macos_arm64
```

On Linux/MacOS, use `build.sh`:

```sh
./build.sh --all
./build.sh macos_arm64
```

### Host behavior

On Windows:

- Windows targets are built with the latest Visual Studio generator CMake can find.
- Linux and macOS targets are cross-compiled with Zig.
- `zig` must be available on `PATH` for Unix cross targets.

On Linux and macOS:

- Running `python build.py` with no target builds the native host target.
- Passing an explicit non-native Unix target uses Zig for cross-compilation.
- Windows targets require a Windows host with Visual Studio C++ tools.

## Regenerating bindings

The generator is in `generator/generator.odin`. It reads `xr.xml` and emits:

- `core.odin`
- `enums.odin`
- `structs.odin`
- `procedures.odin`
- `loader.odin`

`xr.xml` comes from the Khronos OpenXR registry and has been edited so Odin's `core:encoding/xml`
parser can read it.

> TODO: Patch `xr.xml` automatically?

## Known limitations

Some platform-specific OpenXR structs are intentionally not generated because Odin core packages do
not provide the required native window-system types:

- `XrGraphicsBindingOpenGLXlibKHR`
- `XrGraphicsBindingOpenGLXcbKHR`
- `XrGraphicsBindingOpenGLWaylandKHR`
- `XrGraphicsBindingOpenGLESAndroidKHR`
- `XrGraphicsBindingEGLMNDX`

D3D11, D3D12, Vulkan, and Metal-related bindings are generated where the registry and available Odin
types allow it.

These bindings are generated and should be treated as low-level API bindings. Extension procedures
are loaded by `xr.load_instance_procs`, but calling an extension procedure without enabling and
validating the corresponding extension can still crash like any other null function pointer call.
