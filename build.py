#!/usr/bin/env python3

import argparse
import os
import platform
import shutil
import subprocess
import sys
from pathlib import Path


SDK_REVISION = "64f2b37c8c6da3d83c9b4d11865ba1fb752cb8ec"
TARGETS = {
    "windows_x64": {
        "kind": "windows",
        "system": "Windows",
        "arch": "x64",
        "vs_arch": "x64",
        "file": "openxr_loader.lib",
    },
    "windows_arm64": {
        "kind": "windows",
        "system": "Windows",
        "arch": "arm64",
        "vs_arch": "ARM64",
        "file": "openxr_loader.lib",
    },
    "linux_x64": {
        "kind": "shared",
        "zig_target": "x86_64-linux-gnu",
        "system": "Linux",
        "processor": "x86_64",
        "file": "libopenxr_loader.so",
    },
    "linux_arm64": {
        "kind": "shared",
        "zig_target": "aarch64-linux-gnu",
        "system": "Linux",
        "processor": "aarch64",
        "file": "libopenxr_loader.so",
    },
    "macos_x64": {
        "kind": "shared",
        "zig_target": "x86_64-macos",
        "system": "Darwin",
        "processor": "x86_64",
        "file": "libopenxr_loader.dylib",
    },
    "macos_arm64": {
        "kind": "shared",
        "zig_target": "aarch64-macos",
        "system": "Darwin",
        "processor": "arm64",
        "file": "libopenxr_loader.dylib",
    },
}


repo_root = Path(__file__).resolve().parent
sdk_dir = repo_root / "OpenXR-SDK"


def run(args, cwd=repo_root):
    print("+ " + " ".join(str(arg) for arg in args), flush=True)
    subprocess.run([str(arg) for arg in args], cwd=cwd, check=True)


def command_exists(name):
    return shutil.which(name) is not None


def host_system():
    system = platform.system()
    if system == "Windows":
        return "Windows"
    if system == "Darwin":
        return "Darwin"
    if system == "Linux":
        return "Linux"
    return system


def host_arch():
    machine = platform.machine().lower()
    if machine in ("amd64", "x86_64"):
        return "x64"
    if machine in ("arm64", "aarch64"):
        return "arm64"
    return machine


def native_target_name():
    system = host_system()
    arch = host_arch()
    if system == "Windows" and arch in ("x64", "arm64"):
        return f"windows_{arch}"
    if system == "Linux" and arch in ("x64", "arm64"):
        return f"linux_{arch}"
    if system == "Darwin" and arch in ("x64", "arm64"):
        return f"macos_{arch}"
    return None


def default_targets():
    if host_system() == "Windows":
        return list(TARGETS.keys())

    native = native_target_name()
    if native:
        return [native]
    return []


def ensure_sdk(revision, needs_linux_loader_only_patch):
    if not sdk_dir.exists():
        run(["git", "clone", "https://github.com/KhronosGroup/OpenXR-SDK.git", sdk_dir])

    run(["git", "-C", sdk_dir, "fetch", "--tags", "origin"])
    run(["git", "-C", sdk_dir, "checkout", "--detach", revision])
    run(["git", "-C", sdk_dir, "submodule", "update", "--init", "--recursive"])
    if needs_linux_loader_only_patch:
        patch_sdk_for_loader_only_cross()


def patch_sdk_for_loader_only_cross():
    presentation = sdk_dir / "src" / "cmake" / "presentation.cmake"
    text = presentation.read_text(encoding="utf-8")
    text = text.replace(
        "set(PRESENTATION_BACKENDS xlib xcb wayland)",
        "set(PRESENTATION_BACKENDS xlib xcb wayland none)",
    )
    if 'PRESENTATION_BACKEND STREQUAL "none"' not in text:
        marker = 'message(STATUS "Presentation backend selected for hello_xr, loader_test, conformance: ${PRESENTATION_BACKEND}")'
        insertion = marker + '\n\nif(PRESENTATION_BACKEND STREQUAL "none")\n    return()\nendif()'
        text = text.replace(marker, insertion)
    presentation.write_text(text, encoding="utf-8")


def cmake_common_args(build_dir, dynamic_loader, single_config=True):
    args = [
        "cmake",
        "-S",
        sdk_dir,
        "-B",
        build_dir,
        "-DBUILD_API_LAYERS=OFF",
        "-DBUILD_TESTS=OFF",
        "-DBUILD_CONFORMANCE_TESTS=OFF",
        "-DBUILD_WITH_SYSTEM_JSONCPP=OFF",
        f"-DDYNAMIC_LOADER={'ON' if dynamic_loader else 'OFF'}",
    ]
    if single_config:
        args.insert(5, "-DCMAKE_BUILD_TYPE=Release")
    return args


def build_parallelism():
    return str(os.cpu_count() or 1)


def build_target(build_dir):
    run(["cmake", "--build", build_dir, "--parallel", build_parallelism(), "--config", "Release"])


def find_built_loader(build_dir, filename):
    candidates = [
        build_dir / "src" / "loader" / filename,
        build_dir / "src" / "loader" / "Release" / filename,
    ]
    for candidate in candidates:
        if candidate.exists():
            return candidate

    loader_dir = build_dir / "src" / "loader"
    if loader_dir.exists():
        for candidate in loader_dir.rglob(filename):
            return candidate

    raise FileNotFoundError(f"Could not find {filename} in {loader_dir}")


def copy_loader(build_dir, out_dir, filename):
    source = find_built_loader(build_dir, filename)
    dest_dir = repo_root / out_dir
    dest_dir.mkdir(parents=True, exist_ok=True)
    shutil.copy2(source, dest_dir / filename)


