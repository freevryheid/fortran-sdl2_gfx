! /*

! SDL2_gfxPrimitives.h: graphics primitives for SDL

! Copyright (C) 2012-2014  Andreas Schiffler

! This software is provided 'as-is', without any express or implied
! warranty. In no event will the authors be held liable for any damages
! arising from the use of this software.

! Permission is granted to anyone to use this software for any purpose,
! including commercial applications, and to alter it and redistribute it
! freely, subject to the following restrictions:

! 1. The origin of this software must not be misrepresented; you must not
! claim that you wrote the original software. If you use this software
! in a product, an acknowledgment in the product documentation would be
! appreciated but is not required.

! 2. Altered source versions must be plainly marked as such, and must not be
! misrepresented as being the original software.

! 3. This notice may not be removed or altered from any source
! distribution.

! Andreas Schiffler -- aschiffler at ferzkopp dot net

! Fortran bindings: Andre Smit  -- freevryheid at gmail dot com

module primitives

  use, intrinsic                                  :: iso_c_binding
  use                                             :: c_util
  use                                             :: sdl2_surface

  implicit none

! 	/* ----- Versioning */

! #define SDL2_GFXPRIMITIVES_MAJOR	1
  integer(kind=c_int), parameter                  :: SDL2_GFXPRIMITIVES_MAJOR = 1
! #define SDL2_GFXPRIMITIVES_MINOR	0
  integer(kind=c_int), parameter                  :: SDL2_GFXPRIMITIVES_MINOR = 0
! #define SDL2_GFXPRIMITIVES_MICRO	4
  integer(kind=c_int), parameter                  :: SDL2_GFXPRIMITIVES_MICRO = 4

  private
  public                                          :: pixel_color
  public                                          :: pixel_rgba
  public                                          :: hline_color
  public                                          :: hline_rgba
  public                                          :: vline_color
  public                                          :: vline_rgba
  public                                          :: rectangle_color
  public                                          :: rectangle_rgba
  public                                          :: rounded_rectangle_color
  public                                          :: rounded_rectangle_rgba
  public                                          :: box_color
  public                                          :: box_rgba
  public                                          :: rounded_box_color
  public                                          :: rounded_box_rgba
  public                                          :: line_color
  public                                          :: line_rgba
  public                                          :: aaline_color
  public                                          :: aaline_rgba
  public                                          :: thick_line_color
  public                                          :: thick_line_rgba
  public                                          :: circle_color
  public                                          :: circle_rgba
  public                                          :: arc_color
  public                                          :: arc_rgba
  public                                          :: aacircle_color
  public                                          :: aacircle_rgba
  public                                          :: filled_circle_color
  public                                          :: filled_circle_rgba
  public                                          :: ellipse_color
  public                                          :: ellipse_rgba
  public                                          :: aaellipse_color
  public                                          :: aaellipse_rgba
  public                                          :: filled_ellipse_color
  public                                          :: filled_ellipse_rgba
  public                                          :: pie_color
  public                                          :: pie_rgba
  public                                          :: filled_pie_color
  public                                          :: filled_pie_rgba
  public                                          :: trigon_color
  public                                          :: trigon_rgba
  public                                          :: aatrigon_color
  public                                          :: aatrigon_rgba
  public                                          :: filled_trigon_color
  public                                          :: filled_trigon_rgba
  public                                          :: polygon_color
  public                                          :: polygon_rgba
  public                                          :: aapolygon_color
  public                                          :: aapolygon_rgba
  public                                          :: filled_polygon_color
  public                                          :: filled_polygon_rgba
  public                                          :: textured_polygon
  public                                          :: bezier_color
  public                                          :: bezier_rgba
  public                                          :: gfx_primitives_set_font
  public                                          :: gfx_primitives_set_font_rotation
  public                                          :: character_color
  public                                          :: character_rgba
  public                                          :: string_color
  public                                          :: string_rgba

! 	/* Note: all ___Color routines expect the color to be in format 0xRRGGBBAA */

  interface

! 	/* Pixel */

! 	SDL2_GFXPRIMITIVES_SCOPE int pixelColor(SDL_Renderer * renderer, Sint16 x, Sint16 y, Uint32 color);
    function pixel_color(renderer, x, y, color) bind(c, name='pixelColor')
      ! Draw pixel with blending enabled if a<255.
      import                                      :: c_ptr, c_short, c_uint32_t, c_int
      type(c_ptr),              intent(in), value :: renderer
      integer(kind=c_short),    intent(in), value :: x, y
      integer(kind=c_uint32_t), intent(in), value :: color
      integer(kind=c_int)                         :: pixel_color
    end function pixel_color

! 	SDL2_GFXPRIMITIVES_SCOPE int pixelRGBA(SDL_Renderer * renderer, Sint16 x, Sint16 y, Uint8 r, Uint8 g, Uint8 b, Uint8 a);
    function pixel_rgba(renderer, x, y, r, g, b, a) bind(c, name='pixelRGBA')
      ! Draw pixel with blending enabled if a<255.
      import                                      :: c_ptr, c_short, c_uint8_t, c_int
      type(c_ptr),              intent(in), value :: renderer
      integer(kind=c_short),    intent(in), value :: x, y
      integer(kind=c_uint8_t),  intent(in), value :: r, g, b, a
      integer(kind=c_int)                         :: pixel_rgba
    end function pixel_rgba

! 	/* Horizontal line */

! 	SDL2_GFXPRIMITIVES_SCOPE int hlineColor(SDL_Renderer * renderer, Sint16 x1, Sint16 x2, Sint16 y, Uint32 color);
    function hline_color(renderer, x1, x2, y, color) bind(c, name='hlineColor')
      ! Draw horizontal line with blending.
      import                                      :: c_ptr, c_short, c_uint32_t, c_int
      type(c_ptr),              intent(in), value :: renderer
      integer(kind=c_short),    intent(in), value :: x1, x2, y
      integer(kind=c_uint32_t), intent(in), value :: color
      integer(kind=c_int)                         :: hline_color
    end function hline_color

