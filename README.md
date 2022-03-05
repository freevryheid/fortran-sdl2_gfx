# fortran-sdl2_gfx
Fortran bindings for SDL2_gfx (https://www.ferzkopp.net/Software/SDL2_gfx/Docs/html/index.html) to be used in conjunction with: https://github.com/interkosmos/fortran-sdl2

## fpm build

fpm build

fpm run

Add the following to your fpm.toml file:

```
[build]
link = ["SDL2", "SDL2_gfx"]
[dependencies]
fortran-sdl2.git = "https://github.com/interkosmos/fortran-sdl2.git"
fortran-sdl2_gfx.git = "https://github.com/freevryheid/fortran-sdl2_gfx.git"
```

## example

The app applies each of the gfx primitive functions:

<img src="data/example.png" alt="sdl2_gfx example" />