def prepare_cmake_build_dir(build_dir, generator):
    cache = build_dir / "CMakeCache.txt"
    if not cache.exists():
        return

    for line in cache.read_text(encoding="utf-8", errors="ignore").splitlines():
        if line.startswith("CMAKE_GENERATOR:INTERNAL="):
            cached_generator = line.split("=", 1)[1]
            if cached_generator != generator:
                shutil.rmtree(build_dir)
            return


def write_zig_toolchain(name, zig_target, system, processor):
    toolchain_dir = sdk_dir / "build_toolchains"
    toolchain_dir.mkdir(parents=True, exist_ok=True)
    toolchain = toolchain_dir / f"{name}.cmake"
    toolchain.write_text(
        "\n".join(
            [
                f"set(CMAKE_SYSTEM_NAME {system})",
                f"set(CMAKE_SYSTEM_PROCESSOR {processor})",
                "set(CMAKE_C_COMPILER zig)",
                "set(CMAKE_C_COMPILER_ARG1 cc)",
                "set(CMAKE_CXX_COMPILER zig)",
                "set(CMAKE_CXX_COMPILER_ARG1 c++)",
                f"set(CMAKE_C_COMPILER_TARGET {zig_target})",
                f"set(CMAKE_CXX_COMPILER_TARGET {zig_target})",
                "set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)",
                "",
            ]
        ),
        encoding="ascii",
    )
    return toolchain


def build_windows(name, config):
    if host_system() != "Windows":
        raise RuntimeError(f"{name} requires a Windows host with Visual Studio C++ tools installed")

    generator = find_visual_studio_generator()
    build_dir = sdk_dir / f"build_{name}_vs"
    prepare_cmake_build_dir(build_dir, generator)
    cmake_args = cmake_common_args(build_dir, dynamic_loader=False, single_config=False)
    cmake_args.extend(["-G", generator, "-A", config["vs_arch"]])

    run(cmake_args)
    build_target(build_dir)
    copy_loader(build_dir, name, config["file"])


def find_visual_studio_generator():
    result = subprocess.run(["cmake", "-G"], cwd=repo_root, text=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    output = result.stdout
    for generator in ("Visual Studio 18 2026", "Visual Studio 17 2022", "Visual Studio 16 2019"):
        if generator in output:
            return generator
    raise RuntimeError("CMake could not find a Visual Studio generator. Install Visual Studio C++ build tools.")


def is_native_shared_target(config):
    return config["system"] == host_system() and (
        (config["processor"] in ("x86_64", "AMD64") and host_arch() == "x64")
        or (config["processor"] in ("aarch64", "arm64") and host_arch() == "arm64")
    )


def build_shared(name, config):
    if is_native_shared_target(config):
        build_native_shared(name, config)
    else:
        build_zig_shared(name, config)


def build_native_shared(name, config):
    if config["system"] not in ("Linux", "Darwin"):
        raise RuntimeError(f"Native shared build is unsupported for {name}")

    build_dir = sdk_dir / f"build_{name}"
    cmake_args = cmake_common_args(build_dir, dynamic_loader=True)
    run(cmake_args)
    build_target(build_dir)
    copy_loader(build_dir, name, config["file"])


def build_zig_shared(name, config):
    if not command_exists("zig"):
        raise RuntimeError(f"{name} requires zig on PATH for cross-compilation")

    build_dir = sdk_dir / f"build_{name}_zig"
    toolchain = write_zig_toolchain(
        config["zig_target"],
        config["zig_target"],
        config["system"],
        config["processor"],
    )
    cmake_args = cmake_common_args(build_dir, dynamic_loader=True)
    cmake_args.extend(["-G", "Ninja"])
    if not (build_dir / "CMakeCache.txt").exists():
        cmake_args.append(f"-DCMAKE_TOOLCHAIN_FILE={toolchain}")
    if config["system"] == "Linux":
        cmake_args.append("-DPRESENTATION_BACKEND=none")

    run(cmake_args)
    build_target(build_dir)
    copy_loader(build_dir, name, config["file"])


def parse_args():
    parser = argparse.ArgumentParser(description="Build vendored OpenXR loader binaries.")
    parser.add_argument("targets", nargs="*", help="Targets to build")
    parser.add_argument("--all", action="store_true", help="Build every target supported by this host")
    parser.add_argument("--list-targets", action="store_true", help="List target names and exit")
    parser.add_argument("--sdk-revision", default=SDK_REVISION, help="OpenXR-SDK git revision to build")
    return parser.parse_args()


def main():
    args = parse_args()
    if args.list_targets:
        print("\n".join(TARGETS.keys()))
        return

    targets = default_targets() if args.all else (args.targets or default_targets())
    if not targets:
        raise RuntimeError("Could not infer a default target for this host. Pass an explicit target.")
    unknown_targets = [target for target in targets if target not in TARGETS]
    if unknown_targets:
        known_targets = ", ".join(TARGETS.keys())
        raise RuntimeError(f"Unknown target(s): {', '.join(unknown_targets)}. Known targets: {known_targets}")

    needs_linux_loader_only_patch = any(
        TARGETS[target]["system"] == "Linux" and not is_native_shared_target(TARGETS[target])
        for target in targets
    )
    ensure_sdk(args.sdk_revision, needs_linux_loader_only_patch)

    for target in targets:
        config = TARGETS[target]
        if config["kind"] == "windows":
            build_windows(target, config)
        elif config["kind"] == "shared":
            build_shared(target, config)
        else:
            raise RuntimeError(f"Unknown target kind {config['kind']}")

    print("Build completed successfully.")


if __name__ == "__main__":
    try:
        main()
    except subprocess.CalledProcessError as exc:
        sys.exit(exc.returncode)
    except Exception as exc:
        print(f"ERROR: {exc}", file=sys.stderr)
        sys.exit(1)