! 	SDL2_GFXPRIMITIVES_SCOPE int hlineRGBA(SDL_Renderer * renderer, Sint16 x1, Sint16 x2, Sint16 y, Uint8 r, Uint8 g, Uint8 b, Uint8 a);
    function hline_rgba(renderer, x1, x2, y, r, g, b, a) bind(c, name='hlineRGBA')
      ! Draw horizontal line with blending.
      import                                      :: c_ptr, c_short, c_uint8_t, c_int
      type(c_ptr),              intent(in), value :: renderer
      integer(kind=c_short),    intent(in), value :: x1, x2, y
      integer(kind=c_uint8_t),  intent(in), value :: r, g, b, a
      integer(kind=c_int)                         :: hline_rgba
    end function hline_rgba

! 	/* Vertical line */

! 	SDL2_GFXPRIMITIVES_SCOPE int vlineColor(SDL_Renderer * renderer, Sint16 x, Sint16 y1, Sint16 y2, Uint32 color);
    function vline_color(renderer, x, y1, y2, color) bind(c, name='vlineColor')
      import                                      :: c_ptr, c_short, c_uint32_t, c_int
      type(c_ptr),              intent(in), value :: renderer
      integer(kind=c_short),    intent(in), value :: x, y1, y2
      integer(kind=c_uint32_t), intent(in), value :: color
      integer(kind=c_int)                         :: vline_color
    end function vline_color

! 	SDL2_GFXPRIMITIVES_SCOPE int vlineRGBA(SDL_Renderer * renderer, Sint16 x, Sint16 y1, Sint16 y2, Uint8 r, Uint8 g, Uint8 b, Uint8 a);
    function vline_rgba(renderer, x, y1, y2, r, g, b, a) bind(c, name='vlineRGBA')
      import                                      :: c_ptr, c_short, c_uint8_t, c_int
      type(c_ptr),              intent(in), value :: renderer
      integer(kind=c_short),    intent(in), value :: x, y1, y2
      integer(kind=c_uint8_t),  intent(in), value :: r, g, b, a
      integer(kind=c_int)                         :: vline_rgba
    end function vline_rgba

! 	/* Rectangle */

! 	SDL2_GFXPRIMITIVES_SCOPE int rectangleColor(SDL_Renderer * renderer, Sint16 x1, Sint16 y1, Sint16 x2, Sint16 y2, Uint32 color);
    function rectangle_color(renderer, x1, y1, x2, y2, color) bind(c, name='rectangleColor')
      import                                      :: c_ptr, c_short, c_uint32_t, c_int
      type(c_ptr),              intent(in), value :: renderer
      integer(kind=c_short),    intent(in), value :: x1, y1, x2, y2
      integer(kind=c_uint32_t), intent(in), value :: color
      integer(kind=c_int)                         :: rectangle_color
    end function rectangle_color

! 	SDL2_GFXPRIMITIVES_SCOPE int rectangleRGBA(SDL_Renderer * renderer, Sint16 x1, Sint16 y1, Sint16 x2, Sint16 y2, Uint8 r, Uint8 g, Uint8 b, Uint8 a);
    function rectangle_rgba(renderer, x1, y1, x2, y2, r, g, b, a) bind(c, name='rectangleRGBA')
      import                                      :: c_ptr, c_short, c_uint8_t, c_int
      type(c_ptr),              intent(in), value :: renderer
      integer(kind=c_short),    intent(in), value :: x1, y1, x2, y2
      integer(kind=c_uint8_t),  intent(in), value :: r, g, b, a
      integer(kind=c_int)                         :: rectangle_rgba
    end function rectangle_rgba

! 	/* Rounded-Corner Rectangle */

! 	SDL2_GFXPRIMITIVES_SCOPE int roundedRectangleColor(SDL_Renderer * renderer, Sint16 x1, Sint16 y1, Sint16 x2, Sint16 y2, Sint16 rad, Uint32 color);
    function rounded_rectangle_color(renderer, x1, y1, x2, y2, rad, color) bind(c, name='roundedRectangleColor')
      import                                      :: c_ptr, c_short, c_uint32_t, c_int
      type(c_ptr),              intent(in), value :: renderer
      integer(kind=c_short),    intent(in), value :: x1, y1, x2, y2, rad
      integer(kind=c_uint32_t), intent(in), value :: color
      integer(kind=c_int)                         :: rounded_rectangle_color
    end function rounded_rectangle_color

! 	SDL2_GFXPRIMITIVES_SCOPE int roundedRectangleRGBA(SDL_Renderer * renderer, Sint16 x1, Sint16 y1, Sint16 x2, Sint16 y2, Sint16 rad, Uint8 r, Uint8 g, Uint8 b, Uint8 a);
    function rounded_rectangle_rgba(renderer, x1, y1, x2, y2, rad, r, g, b, a) bind(c, name='roundedRectangleRGBA')
      import                                      :: c_ptr, c_short, c_uint8_t, c_int
      type(c_ptr),              intent(in), value :: renderer
      integer(kind=c_short),    intent(in), value :: x1, y1, x2, y2, rad
      integer(kind=c_uint8_t),  intent(in), value :: r, g, b, a
      integer(kind=c_int)                         :: rounded_rectangle_rgba
    end function rounded_rectangle_rgba

! 	/* Filled rectangle (Box) */

! 	SDL2_GFXPRIMITIVES_SCOPE int boxColor(SDL_Renderer * renderer, Sint16 x1, Sint16 y1, Sint16 x2, Sint16 y2, Uint32 color);
    function box_color(renderer, x1, y1, x2, y2, color) bind(c, name='boxColor')
      import                                      :: c_ptr, c_short, c_uint32_t, c_int
      type(c_ptr),              intent(in), value :: renderer
      integer(kind=c_short),    intent(in), value :: x1, y1, x2, y2
      integer(kind=c_uint32_t), intent(in), value :: color
      integer(kind=c_int)                         :: box_color
    end function box_color

