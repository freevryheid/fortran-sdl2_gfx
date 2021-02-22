# fortran-sdl2_gfx
Fortran bindings for SDL2_gfx (https://www.ferzkopp.net/Software/SDL2_gfx/Docs/html/index.html) to be used in conjunction with: https://github.com/interkosmos/fortran-sdl2

STILL UNDER HEAVY CONSTRUCTION!!!

## Progress

* Graphic Primitives ✓
* Surface Rotozoomer
* Framerate control
* MMX image filters
* Build-in 8x8 Font
* Documentation
* Example and test

## Build

I build and compile using meson. My fortran-sdl2 library is installed in my ~/.local folder. Set your PKG_CONFIG_PATH accordingly when calling meson.

```bash
[grassy@manjaro fortran-sdl2_gfx]$ rm -rf debug/
[grassy@manjaro fortran-sdl2_gfx]$ PKG_CONFIG_PATH=/home/grassy/.local/lib/pkgconfig meson debug
[grassy@manjaro fortran-sdl2_gfx]$ PKG_CONFIG_PATH=/home/grassy/.local/lib/pkgconfig meson compile -C debug
[grassy@manjaro fortran-sdl2_gfx]$ meson test -C debug
```

## Example

See example in the tst folder, that applies each of the gfx primitive functions:

<img src="png/example.png" alt="sdl2_gfx example" />
