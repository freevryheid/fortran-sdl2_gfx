# fortran-sdl2_gfx
Fortran bindings for SDL2_gfx

to be used in conjunction with: https://github.com/interkosmos/fortran-sdl2

STILL UNDER HEAVY CONSTRUCTION!!!

To test - build and compile using meson. Note: I've the fortran-sdl2 library in my local drive. Set your PKG_CONFIG_PATH accordingly:
```bash
[grassy@manjaro fortran-sdl2_gfx]$ PKG_CONFIG_PATH=/home/grassy/.local/lib/pkgconfig meson debug
Using 'PKG_CONFIG_PATH' from environment with value: '/home/grassy/.local/lib/pkgconfig'
Using 'PKG_CONFIG_PATH' from environment with value: '/home/grassy/.local/lib/pkgconfig'
The Meson build system
Version: 0.56.2
Source dir: /home/grassy/fortran/fortran-sdl2_gfx
Build dir: /home/grassy/fortran/fortran-sdl2_gfx/debug
Build type: native build
Project name: fortran-sdl_gfx
Project version: 0.1.0
Fortran compiler for the host machine: gfortran (gcc 10.2.0 "GNU Fortran (GCC) 10.2.0")
Fortran linker for the host machine: gfortran ld.bfd 2.36
Host machine cpu family: x86_64
Host machine cpu: x86_64
Found pkg-config: /usr/bin/pkg-config (1.7.3)
Using 'PKG_CONFIG_PATH' from environment with value: '/home/grassy/.local/lib/pkgconfig'
Run-time dependency fortran_sdl2 found: YES 1.0.0
Using 'PKG_CONFIG_PATH' from environment with value: '/home/grassy/.local/lib/pkgconfig'
Run-time dependency sdl2 found: YES 2.0.14
Build targets in project: 1

Found ninja-1.10.2 at /usr/bin/ninja
[grassy@manjaro fortran-sdl2_gfx]$ PKG_CONFIG_PATH=/home/grassy/.local/lib/pkgconfig meson compile -C debug
Found runner: ['/usr/bin/ninja']
ninja: Entering directory `debug'
[2/2] Linking static target src/libfortran-sdl_gfx.a
```