! 	SDL2_GFXPRIMITIVES_SCOPE int boxRGBA(SDL_Renderer * renderer, Sint16 x1, Sint16 y1, Sint16 x2,	Sint16 y2, Uint8 r, Uint8 g, Uint8 b, Uint8 a);
    function box_rgba(renderer, x1, y1, x2, y2, r, g, b, a) bind(c, name='boxRGBA')
      import                                      :: c_ptr, c_short, c_uint8_t, c_int
      type(c_ptr),              intent(in), value :: renderer
      integer(kind=c_short),    intent(in), value :: x1, y1, x2, y2
      integer(kind=c_uint8_t),  intent(in), value :: r, g, b, a
      integer(kind=c_int)                         :: box_rgba
    end function box_rgba

! 	/* Rounded-Corner Filled rectangle (Box) */

! 	SDL2_GFXPRIMITIVES_SCOPE int roundedBoxColor(SDL_Renderer * renderer, Sint16 x1, Sint16 y1, Sint16 x2, Sint16 y2, Sint16 rad, Uint32 color);
    function rounded_box_color(renderer, x1, y1, x2, y2, rad, color) bind(c, name='roundedBoxColor')
      import                                      :: c_ptr, c_short, c_uint32_t, c_int
      type(c_ptr),              intent(in), value :: renderer
      integer(kind=c_short),    intent(in), value :: x1, y1, x2, y2, rad
      integer(kind=c_uint32_t), intent(in), value :: color
      integer(kind=c_int)                         :: rounded_box_color
    end function rounded_box_color

! 	SDL2_GFXPRIMITIVES_SCOPE int roundedBoxRGBA(SDL_Renderer * renderer, Sint16 x1, Sint16 y1, Sint16 x2,i	Sint16 y2, Sint16 rad, Uint8 r, Uint8 g, Uint8 b, Uint8 a);
    function rounded_box_rgba(renderer, x1, y1, x2, y2, rad, r, g, b, a) bind(c, name='roundedBoxRGBA')
      import                                      :: c_ptr, c_short, c_uint8_t, c_int
      type(c_ptr),              intent(in), value :: renderer
      integer(kind=c_short),    intent(in), value :: x1, y1, x2, y2, rad
      integer(kind=c_uint8_t),  intent(in), value :: r, g, b, a
      integer(kind=c_int)                         :: rounded_box_rgba
    end function rounded_box_rgba

! 	/* Line */

! 	SDL2_GFXPRIMITIVES_SCOPE int lineColor(SDL_Renderer * renderer, Sint16 x1, Sint16 y1, Sint16 x2, Sint16 y2, Uint32 color);
    function line_color(renderer, x1, y1, x2, y2, color) bind(c, name='lineColor')
      import                                      :: c_ptr, c_short, c_uint32_t, c_int
      type(c_ptr),              intent(in), value :: renderer
      integer(kind=c_short),    intent(in), value :: x1, y1, x2, y2
      integer(kind=c_uint32_t), intent(in), value :: color
      integer(kind=c_int)                         :: line_color
    end function line_color

! 	SDL2_GFXPRIMITIVES_SCOPE int lineRGBA(SDL_Renderer * renderer, Sint16 x1, Sint16 y1,	Sint16 x2, Sint16 y2, Uint8 r, Uint8 g, Uint8 b, Uint8 a);
    function line_rgba(renderer, x1, y1, x2, y2, r, g, b, a) bind(c, name='lineRGBA')
      import                                      :: c_ptr, c_short, c_uint8_t, c_int
      type(c_ptr),              intent(in), value :: renderer
      integer(kind=c_short),    intent(in), value :: x1, y1, x2, y2
      integer(kind=c_uint8_t),  intent(in), value :: r, g, b, a
      integer(kind=c_int)                         :: line_rgba
    end function line_rgba

! 	/* AA Line */

! 	SDL2_GFXPRIMITIVES_SCOPE int aalineColor(SDL_Renderer * renderer, Sint16 x1, Sint16 y1, Sint16 x2, Sint16 y2, Uint32 color);
    function aaline_color(renderer, x1, y1, x2, y2, color) bind(c, name='aalineColor')
      import                                      :: c_ptr, c_short, c_uint32_t, c_int
      type(c_ptr),              intent(in), value :: renderer
      integer(kind=c_short),    intent(in), value :: x1, y1, x2, y2
      integer(kind=c_uint32_t), intent(in), value :: color
      integer(kind=c_int)                         :: aaline_color
    end function aaline_color

! 	SDL2_GFXPRIMITIVES_SCOPE int aalineRGBA(SDL_Renderer * renderer, Sint16 x1, Sint16 y1, Sint16 x2, Sint16 y2, Uint8 r, Uint8 g, Uint8 b, Uint8 a);
    function aaline_rgba(renderer, x1, y1, x2, y2, r, g, b, a) bind(c, name='aalineRGBA')
      import                                      :: c_ptr, c_short, c_uint8_t, c_int
      type(c_ptr),              intent(in), value :: renderer
      integer(kind=c_short),    intent(in), value :: x1, y1, x2, y2
      integer(kind=c_uint8_t),  intent(in), value :: r, g, b, a
      integer(kind=c_int)                         :: aaline_rgba
    end function aaline_rgba

! 	/* Thick Line */

! 	SDL2_GFXPRIMITIVES_SCOPE int thickLineColor(SDL_Renderer * renderer, Sint16 x1, Sint16 y1, Sint16 x2, Sint16 y2, Uint8 width, Uint32 color);
    function thick_line_color(renderer, x1, y1, x2, y2, width, color) bind(c, name='thickLineColor')
      import                                      :: c_ptr, c_short, c_uint8_t, c_uint32_t, c_int
      type(c_ptr),              intent(in), value :: renderer
      integer(kind=c_short),    intent(in), value :: x1, y1, x2, y2
      integer(kind=c_uint8_t),  intent(in), value :: width
      integer(kind=c_uint32_t), intent(in), value :: color
      integer(kind=c_int)                         :: thick_line_color
    end function thick_line_color

! 	SDL2_GFXPRIMITIVES_SCOPE int thickLineRGBA(SDL_Renderer * renderer, Sint16 x1, Sint16 y1, Sint16 x2, Sint16 y2,	Uint8 width, Uint8 r, Uint8 g, Uint8 b, Uint8 a);
    function thick_line_rgba(renderer, x1, y1, x2, y2, width, r, g, b, a) bind(c, name='thickLineRGBA')
      import                                      :: c_ptr, c_short, c_uint8_t, c_int
      type(c_ptr),              intent(in), value :: renderer
      integer(kind=c_short),    intent(in), value :: x1, y1, x2, y2
      integer(kind=c_uint8_t),  intent(in), value :: width, r, g, b, a
      integer(kind=c_int)                         :: thick_line_rgba
    end function thick_line_rgba

! 	/* Circle */

! 	SDL2_GFXPRIMITIVES_SCOPE int circleColor(SDL_Renderer * renderer, Sint16 x, Sint16 y, Sint16 rad, Uint32 color);
    function circle_color(renderer, x, y, rad, color) bind(c, name='circleColor')
      import                                      :: c_ptr, c_short, c_uint32_t, c_int
      type(c_ptr),              intent(in), value :: renderer
      integer(kind=c_short),    intent(in), value :: x, y, rad
      integer(kind=c_uint32_t), intent(in), value :: color
      integer(kind=c_int)                         :: circle_color
    end function circle_color

! 	SDL2_GFXPRIMITIVES_SCOPE int circleRGBA(SDL_Renderer * renderer, Sint16 x, Sint16 y, Sint16 rad, Uint8 r, Uint8 g, Uint8 b, Uint8 a);
    function circle_rgba(renderer, x, y, rad, r, g, b, a) bind(c, name='circleRGBA')
      import                                      :: c_ptr, c_short, c_uint8_t, c_int
      type(c_ptr),              intent(in), value :: renderer
      integer(kind=c_short),    intent(in), value :: x, y, rad
      integer(kind=c_uint8_t),  intent(in), value :: r, g, b, a
      integer(kind=c_int)                         :: circle_rgba
    end function circle_rgba

! 	/* Arc */

! 	SDL2_GFXPRIMITIVES_SCOPE int arcColor(SDL_Renderer * renderer, Sint16 x, Sint16 y, Sint16 rad, Sint16 start, Sint16 end, Uint32 color);
    function arc_color(renderer, x, y, rad, from, to, color) bind(c, name='arcColor')
      import                                      :: c_ptr, c_short, c_uint32_t, c_int
      type(c_ptr),              intent(in), value :: renderer
      integer(kind=c_short),    intent(in), value :: x, y, rad, from, to
      integer(kind=c_uint32_t), intent(in), value :: color
      integer(kind=c_int)                         :: arc_color
    end function arc_color

! 	SDL2_GFXPRIMITIVES_SCOPE int arcRGBA(SDL_Renderer * renderer, Sint16 x, Sint16 y, Sint16 rad, Sint16 start, Sint16 end,	Uint8 r, Uint8 g, Uint8 b, Uint8 a);
    function arc_rgba(renderer, x, y, rad, from, to, r, g, b, a) bind(c, name='arcRGBA')
      import                                      :: c_ptr, c_short, c_uint8_t, c_int
      type(c_ptr),              intent(in), value :: renderer
      integer(kind=c_short),    intent(in), value :: x, y, rad, from, to
      integer(kind=c_uint8_t),  intent(in), value :: r, g, b, a
      integer(kind=c_int)                         :: arc_rgba
    end function arc_rgba

! 	/* AA Circle */

! 	SDL2_GFXPRIMITIVES_SCOPE int aacircleColor(SDL_Renderer * renderer, Sint16 x, Sint16 y, Sint16 rad, Uint32 color);
    function aacircle_color(renderer, x, y, rad, color) bind(c, name='aacircleColor')
      import                                      :: c_ptr, c_short, c_uint32_t, c_int
      type(c_ptr),              intent(in), value :: renderer
      integer(kind=c_short),    intent(in), value :: x, y, rad
      integer(kind=c_uint32_t), intent(in), value :: color
      integer(kind=c_int)                         :: aacircle_color
    end function aacircle_color

! 	SDL2_GFXPRIMITIVES_SCOPE int aacircleRGBA(SDL_Renderer * renderer, Sint16 x, Sint16 y, Sint16 rad, Uint8 r, Uint8 g, Uint8 b, Uint8 a);
    function aacircle_rgba(renderer, x, y, rad, r, g, b, a) bind(c, name='aacircleRGBA')
      import                                      :: c_ptr, c_short, c_uint8_t, c_int
      type(c_ptr),              intent(in), value :: renderer
      integer(kind=c_short),    intent(in), value :: x, y, rad
      integer(kind=c_uint8_t),  intent(in), value :: r, g, b, a
      integer(kind=c_int)                         :: aacircle_rgba
    end function aacircle_rgba

! 	/* Filled Circle */

! 	SDL2_GFXPRIMITIVES_SCOPE int filledCircleColor(SDL_Renderer * renderer, Sint16 x, Sint16 y, Sint16 r, Uint32 color);
    function filled_circle_color(renderer, x, y, rad, color) bind(c, name='filledCircleColor')
      import                                      :: c_ptr, c_short, c_uint32_t, c_int
      type(c_ptr),              intent(in), value :: renderer
      integer(kind=c_short),    intent(in), value :: x, y, rad
      integer(kind=c_uint32_t), intent(in), value :: color
      integer(kind=c_int)                         :: filled_circle_color
    end function filled_circle_color

! 	SDL2_GFXPRIMITIVES_SCOPE int filledCircleRGBA(SDL_Renderer * renderer, Sint16 x, Sint16 y, Sint16 rad, Uint8 r, Uint8 g, Uint8 b, Uint8 a);
    function filled_circle_rgba(renderer, x, y, rad, r, g, b, a) bind(c, name='filledCircleRGBA')
      import                                      :: c_ptr, c_short, c_uint8_t, c_int
      type(c_ptr),              intent(in), value :: renderer
      integer(kind=c_short),    intent(in), value :: x, y, rad
      integer(kind=c_uint8_t),  intent(in), value :: r, g, b, a
      integer(kind=c_int)                         :: filled_circle_rgba
    end function filled_circle_rgba

! 	/* Ellipse */

! 	SDL2_GFXPRIMITIVES_SCOPE int ellipseColor(SDL_Renderer * renderer, Sint16 x, Sint16 y, Sint16 rx, Sint16 ry, Uint32 color);
    function ellipse_color(renderer, x, y, rx, ry, color) bind(c, name='ellipseColor')
      import                                      :: c_ptr, c_short, c_uint32_t, c_int
      type(c_ptr),              intent(in), value :: renderer
      integer(kind=c_short),    intent(in), value :: x, y, rx, ry
      integer(kind=c_uint32_t), intent(in), value :: color
      integer(kind=c_int)                         :: ellipse_color
    end function ellipse_color

! 	SDL2_GFXPRIMITIVES_SCOPE int ellipseRGBA(SDL_Renderer * renderer, Sint16 x, Sint16 y, Sint16 rx, Sint16 ry, Uint8 r, Uint8 g, Uint8 b, Uint8 a);
    function ellipse_rgba(renderer, x, y, rx, ry, r, g, b, a) bind(c, name='ellipseRGBA')
      import                                      :: c_ptr, c_short, c_uint8_t, c_int
      type(c_ptr),              intent(in), value :: renderer
      integer(kind=c_short),    intent(in), value :: x, y, rx, ry
      integer(kind=c_uint8_t),  intent(in), value :: r, g, b, a
      integer(kind=c_int)                         :: ellipse_rgba
    end function ellipse_rgba

! 	/* AA Ellipse */

! 	SDL2_GFXPRIMITIVES_SCOPE int aaellipseColor(SDL_Renderer * renderer, Sint16 x, Sint16 y, Sint16 rx, Sint16 ry, Uint32 color);
    function aaellipse_color(renderer, x, y, rx, ry, color) bind(c, name='aaellipseColor')
      import                                      :: c_ptr, c_short, c_uint32_t, c_int
      type(c_ptr),              intent(in), value :: renderer
      integer(kind=c_short),    intent(in), value :: x, y, rx, ry
      integer(kind=c_uint32_t), intent(in), value :: color
      integer(kind=c_int)                         :: aaellipse_color
    end function aaellipse_color

! 	SDL2_GFXPRIMITIVES_SCOPE int aaellipseRGBA(SDL_Renderer * renderer, Sint16 x, Sint16 y, Sint16 rx, Sint16 ry, Uint8 r, Uint8 g, Uint8 b, Uint8 a);
    function aaellipse_rgba(renderer, x, y, rx, ry, r, g, b, a) bind(c, name='aaellipseRGBA')
      import                                      :: c_ptr, c_short, c_uint8_t, c_int
      type(c_ptr),              intent(in), value :: renderer
      integer(kind=c_short),    intent(in), value :: x, y, rx, ry
      integer(kind=c_uint8_t),  intent(in), value :: r, g, b, a
      integer(kind=c_int)                         :: aaellipse_rgba
    end function aaellipse_rgba

! 	/* Filled Ellipse */

! 	SDL2_GFXPRIMITIVES_SCOPE int filledEllipseColor(SDL_Renderer * renderer, Sint16 x, Sint16 y, Sint16 rx, Sint16 ry, Uint32lor);
    function filled_ellipse_color(renderer, x, y, rx, ry, color) bind(c, name='filledEllipseColor')
      import                                      :: c_ptr, c_short, c_uint32_t, c_int
      type(c_ptr),              intent(in), value :: renderer
      integer(kind=c_short),    intent(in), value :: x, y, rx, ry
      integer(kind=c_uint32_t), intent(in), value :: color
      integer(kind=c_int)                         :: filled_ellipse_color
    end function filled_ellipse_color

! 	SDL2_GFXPRIMITIVES_SCOPE int filledEllipseRGBA(SDL_Renderer * renderer, Sint16 x, Sint16 y,	Sint16 rx, Sint16 ry, Uint8 r, Uint8 g, Uint8 b, Uint8 a);
    function filled_ellipse_rgba(renderer, x, y, rx, ry, r, g, b, a) bind(c, name='filledEllipseRGBA')
      import                                      :: c_ptr, c_short, c_uint8_t, c_int
      type(c_ptr),              intent(in), value :: renderer
      integer(kind=c_short),    intent(in), value :: x, y, rx, ry
      integer(kind=c_uint8_t),  intent(in), value :: r, g, b, a
      integer(kind=c_int)                         :: filled_ellipse_rgba
    end function filled_ellipse_rgba

! 	/* Pie */

! 	SDL2_GFXPRIMITIVES_SCOPE int pieColor(SDL_Renderer * renderer, Sint16 x, Sint16 y, Sint16 rad, Sint16 start, Sint16 end, Uint32 color);
    function pie_color(renderer, x, y, rad, from, to, color) bind(c, name='pieColor')
      import                                      :: c_ptr, c_short, c_uint32_t, c_int
      type(c_ptr),              intent(in), value :: renderer
      integer(kind=c_short),    intent(in), value :: x, y, rad, from, to
      integer(kind=c_uint32_t), intent(in), value :: color
      integer(kind=c_int)                         :: pie_color
    end function pie_color

! 	SDL2_GFXPRIMITIVES_SCOPE int pieRGBA(SDL_Renderer * renderer, Sint16 x, Sint16 y, Sint16 rad,	Sint16 start, Sint16 end, Uint8 r, Uint8 g, Uint8 b, Uint8 a);
    function pie_rgba(renderer, x, y, rad, from, to, r, g, b, a) bind(c, name='pieRGBA')
      import                                      :: c_ptr, c_short, c_uint8_t, c_int
      type(c_ptr),              intent(in), value :: renderer
      integer(kind=c_short),    intent(in), value :: x, y, rad, from, to
      integer(kind=c_uint8_t),  intent(in), value :: r, g, b, a
      integer(kind=c_int)                         :: pie_rgba
    end function pie_rgba

! 	/* Filled Pie */

! 	SDL2_GFXPRIMITIVES_SCOPE int filledPieColor(SDL_Renderer * renderer, Sint16 x, Sint16 y, Sint16 rad, Sint16 start, Sint16 end, Uint32 color);
    function filled_pie_color(renderer, x, y, rad, from, to, color) bind(c, name='filledPieColor')
      import                                      :: c_ptr, c_short, c_uint32_t, c_int
      type(c_ptr),              intent(in), value :: renderer
      integer(kind=c_short),    intent(in), value :: x, y, rad, from, to
      integer(kind=c_uint32_t), intent(in), value :: color
      integer(kind=c_int)                         :: filled_pie_color
    end function filled_pie_color

! 	SDL2_GFXPRIMITIVES_SCOPE int filledPieRGBA(SDL_Renderer * renderer, Sint16 x, Sint16 y, Sint16 rad, Sint16 start, Sint16 end, Uint8 r, Uint8 g, Uint8 b, Uint8 a);
    function filled_pie_rgba(renderer, x, y, rad, from, to, r, g, b, a) bind(c, name='filledPieRGBA')
      import                                      :: c_ptr, c_short, c_uint8_t, c_int
      type(c_ptr),              intent(in), value :: renderer
      integer(kind=c_short),    intent(in), value :: x, y, rad, from, to
      integer(kind=c_uint8_t),  intent(in), value :: r, g, b, a
      integer(kind=c_int)                         :: filled_pie_rgba
    end function filled_pie_rgba

! 	/* Trigon */

! 	SDL2_GFXPRIMITIVES_SCOPE int trigonColor(SDL_Renderer * renderer, Sint16 x1, Sint16 y1, Sint16 x2, Sint16 y2, Sint16 x3, Sint16 y3, Uint32 color);
    function trigon_color(renderer, x1, y1, x2, y2, x3, y3, color) bind(c, name='trigonColor')
      import                                      :: c_ptr, c_short, c_uint32_t, c_int
      type(c_ptr),              intent(in), value :: renderer
      integer(kind=c_short),    intent(in), value :: x1, y1, x2, y2, x3, y3
      integer(kind=c_uint32_t), intent(in), value :: color
      integer(kind=c_int)                         :: trigon_color
    end function trigon_color

! 	SDL2_GFXPRIMITIVES_SCOPE int trigonRGBA(SDL_Renderer * renderer, Sint16 x1, Sint16 y1, Sint16 x2, Sint16 y2, Sint16 x3, Sint16 y3, Uint8 r, Uint8 g, Uint8 b, Uint8 a);
    function trigon_rgba(renderer, x1, y1, x2, y2, x3, y3, r, g, b, a) bind(c, name='trigonRGBA')
      import                                      :: c_ptr, c_short, c_uint8_t, c_int
      type(c_ptr),              intent(in), value :: renderer
      integer(kind=c_short),    intent(in), value :: x1, y1, x2, y2, x3, y3
      integer(kind=c_uint8_t),  intent(in), value :: r, g, b, a
      integer(kind=c_int)                         :: trigon_rgba
    end function trigon_rgba

! 	/* AA-Trigon */

! 	SDL2_GFXPRIMITIVES_SCOPE int aatrigonColor(SDL_Renderer * renderer, Sint16 x1, Sint16 y1, Sint16 x2, Sint16 y2, Sint16 x3, Sint16 y3, Uint32 color);
    function aatrigon_color(renderer, x1, y1, x2, y2, x3, y3, color) bind(c, name='aatrigonColor')
      import                                      :: c_ptr, c_short, c_uint32_t, c_int
      type(c_ptr),              intent(in), value :: renderer
      integer(kind=c_short),    intent(in), value :: x1, y1, x2, y2, x3, y3
      integer(kind=c_uint32_t), intent(in), value :: color
      integer(kind=c_int)                         :: aatrigon_color
    end function aatrigon_color

! 	SDL2_GFXPRIMITIVES_SCOPE int aatrigonRGBA(SDL_Renderer * renderer,  Sint16 x1, Sint16 y1, Sint16 x2, Sint16 y2, Sint16 x3, Sint16 y3,	Uint8 r, Uint8 g, Uint8 b, Uint8 a);
    function aatrigon_rgba(renderer, x1, y1, x2, y2, x3, y3, r, g, b, a) bind(c, name='aatrigonRGBA')
      import                                      :: c_ptr, c_short, c_uint8_t, c_int
      type(c_ptr),              intent(in), value :: renderer
      integer(kind=c_short),    intent(in), value :: x1, y1, x2, y2, x3, y3
      integer(kind=c_uint8_t),  intent(in), value :: r, g, b, a
      integer(kind=c_int)                         :: aatrigon_rgba
    end function aatrigon_rgba

! 	/* Filled Trigon */

! 	SDL2_GFXPRIMITIVES_SCOPE int filledTrigonColor(SDL_Renderer * renderer, Sint16 x1, Sint16 y1, Sint16 x2, Sint16 y2, Sint16 x3, Sint16 y3, Uint32 color);
    function filled_trigon_color(renderer, x1, y1, x2, y2, x3, y3, color) bind(c, name='filledTrigonColor')
      import                                      :: c_ptr, c_short, c_uint32_t, c_int
      type(c_ptr),              intent(in), value :: renderer
      integer(kind=c_short),    intent(in), value :: x1, y1, x2, y2, x3, y3
      integer(kind=c_uint32_t), intent(in), value :: color
      integer(kind=c_int)                         :: filled_trigon_color
    end function filled_trigon_color

! 	SDL2_GFXPRIMITIVES_SCOPE int filledTrigonRGBA(SDL_Renderer * renderer, Sint16 x1, Sint16 y1, Sint16 x2, Sint16 y2, Sint16 x3, Sint16 y3, Uint8 r, Uint8 g, Uint8 b, Uint8 a);
    function filled_trigon_rgba(renderer, x1, y1, x2, y2, x3, y3, r, g, b, a) bind(c, name='filledTrigonRGBA')
      import                                      :: c_ptr, c_short, c_uint8_t, c_int
      type(c_ptr),              intent(in), value :: renderer
      integer(kind=c_short),    intent(in), value :: x1, y1, x2, y2, x3, y3
      integer(kind=c_uint8_t),  intent(in), value :: r, g, b, a
      integer(kind=c_int)                         :: filled_trigon_rgba
    end function filled_trigon_rgba

! 	/* Polygon */

! 	SDL2_GFXPRIMITIVES_SCOPE int polygonColor(SDL_Renderer * renderer, const Sint16 * vx, const Sint16 * vy, int n, Uint32 color);
    function polygon_color(renderer, vx, vy, n, color) bind(c, name='polygonColor')
      import                                      :: c_ptr, c_short, c_uint32_t, c_int
      type(c_ptr),              intent(in), value :: renderer
      integer(kind=c_short),    intent(in)        :: vx(*), vy(*)
      integer(kind=c_int),      intent(in), value :: n
      integer(kind=c_uint32_t), intent(in), value :: color
      integer(kind=c_int)                         :: polygon_color
    end function polygon_color

! 	SDL2_GFXPRIMITIVES_SCOPE int polygonRGBA(SDL_Renderer * renderer, const Sint16 * vx, const Sint16 * vy,	int n, Uint8 r, Uint8 g, Uint8 b, Uint8 a);
    function polygon_rgba(renderer, vx, vy, n, r, g, b, a) bind(c, name='polygonRGBA')
      import                                      :: c_ptr, c_short, c_uint8_t, c_int
      type(c_ptr),              intent(in), value :: renderer
      integer(kind=c_short),    intent(in)        :: vx(*), vy(*)
      integer(kind=c_int),      intent(in), value :: n
      integer(kind=c_uint8_t),  intent(in), value :: r, g, b, a
      integer(kind=c_int)                         :: polygon_rgba
    end function polygon_rgba

! 	/* AA-Polygon */

! 	SDL2_GFXPRIMITIVES_SCOPE int aapolygonColor(SDL_Renderer * renderer, const Sint16 * vx, const Sint16 * vy, int n, Uint32 color);
    function aapolygon_color(renderer, vx, vy, n, color) bind(c, name='aapolygonColor')
      import                                      :: c_ptr, c_short, c_uint32_t, c_int
      type(c_ptr),              intent(in), value :: renderer
      integer(kind=c_short),    intent(in)        :: vx(*), vy(*)
      integer(kind=c_int),      intent(in), value :: n
      integer(kind=c_uint32_t), intent(in), value :: color
      integer(kind=c_int)                         :: aapolygon_color
    end function aapolygon_color

! 	SDL2_GFXPRIMITIVES_SCOPE int aapolygonRGBA(SDL_Renderer * renderer, const Sint16 * vx, const Sint16 * vy,	int n, Uint8 r, Uint8 g, Uint8 b, Uint8 a);
    function aapolygon_rgba(renderer, vx, vy, n, r, g, b, a) bind(c, name='aapolygonRGBA')
      import                                      :: c_ptr, c_short, c_uint8_t, c_int
      type(c_ptr),              intent(in), value :: renderer
      integer(kind=c_short),    intent(in)        :: vx(*), vy(*)
      integer(kind=c_int),      intent(in), value :: n
      integer(kind=c_uint8_t),  intent(in), value :: r, g, b, a
      integer(kind=c_int)                         :: aapolygon_rgba
    end function aapolygon_rgba

! 	/* Filled Polygon */

! 	SDL2_GFXPRIMITIVES_SCOPE int filledPolygonColor(SDL_Renderer * renderer, const Sint16 * vx, const Sint16 * vy, int n, Uint32 color);
    function filled_polygon_color(renderer, vx, vy, n, color) bind(c, name='filledPolygonColor')
      import                                      :: c_ptr, c_short, c_uint32_t, c_int
      type(c_ptr),              intent(in), value :: renderer
      integer(kind=c_short),    intent(in)        :: vx(*), vy(*)
      integer(kind=c_int),      intent(in), value :: n
      integer(kind=c_uint32_t), intent(in), value :: color
      integer(kind=c_int)                         :: filled_polygon_color
    end function filled_polygon_color

! 	SDL2_GFXPRIMITIVES_SCOPE int filledPolygonRGBA(SDL_Renderer * renderer, const Sint16 * vx, const Sint16 * vy, int n, Uint8 r, Uint8 g, Uint8 b, Uint8 a);
    function filled_polygon_rgba(renderer, vx, vy, n, r, g, b, a) bind(c, name='filledPolygonRGBA')
      import                                      :: c_ptr, c_short, c_uint8_t, c_int
      type(c_ptr),              intent(in), value :: renderer
      integer(kind=c_short),    intent(in)        :: vx(*), vy(*)
      integer(kind=c_int),      intent(in), value :: n
      integer(kind=c_uint8_t),  intent(in), value :: r, g, b, a
      integer(kind=c_int)                         :: filled_polygon_rgba
    end function filled_polygon_rgba

! 	/* Textured Polygon */

! 	SDL2_GFXPRIMITIVES_SCOPE int texturedPolygon(SDL_Renderer * renderer, const Sint16 * vx, const Sint16 * vy, int n, SDL_Surface * texture,int texture_dx,int texture_dy);
    function textured_polygon(renderer, vx, vy, n, texture, texture_dx, texture_dy) bind(c, name='texturedPolygon')
      import                                      :: c_ptr, c_short, sdl_surface, c_int
      type(c_ptr),              intent(in), value :: renderer
      integer(kind=c_short),    intent(in)        :: vx(*), vy(*)
      integer(kind=c_int),      intent(in), value :: n, texture_dx, texture_dy
      type(sdl_surface),        intent(in) :: texture
      integer(kind=c_int)                         :: textured_polygon
    end function textured_polygon

! 	/* Bezier */

! 	SDL2_GFXPRIMITIVES_SCOPE int bezierColor(SDL_Renderer * renderer, const Sint16 * vx, const Sint16 * vy, int n, int s, Uint32 color);
    function bezier_color(renderer, vx, vy, n, s, color) bind(c, name='bezierColor')
      import                                      :: c_ptr, c_short, c_uint32_t, c_int
      type(c_ptr),              intent(in), value :: renderer
      integer(kind=c_short),    intent(in)        :: vx(*), vy(*)
      integer(kind=c_int),      intent(in), value :: n, s
      integer(kind=c_uint32_t), intent(in), value :: color
      integer(kind=c_int)                         :: bezier_color
    end function bezier_color

! 	SDL2_GFXPRIMITIVES_SCOPE int bezierRGBA(SDL_Renderer * renderer, const Sint16 * vx, const Sint16 * vy, int n, int s, Uint8 r, Uint8 g, Uint8 b, Uint8 a);
    function bezier_rgba(renderer, vx, vy, n, s, r, g, b, a) bind(c, name='bezierRGBA')
      import                                      :: c_ptr, c_short, c_uint8_t, c_int
      type(c_ptr),              intent(in), value :: renderer
      integer(kind=c_short),    intent(in)        :: vx(*), vy(*)
      integer(kind=c_int),      intent(in), value :: n, s
      integer(kind=c_uint8_t),  intent(in), value :: r, g, b, a
      integer(kind=c_int)                         :: bezier_rgba
    end function bezier_rgba

! 	/* Characters/Strings */

! 	SDL2_GFXPRIMITIVES_SCOPE void gfxPrimitivesSetFont(const void *fontdata, Uint32 cw, Uint32 ch);
    subroutine gfx_primitives_set_font(fontdata, cw, ch) bind(c, name='gfxPrimitivesSetFont')
      import                                      :: c_ptr, c_uint32_t
      type(c_ptr),              intent(in)        :: fontdata
      integer(kind=c_uint32_t), intent(in), value :: cw, ch
    end subroutine gfx_primitives_set_font

! 	SDL2_GFXPRIMITIVES_SCOPE void gfxPrimitivesSetFontRotation(Uint32 rotation);
    subroutine gfx_primitives_set_font_rotation(rotation) bind(c, name='gfxPrimitivesSetFontRotation')
      import                                      :: c_uint32_t
      integer(kind=c_uint32_t), intent(in), value :: rotation
    end subroutine gfx_primitives_set_font_rotation

! 	SDL2_GFXPRIMITIVES_SCOPE int characterColor(SDL_Renderer * renderer, Sint16 x, Sint16 y, char c, Uint32 color);
    function character_color(renderer, x, y, c, color) bind(c, name='characterColor')
      import                                      :: c_ptr, c_short, c_uint32_t, c_int, c_char
      type(c_ptr),              intent(in), value :: renderer
      integer(kind=c_short),    intent(in), value :: x, y
      character(kind=c_char),   intent(in)        :: c
      integer(kind=c_uint32_t), intent(in), value :: color
      integer(kind=c_int)                         :: character_color
    end function character_color

! 	SDL2_GFXPRIMITIVES_SCOPE int characterRGBA(SDL_Renderer * renderer, Sint16 x, Sint16 y, char c, Uint8 r, Uint8 g, Uint8 b, Uint8 a);
    function character_rgba(renderer, x, y, c, r, g, b, a) bind(c, name='characterRGBA')
      import                                      :: c_ptr, c_short, c_uint8_t, c_int, c_char
      type(c_ptr),              intent(in), value :: renderer
      integer(kind=c_short),    intent(in), value :: x, y
      character(kind=c_char),   intent(in)        :: c
      integer(kind=c_uint8_t),  intent(in), value :: r, g, b, a
      integer(kind=c_int)                         :: character_rgba
    end function character_rgba

! 	SDL2_GFXPRIMITIVES_SCOPE int stringColor(SDL_Renderer * renderer, Sint16 x, Sint16 y, const char *s, Uint32 color);
    function string_color(renderer, x, y, s, color) bind(c, name='stringColor')
      import                                      :: c_ptr, c_short, c_uint32_t, c_int, c_char
      type(c_ptr),              intent(in), value :: renderer
      integer(kind=c_short),    intent(in), value :: x, y
      character(kind=c_char),   intent(in)        :: s
      integer(kind=c_uint32_t), intent(in), value :: color
      integer(kind=c_int)                         :: string_color
    end function string_color

! 	SDL2_GFXPRIMITIVES_SCOPE int stringRGBA(SDL_Renderer * renderer, Sint16 x, Sint16 y, const char *s, Uint8 r, Uint8 g, Uint8 b, Uint8 a);
    function string_rgba(renderer, x, y, s, r, g, b, a) bind(c, name='stringRGBA')
      import                                      :: c_ptr, c_short, c_uint8_t, c_int, c_char
      type(c_ptr),              intent(in), value :: renderer
      integer(kind=c_short),    intent(in), value :: x, y
      character(kind=c_char),   intent(in)        :: s
      integer(kind=c_uint8_t),  intent(in), value :: r, g, b, a
      integer(kind=c_int)                         :: string_rgba
    end function string_rgba

  end interface

end module primitives
