module sdl2_gfx

use, intrinsic                               :: iso_c_binding,                                      &
  only : sdl => c_ptr,                                                &
  sdl_associated => c_associated,                                     &
  c_char
use                                          :: sdl2
use                                          :: primitives
use                                          :: framerate

implicit none

interface pixel
  module procedure pixel_color, pixel_rgba
end interface pixel

interface hline
  module procedure hline_color, hline_rgba
end interface hline

interface vline
  module procedure vline_color, vline_rgba
end interface vline

interface rectangle
  module procedure rectangle_color, rectangle_rgba
end interface rectangle

interface rounded_rectangle
  module procedure rounded_rectangle_color, rounded_rectangle_rgba
end interface rounded_rectangle

interface box
  module procedure box_color, box_rgba
end interface box

interface rounded_box
  module procedure rounded_box_color, rounded_box_rgba
end interface rounded_box

interface line
  module procedure line_color, line_rgba
end interface line

interface aaline
  module procedure aaline_color, aaline_rgba
end interface aaline

interface thick_line
  module procedure thick_line_color, thick_line_rgba
end interface thick_line

interface circle
  module procedure circle_color, circle_rgba
end interface circle

interface arc
  module procedure arc_color, arc_rgba
end interface arc

interface aacircle
  module procedure aacircle_color, aacircle_rgba
end interface aacircle

interface filled_circle
  module procedure filled_circle_color, filled_circle_rgba
end interface filled_circle

interface ellipse
  module procedure ellipse_color, ellipse_rgba
end interface ellipse

interface aaellipse
  module procedure aaellipse_color, aaellipse_rgba
end interface aaellipse

interface filled_ellipse
  module procedure filled_ellipse_color, filled_ellipse_rgba
end interface filled_ellipse

interface pie
  module procedure pie_color, pie_rgba
end interface pie

interface filled_pie
  module procedure filled_pie_color, filled_pie_rgba
end interface filled_pie

interface trigon
  module procedure trigon_color, trigon_rgba
end interface trigon

interface aatrigon
  module procedure aatrigon_color, aatrigon_rgba
end interface aatrigon

interface filled_trigon
  module procedure filled_trigon_color, filled_trigon_rgba
end interface filled_trigon

interface polygon
  module procedure polygon_color, polygon_rgba
end interface polygon

interface aapolygon
  module procedure aapolygon_color, aapolygon_rgba
end interface aapolygon

interface filled_polygon
  module procedure filled_polygon_color, filled_polygon_rgba
end interface filled_polygon

interface bezier
  module procedure bezier_color, bezier_rgba
end interface bezier

interface chars
  module procedure character_color, character_rgba
end interface chars

interface string
  module procedure string_color, string_rgba
end interface string

private

public                                       :: sdl ! these, just so that we don't have to use iso_c_binding again
public                                       :: sdl_associated
public                                       :: pixel
public                                       :: hline
public                                       :: vline
public                                       :: rectangle
public                                       :: rounded_rectangle
public                                       :: box
public                                       :: rounded_box
public                                       :: line
public                                       :: aaline
public                                       :: thick_line
public                                       :: circle
public                                       :: arc
public                                       :: aacircle
public                                       :: filled_circle
public                                       :: ellipse
public                                       :: aaellipse
public                                       :: filled_ellipse
public                                       :: pie
public                                       :: filled_pie
public                                       :: trigon
public                                       :: aatrigon
public                                       :: filled_trigon
public                                       :: polygon
public                                       :: aapolygon
public                                       :: filled_polygon
public                                       :: textured_polygon
public                                       :: bezier
public                                       :: set_font
public                                       :: set_font_rotation
public                                       :: chars
public                                       :: string
public                                       :: initframerate
public                                       :: setframerate
public                                       :: getframerate
public                                       :: getframecount
public                                       :: frameratedelay
public                                       :: c_str

contains

function c_str(fstr)

  character(len=*), intent(in)               :: fstr
  character(kind=c_char, len=:), allocatable :: c_str
  c_str = trim(fstr) // c_null_char

end function c_str

! Pixels

function pixel_color(renderer, x, y, color)

  type(sdl), intent(in)                      :: renderer
  integer, intent(in)                        :: x, y, color
  integer                                    :: pixel_color

  pixel_color =             int(gfx_pixel_color(renderer,             &
                            int(x, kind=c_short),                     &
                            int(y, kind=c_short),                     &
                            int(color, kind=c_uint32_t)))

end function pixel_color

function pixel_rgba(renderer, x, y, r, g, b, a)

  type(sdl), intent(in)                      :: renderer
  integer, intent(in)                        :: x, y, r, g, b, a
  integer                                    :: pixel_rgba

  pixel_rgba =              int(gfx_pixel_rgba(renderer,              &
                            int(x, kind=c_short),                     &
                            int(y, kind=c_short),                     &
                            int(r, kind=c_uint8_t),                   &
                            int(g, kind=c_uint8_t),                   &
                            int(b, kind=c_uint8_t),                   &
                            int(a, kind=c_uint8_t)))

end function pixel_rgba

! Horizontal line

function hline_color(renderer, x1, x2, y, color)

  type(sdl), intent(in)                      :: renderer
  integer, intent(in)                        :: x1, x2, y, color
  integer                                    :: hline_color

  hline_color =             int(gfx_hline_color(renderer,             &
                            int(x1, kind=c_short),                    &
                            int(x2, kind=c_short),                    &
                            int(y, kind=c_short),                     &
                            int(color, kind=c_uint32_t)))

end function hline_color

function hline_rgba(renderer, x1, x2, y, r, g, b, a)

  type(sdl), intent(in)                      :: renderer
  integer, intent(in)                        :: x1, x2, y, r, g, b, a
  integer                                    :: hline_rgba

  hline_rgba =              int(gfx_hline_rgba(renderer,              &
                            int(x1, kind=c_short),                    &
                            int(x2, kind=c_short),                    &
                            int(y, kind=c_short),                     &
                            int(r, kind=c_uint8_t),                   &
                            int(g, kind=c_uint8_t),                   &
                            int(b, kind=c_uint8_t),                   &
                            int(a, kind=c_uint8_t)))

end function hline_rgba

! Vertical line

function vline_color(renderer, x, y1, y2, color)

  type(sdl), intent(in)                      :: renderer
  integer, intent(in)                        :: x, y1, y2, color
  integer                                    :: vline_color

  vline_color =             int(gfx_vline_color(renderer,             &
                            int(x, kind=c_short),                     &
                            int(y1, kind=c_short),                    &
                            int(y2, kind=c_short),                    &
                            int(color, kind=c_uint32_t)))

end function vline_color

function vline_rgba(renderer, x, y1, y2, r, g, b, a)

  type(sdl), intent(in)                      :: renderer
  integer, intent(in)                        :: x, y1, y2, r, g, b, a
  integer                                    :: vline_rgba

  vline_rgba =              int(gfx_vline_rgba(renderer,              &
                            int(x, kind=c_short),                     &
                            int(y1, kind=c_short),                    &
                            int(y2, kind=c_short),                    &
                            int(r, kind=c_uint8_t),                   &
                            int(g, kind=c_uint8_t),                   &
                            int(b, kind=c_uint8_t),                   &
                            int(a, kind=c_uint8_t)))

end function vline_rgba

! Rectangle

function rectangle_color(renderer, x1, y1, x2, y2, color)

  type(sdl), intent(in)                      :: renderer
  integer, intent(in)                        :: x1, y1, x2, y2, color
  integer                                    :: rectangle_color

  rectangle_color =         int(gfx_rectangle_color(renderer,         &
                            int(x1, kind=c_short),                    &
                            int(y1, kind=c_short),                    &
                            int(x2, kind=c_short),                    &
                            int(y2, kind=c_short),                    &
                            int(color, kind=c_uint32_t)))

end function rectangle_color

function rectangle_rgba(renderer, x1, y1, x2, y2, r, g, b, a)

  type(sdl), intent(in)                      :: renderer
  integer, intent(in)                        :: x1, y1, x2, y2, r, g, b, a
  integer                                    :: rectangle_rgba

  rectangle_rgba =          int(gfx_rectangle_rgba(renderer,          &
                            int(x1, kind=c_short),                    &
                            int(y1, kind=c_short),                    &
                            int(x2, kind=c_short),                    &
                            int(y2, kind=c_short),                    &
                            int(r, kind=c_uint8_t),                   &
                            int(g, kind=c_uint8_t),                   &
                            int(b, kind=c_uint8_t),                   &
                            int(a, kind=c_uint8_t)))

end function rectangle_rgba

! Rounded-Corner Rectangle

function rounded_rectangle_color(renderer, x1, y1, x2, y2, rad, color)

  type(sdl), intent(in)                      :: renderer
  integer, intent(in)                        :: x1, y1, x2, y2, rad, color
  integer                                    :: rounded_rectangle_color

  rounded_rectangle_color = int(gfx_rounded_rectangle_color(renderer, &
                            int(x1, kind=c_short),                    &
                            int(y1, kind=c_short),                    &
                            int(x2, kind=c_short),                    &
                            int(y2, kind=c_short),                    &
                            int(rad, kind=c_short),                   &
                            int(color, kind=c_uint32_t)))

end function rounded_rectangle_color

function rounded_rectangle_rgba(renderer, x1, y1, x2, y2, rad, r, g, b, a)

  type(sdl), intent(in)                      :: renderer
  integer, intent(in)                        :: x1, y1, x2, y2, rad, r, g, b, a
  integer                                    :: rounded_rectangle_rgba

  rounded_rectangle_rgba =  int(gfx_rounded_rectangle_rgba(renderer,  &
                            int(x1, kind=c_short),                    &
                            int(y1, kind=c_short),                    &
                            int(x2, kind=c_short),                    &
                            int(y2, kind=c_short),                    &
                            int(rad, kind=c_short),                   &
                            int(r, kind=c_uint8_t),                   &
                            int(g, kind=c_uint8_t),                   &
                            int(b, kind=c_uint8_t),                   &
                            int(a, kind=c_uint8_t)))

end function rounded_rectangle_rgba

! Filled rectangle (Box)

function box_color(renderer, x1, y1, x2, y2, color)

  type(sdl), intent(in)                      :: renderer
  integer, intent(in)                        :: x1, y1, x2, y2, color
  integer                                    :: box_color

  box_color =               int(gfx_box_color(renderer,               &
                            int(x1, kind=c_short),                    &
                            int(y1, kind=c_short),                    &
                            int(x2, kind=c_short),                    &
                            int(y2, kind=c_short),                    &
                            int(color, kind=c_uint32_t)))

end function box_color

function box_rgba(renderer, x1, y1, x2, y2, r, g, b, a)

  type(sdl), intent(in)                      :: renderer
  integer, intent(in)                        :: x1, y1, x2, y2, r, g, b, a
  integer                                    :: box_rgba

  box_rgba=                 int(gfx_box_rgba(renderer,                &
                            int(x1, kind=c_short),                    &
                            int(y1, kind=c_short),                    &
                            int(x2, kind=c_short),                    &
                            int(y2, kind=c_short),                    &
                            int(r, kind=c_uint8_t),                   &
                            int(g, kind=c_uint8_t),                   &
                            int(b, kind=c_uint8_t),                   &
                            int(a, kind=c_uint8_t)))

end function box_rgba

! Rounded-Corner Filled rectangle (Box)

function rounded_box_color(renderer, x1, y1, x2, y2, rad, color)

  type(sdl), intent(in)                      :: renderer
  integer, intent(in)                        :: x1, y1, x2, y2, rad, color
  integer                                    :: rounded_box_color

  rounded_box_color =       int(gfx_rounded_box_color(renderer,       &
                            int(x1, kind=c_short),                    &
                            int(y1, kind=c_short),                    &
                            int(x2, kind=c_short),                    &
                            int(y2, kind=c_short),                    &
                            int(rad, kind=c_short),                   &
                            int(color, kind=c_uint32_t)))

end function rounded_box_color

function rounded_box_rgba(renderer, x1, y1, x2, y2, rad, r, g, b, a)

  type(sdl), intent(in)                      :: renderer
  integer, intent(in)                        :: x1, y1, x2, y2, rad, r, g, b, a
  integer                                    :: rounded_box_rgba

  rounded_box_rgba =        int(gfx_rounded_box_rgba(renderer,        &
                            int(x1, kind=c_short),                    &
                            int(y1, kind=c_short),                    &
                            int(x2, kind=c_short),                    &
                            int(y2, kind=c_short),                    &
                            int(rad, kind=c_short),                   &
                            int(r, kind=c_uint8_t),                   &
                            int(g, kind=c_uint8_t),                   &
                            int(b, kind=c_uint8_t),                   &
                            int(a, kind=c_uint8_t)))

end function rounded_box_rgba

! Line

function line_color(renderer, x1, y1, x2, y2, color)

  type(sdl), intent(in)                      :: renderer
  integer, intent(in)                        :: x1, y1, x2, y2, color
  integer                                    :: line_color

  line_color =              int(gfx_line_color(renderer,              &
                            int(x1, kind=c_short),                    &
                            int(y1, kind=c_short),                    &
                            int(x2, kind=c_short),                    &
                            int(y2, kind=c_short),                    &
                            int(color, kind=c_uint32_t)))

end function line_color

function line_rgba(renderer, x1, y1, x2, y2, r, g, b, a)

  type(sdl), intent(in)                      :: renderer
  integer, intent(in)                        :: x1, y1, x2, y2, r, g, b, a
  integer                                    :: line_rgba

  line_rgba =               int(gfx_line_rgba(renderer,               &
                            int(x1, kind=c_short),                    &
                            int(y1, kind=c_short),                    &
                            int(x2, kind=c_short),                    &
                            int(y2, kind=c_short),                    &
                            int(r, kind=c_uint8_t),                   &
                            int(g, kind=c_uint8_t),                   &
                            int(b, kind=c_uint8_t),                   &
                            int(a, kind=c_uint8_t)))

end function line_rgba

! AA Line

function aaline_color(renderer, x1, y1, x2, y2, color)

  type(sdl), intent(in)                      :: renderer
  integer, intent(in)                        :: x1, y1, x2, y2, color
  integer                                    :: aaline_color

  aaline_color =            int(gfx_aaline_color(renderer,            &
                            int(x1, kind=c_short),                    &
                            int(y1, kind=c_short),                    &
                            int(x2, kind=c_short),                    &
                            int(y2, kind=c_short),                    &
                            int(color, kind=c_uint32_t)))

end function aaline_color

function aaline_rgba(renderer, x1, y1, x2, y2, r, g, b, a)

  type(sdl), intent(in)                      :: renderer
  integer, intent(in)                        :: x1, y1, x2, y2, r, g, b, a
  integer                                    :: aaline_rgba

  aaline_rgba =             int(gfx_aaline_rgba(renderer,             &
                            int(x1, kind=c_short),                    &
                            int(y1, kind=c_short),                    &
                            int(x2, kind=c_short),                    &
                            int(y2, kind=c_short),                    &
                            int(r, kind=c_uint8_t),                   &
                            int(g, kind=c_uint8_t),                   &
                            int(b, kind=c_uint8_t),                   &
                            int(a, kind=c_uint8_t)))

end function aaline_rgba

! Thick Line

function thick_line_color(renderer, x1, y1, x2, y2, width, color)

  type(sdl), intent(in)                      :: renderer
  integer, intent(in)                        :: x1, y1, x2, y2, width, color
  integer                                    :: thick_line_color

  thick_line_color =        int(gfx_thick_line_color(renderer,        &
                            int(x1, kind=c_short),                    &
                            int(y1, kind=c_short),                    &
                            int(x2, kind=c_short),                    &
                            int(y2, kind=c_short),                    &
                            int(width, kind=c_uint8_t),               &
                            int(color, kind=c_uint32_t)))

end function thick_line_color

function thick_line_rgba(renderer, x1, y1, x2, y2, width, r, g, b, a)

  type(sdl), intent(in)                      :: renderer
  integer, intent(in)                        :: x1, y1, x2, y2, width, r, g, b, a
  integer                                    :: thick_line_rgba

  thick_line_rgba =         int(gfx_thick_line_rgba(renderer,         &
                            int(x1, kind=c_short),                    &
                            int(y1, kind=c_short),                    &
                            int(x2, kind=c_short),                    &
                            int(y2, kind=c_short),                    &
                            int(width, kind=c_uint8_t),               &
                            int(r, kind=c_uint8_t),                   &
                            int(g, kind=c_uint8_t),                   &
                            int(b, kind=c_uint8_t),                   &
                            int(a, kind=c_uint8_t)))

end function thick_line_rgba

! Circle

function circle_color(renderer, x, y, rad, color)

  type(sdl), intent(in)                      :: renderer
  integer, intent(in)                        :: x, y, rad, color
  integer                                    :: circle_color

  circle_color =            int(gfx_circle_color(renderer,            &
                            int(x, kind=c_short),                     &
                            int(y, kind=c_short),                     &
                            int(rad, kind=c_short),                   &
                            int(color, kind=c_uint32_t)))

end function circle_color

function circle_rgba(renderer, x, y, rad, r, g, b, a)

  type(sdl), intent(in)                      :: renderer
  integer, intent(in)                        :: x, y, rad, r, g, b, a
  integer                                    :: circle_rgba

  circle_rgba =             int(gfx_circle_rgba(renderer,             &
                            int(x, kind=c_short),                     &
                            int(y, kind=c_short),                     &
                            int(rad, kind=c_short),                   &
                            int(r, kind=c_uint8_t),                   &
                            int(g, kind=c_uint8_t),                   &
                            int(b, kind=c_uint8_t),                   &
                            int(a, kind=c_uint8_t)))

end function circle_rgba

! Arc

function arc_color(renderer, x, y, rad, from, to, color)

  type(sdl), intent(in)                      :: renderer
  integer, intent(in)                        :: x, y, rad, from, to, color
  integer                                    :: arc_color

  arc_color =               int(gfx_arc_color(renderer,               &
                            int(x, kind=c_short),                     &
                            int(y, kind=c_short),                     &
                            int(rad, kind=c_short),                   &
                            int(from, kind=c_short),                  &
                            int(to, kind=c_short),                    &
                            int(color, kind=c_uint32_t)))

end function arc_color

function arc_rgba(renderer, x, y, rad, from, to, r, g, b, a)

  type(sdl), intent(in)                      :: renderer
  integer, intent(in)                        :: x, y, rad, from, to, r, g, b, a
  integer                                    :: arc_rgba

  arc_rgba =                int(gfx_arc_rgba(renderer,                &
                            int(x, kind=c_short),                     &
                            int(y, kind=c_short),                     &
                            int(rad, kind=c_short),                   &
                            int(from, kind=c_short),                  &
                            int(to, kind=c_short),                    &
                            int(r, kind=c_uint8_t),                   &
                            int(g, kind=c_uint8_t),                   &
                            int(b, kind=c_uint8_t),                   &
                            int(a, kind=c_uint8_t)))

end function arc_rgba

! AA Circle

function aacircle_color(renderer, x, y, rad, color)

  type(sdl), intent(in)                      :: renderer
  integer, intent(in)                        :: x, y, rad, color
  integer                                    :: aacircle_color

  aacircle_color =          int(gfx_aacircle_color(renderer,          &
                            int(x, kind=c_short),                     &
                            int(y, kind=c_short),                     &
                            int(rad, kind=c_short),                   &
                            int(color, kind=c_uint32_t)))

end function aacircle_color

function aacircle_rgba(renderer, x, y, rad, r, g, b, a)

  type(sdl), intent(in)                      :: renderer
  integer, intent(in)                        :: x, y, rad, r, g, b, a
  integer                                    :: aacircle_rgba

  aacircle_rgba =           int(gfx_aacircle_rgba(renderer,           &
                            int(x, kind=c_short),                     &
                            int(y, kind=c_short),                     &
                            int(rad, kind=c_short),                   &
                            int(r, kind=c_uint8_t),                   &
                            int(g, kind=c_uint8_t),                   &
                            int(b, kind=c_uint8_t),                   &
                            int(a, kind=c_uint8_t)))

end function aacircle_rgba

! Filled Circle

function filled_circle_color(renderer, x, y, rad, color)

  type(sdl), intent(in)                      :: renderer
  integer, intent(in)                        :: x, y, rad, color
  integer                                    :: filled_circle_color

  filled_circle_color =     int(gfx_filled_circle_color(renderer,     &
                            int(x, kind=c_short),                     &
                            int(y, kind=c_short),                     &
                            int(rad, kind=c_short),                   &
                            int(color, kind=c_uint32_t)))

end function filled_circle_color

function filled_circle_rgba(renderer, x, y, rad, r, g, b, a)

  type(sdl), intent(in)                      :: renderer
  integer, intent(in)                        :: x, y, rad, r, g, b, a
  integer                                    :: filled_circle_rgba

  filled_circle_rgba =      int(gfx_filled_circle_rgba(renderer,      &
                            int(x, kind=c_short),                     &
                            int(y, kind=c_short),                     &
                            int(rad, kind=c_short),                   &
                            int(r, kind=c_uint8_t),                   &
                            int(g, kind=c_uint8_t),                   &
                            int(b, kind=c_uint8_t),                   &
                            int(a, kind=c_uint8_t)))

end function filled_circle_rgba

! Ellipse

function ellipse_color(renderer, x, y, rx, ry, color)

  type(sdl), intent(in)                      :: renderer
  integer, intent(in)                        :: x, y, rx, ry, color
  integer                                    :: ellipse_color

  ellipse_color =           int(gfx_ellipse_color(renderer,           &
                            int(x, kind=c_short),                     &
                            int(y, kind=c_short),                     &
                            int(rx, kind=c_short),                    &
                            int(ry, kind=c_short),                    &
                            int(color, kind=c_uint32_t)))

end function ellipse_color

function ellipse_rgba(renderer, x, y, rx, ry, r, g, b, a)

  type(sdl), intent(in)                      :: renderer
  integer, intent(in)                        :: x, y, rx, ry, r, g, b, a
  integer                                    :: ellipse_rgba

  ellipse_rgba =            int(gfx_ellipse_rgba(renderer,            &
                            int(x, kind=c_short),                     &
                            int(y, kind=c_short),                     &
                            int(rx, kind=c_short),                    &
                            int(ry, kind=c_short),                    &
                            int(r, kind=c_uint8_t),                   &
                            int(g, kind=c_uint8_t),                   &
                            int(b, kind=c_uint8_t),                   &
                            int(a, kind=c_uint8_t)))

end function ellipse_rgba

! AA Ellipse

function aaellipse_color(renderer, x, y, rx, ry, color)

  type(sdl), intent(in)                      :: renderer
  integer, intent(in)                        :: x, y, rx, ry, color
  integer                                    :: aaellipse_color

  aaellipse_color =         int(gfx_aaellipse_color(renderer,         &
                            int(x, kind=c_short),                     &
                            int(y, kind=c_short),                     &
                            int(rx, kind=c_short),                    &
                            int(ry, kind=c_short),                    &
                            int(color, kind=c_uint32_t)))

end function aaellipse_color

function aaellipse_rgba(renderer, x, y, rx, ry, r, g, b, a)

  type(sdl), intent(in)                      :: renderer
  integer, intent(in)                        :: x, y, rx, ry, r, g, b, a
  integer                                    :: aaellipse_rgba

  aaellipse_rgba =          int(gfx_aaellipse_rgba(renderer,          &
                            int(x, kind=c_short),                     &
                            int(y, kind=c_short),                     &
                            int(rx, kind=c_short),                    &
                            int(ry, kind=c_short),                    &
                            int(r, kind=c_uint8_t),                   &
                            int(g, kind=c_uint8_t),                   &
                            int(b, kind=c_uint8_t),                   &
                            int(a, kind=c_uint8_t)))

end function aaellipse_rgba

! Filled Ellipse

function filled_ellipse_color(renderer, x, y, rx, ry, color)

  type(sdl), intent(in)                      :: renderer
  integer, intent(in)                        :: x, y, rx, ry, color
  integer                                    :: filled_ellipse_color

  filled_ellipse_color =    int(gfx_filled_ellipse_color(renderer,    &
                            int(x, kind=c_short),                     &
                            int(y, kind=c_short),                     &
                            int(rx, kind=c_short),                    &
                            int(ry, kind=c_short),                    &
                            int(color, kind=c_uint32_t)))

end function filled_ellipse_color

function filled_ellipse_rgba(renderer, x, y, rx, ry, r, g, b, a)

  type(sdl), intent(in)                      :: renderer
  integer, intent(in)                        :: x, y, rx, ry, r, g, b, a
  integer                                    :: filled_ellipse_rgba

  filled_ellipse_rgba =     int(gfx_filled_ellipse_rgba(renderer,     &
                            int(x, kind=c_short),                     &
                            int(y, kind=c_short),                     &
                            int(rx, kind=c_short),                    &
                            int(ry, kind=c_short),                    &
                            int(r, kind=c_uint8_t),                   &
                            int(g, kind=c_uint8_t),                   &
                            int(b, kind=c_uint8_t),                   &
                            int(a, kind=c_uint8_t)))

end function filled_ellipse_rgba

! Pie

function pie_color(renderer, x, y, rad, from, to, color)

  type(sdl), intent(in)                      :: renderer
  integer, intent(in)                        :: x, y, rad, from, to, color
  integer                                    :: pie_color

  pie_color =               int(gfx_pie_color(renderer,               &
                            int(x, kind=c_short),                     &
                            int(y, kind=c_short),                     &
                            int(rad, kind=c_short),                   &
                            int(from, kind=c_short),                  &
                            int(to, kind=c_short),                    &
                            int(color, kind=c_uint32_t)))

end function pie_color

function pie_rgba(renderer, x, y, rad, from, to, r, g, b, a)

  type(sdl), intent(in)                      :: renderer
  integer, intent(in)                        :: x, y, rad, from, to, r, g, b, a
  integer                                    :: pie_rgba

  pie_rgba =                int(gfx_pie_rgba(renderer,                &
                            int(x, kind=c_short),                     &
                            int(y, kind=c_short),                     &
                            int(rad, kind=c_short),                   &
                            int(from, kind=c_short),                  &
                            int(to, kind=c_short),                    &
                            int(r, kind=c_uint8_t),                   &
                            int(g, kind=c_uint8_t),                   &
                            int(b, kind=c_uint8_t),                   &
                            int(a, kind=c_uint8_t)))

end function pie_rgba

! Filled Pie

function filled_pie_color(renderer, x, y, rad, from, to, color)

  type(sdl), intent(in)                      :: renderer
  integer, intent(in)                        :: x, y, rad, from, to, color
  integer                                    :: filled_pie_color

  filled_pie_color =        int(gfx_filled_pie_color(renderer,        &
                            int(x, kind=c_short),                     &
                            int(y, kind=c_short),                     &
                            int(rad, kind=c_short),                   &
                            int(from, kind=c_short),                  &
                            int(to, kind=c_short),                    &
                            int(color, kind=c_uint32_t)))

end function filled_pie_color

function filled_pie_rgba(renderer, x, y, rad, from, to, r, g, b, a)

  type(sdl), intent(in)                      :: renderer
  integer, intent(in)                        :: x, y, rad, from, to, r, g, b, a
  integer                                    :: filled_pie_rgba

  filled_pie_rgba =         int(gfx_filled_pie_rgba(renderer,         &
                            int(x, kind=c_short),                     &
                            int(y, kind=c_short),                     &
                            int(rad, kind=c_short),                   &
                            int(from, kind=c_short),                  &
                            int(to, kind=c_short),                    &
                            int(r, kind=c_uint8_t),                   &
                            int(g, kind=c_uint8_t),                   &
                            int(b, kind=c_uint8_t),                   &
                            int(a, kind=c_uint8_t)))

end function filled_pie_rgba

! Trigon

function trigon_color(renderer, x1, y1, x2, y2, x3, y3, color)

  type(sdl), intent(in)                      :: renderer
  integer, intent(in)                        :: x1, y1, x2, y2, x3, y3, color
  integer                                    :: trigon_color

  trigon_color =            int(gfx_trigon_color(renderer,            &
                            int(x1, kind=c_short),                    &
                            int(y1, kind=c_short),                    &
                            int(x2, kind=c_short),                    &
                            int(y2, kind=c_short),                    &
                            int(x3, kind=c_short),                    &
                            int(y3, kind=c_short),                    &
                            int(color, kind=c_uint32_t)))

end function trigon_color

function trigon_rgba(renderer, x1, y1, x2, y2, x3, y3, r, g, b, a)

  type(sdl), intent(in)                      :: renderer
  integer, intent(in)                        :: x1, y1, x2, y2, x3, y3, r, g, b, a
  integer                                    :: trigon_rgba

  trigon_rgba =             int(gfx_trigon_rgba(renderer,             &
                            int(x1, kind=c_short),                    &
                            int(y1, kind=c_short),                    &
                            int(x2, kind=c_short),                    &
                            int(y2, kind=c_short),                    &
                            int(x3, kind=c_short),                    &
                            int(y3, kind=c_short),                    &
                            int(r, kind=c_uint8_t),                   &
                            int(g, kind=c_uint8_t),                   &
                            int(b, kind=c_uint8_t),                   &
                            int(a, kind=c_uint8_t)))

end function trigon_rgba

! AA-Trigon

function aatrigon_color(renderer, x1, y1, x2, y2, x3, y3, color)

  type(sdl), intent(in)                      :: renderer
  integer, intent(in)                        :: x1, y1, x2, y2, x3, y3, color
  integer                                    :: aatrigon_color

  aatrigon_color =          int(gfx_aatrigon_color(renderer,          &
                            int(x1, kind=c_short),                    &
                            int(y1, kind=c_short),                    &
                            int(x2, kind=c_short),                    &
                            int(y2, kind=c_short),                    &
                            int(x3, kind=c_short),                    &
                            int(y3, kind=c_short),                    &
                            int(color, kind=c_uint32_t)))

end function aatrigon_color

function aatrigon_rgba(renderer, x1, y1, x2, y2, x3, y3, r, g, b, a)

  type(sdl), intent(in)                      :: renderer
  integer, intent(in)                        :: x1, y1, x2, y2, x3, y3, r, g, b, a
  integer                                    :: aatrigon_rgba

  aatrigon_rgba =           int(gfx_aatrigon_rgba(renderer,           &
                            int(x1, kind=c_short),                    &
                            int(y1, kind=c_short),                    &
                            int(x2, kind=c_short),                    &
                            int(y2, kind=c_short),                    &
                            int(x3, kind=c_short),                    &
                            int(y3, kind=c_short),                    &
                            int(r, kind=c_uint8_t),                   &
                            int(g, kind=c_uint8_t),                   &
                            int(b, kind=c_uint8_t),                   &
                            int(a, kind=c_uint8_t)))

end function aatrigon_rgba

! Filled Trigon

function filled_trigon_color(renderer, x1, y1, x2, y2, x3, y3, color)

  type(sdl), intent(in)                      :: renderer
  integer, intent(in)                        :: x1, y1, x2, y2, x3, y3, color
  integer                                    :: filled_trigon_color

  filled_trigon_color =     int(gfx_filled_trigon_color(renderer,     &
                            int(x1, kind=c_short),                    &
                            int(y1, kind=c_short),                    &
                            int(x2, kind=c_short),                    &
                            int(y2, kind=c_short),                    &
                            int(x3, kind=c_short),                    &
                            int(y3, kind=c_short),                    &
                            int(color, kind=c_uint32_t)))

end function filled_trigon_color

function filled_trigon_rgba(renderer, x1, y1, x2, y2, x3, y3, r, g, b, a)

  type(sdl), intent(in)                      :: renderer
  integer, intent(in)                        :: x1, y1, x2, y2, x3, y3, r, g, b, a
  integer                                    :: filled_trigon_rgba

  filled_trigon_rgba =      int(gfx_filled_trigon_rgba(renderer,      &
                            int(x1, kind=c_short),                    &
                            int(y1, kind=c_short),                    &
                            int(x2, kind=c_short),                    &
                            int(y2, kind=c_short),                    &
                            int(x3, kind=c_short),                    &
                            int(y3, kind=c_short),                    &
                            int(r, kind=c_uint8_t),                   &
                            int(g, kind=c_uint8_t),                   &
                            int(b, kind=c_uint8_t),                   &
                            int(a, kind=c_uint8_t)))

end function filled_trigon_rgba

! Polygon

function polygon_color(renderer, vx, vy, n, color)

  type(sdl), intent(in)                      :: renderer
  integer, dimension(0:2), intent(in)        :: vx, vy
  integer, intent(in)                        ::n, color
  integer                                    :: polygon_color

  polygon_color =           int(gfx_polygon_color(renderer,           &
                            int(vx, kind=c_short),                    &
                            int(vy, kind=c_short),                    &
                            int(n, kind=c_int),                       &
                            int(color, kind=c_uint32_t)))

end function polygon_color

function polygon_rgba(renderer, vx, vy, n, r, g, b, a)

  type(sdl), intent(in)                      :: renderer

  integer, intent(in)                        :: n, r, g, b, a
  integer                                    :: polygon_rgba
  integer, dimension(0:2), intent(in)        :: vx, vy
  polygon_rgba =            int(gfx_polygon_rgba(renderer,            &
                            int(vx, kind=c_short),                    &
                            int(vy, kind=c_short),                    &
                            int(n, kind=c_int),                       &
                            int(r, kind=c_uint8_t),                   &
                            int(g, kind=c_uint8_t),                   &
                            int(b, kind=c_uint8_t),                   &
                            int(a, kind=c_uint8_t)))

end function polygon_rgba

! AA-Polygon

function aapolygon_color(renderer, vx, vy, n, color)

  type(sdl), intent(in)                      :: renderer
  integer, dimension(0:2), intent(in)        :: vx, vy
  integer, intent(in)                        :: n, color
  integer                                    :: aapolygon_color

  aapolygon_color =         int(gfx_aapolygon_color(renderer,         &
                            int(vx, kind=c_short),                    &
                            int(vy, kind=c_short),                    &
                            int(n, kind=c_int),                       &
                            int(color, kind=c_uint32_t)))

end function aapolygon_color

function aapolygon_rgba(renderer, vx, vy, n, r, g, b, a)

  type(sdl), intent(in)                      :: renderer
  integer, dimension(0:2), intent(in)        :: vx, vy
  integer, intent(in)                        :: n, r, g, b, a
  integer                                    :: aapolygon_rgba

  aapolygon_rgba =          int(gfx_aapolygon_rgba(renderer,          &
                            int(vx, kind=c_short),                    &
                            int(vy, kind=c_short),                    &
                            int(n, kind=c_int),                       &
                            int(r, kind=c_uint8_t),                   &
                            int(g, kind=c_uint8_t),                   &
                            int(b, kind=c_uint8_t),                   &
                            int(a, kind=c_uint8_t)))

end function aapolygon_rgba

! Filled Polygon

function filled_polygon_color(renderer, vx, vy, n, color)

  type(sdl), intent(in)                      :: renderer
  integer, dimension(0:2), intent(in)        :: vx, vy
  integer, intent(in)                        :: n, color
  integer                                    :: filled_polygon_color

  filled_polygon_color =    int(gfx_filled_polygon_color(renderer,    &
                            int(vx, kind=c_short),                    &
                            int(vy, kind=c_short),                    &
                            int(n, kind=c_int),                       &
                            int(color, kind=c_uint32_t)))

end function filled_polygon_color

function filled_polygon_rgba(renderer, vx, vy, n, r, g, b, a)

  type(sdl), intent(in)                      :: renderer
  integer, dimension(0:2), intent(in)        :: vx, vy
  integer, intent(in)                        :: n, r, g, b, a
  integer                                    :: filled_polygon_rgba

  filled_polygon_rgba =     int(gfx_filled_polygon_rgba(renderer,     &
                            int(vx, kind=c_short),                    &
                            int(vy, kind=c_short),                    &
                            int(n, kind=c_int),                       &
                            int(r, kind=c_uint8_t),                   &
                            int(g, kind=c_uint8_t),                   &
                            int(b, kind=c_uint8_t),                   &
                            int(a, kind=c_uint8_t)))

end function filled_polygon_rgba

! Textured Polygon

function textured_polygon(renderer, vx, vy, n, texture, texture_dx, texture_dy)

  type(sdl), intent(in)                      :: renderer
  integer, dimension(0:2), intent(in)        :: vx, vy
  integer, intent(in)                        :: n, texture_dx, texture_dy
  type(sdl_surface), intent(in)              :: texture
  integer                                    :: textured_polygon

  textured_polygon =        int(gfx_textured_polygon(renderer,        &
                            int(vx, kind=c_short),                    &
                            int(vy, kind=c_short),                    &
                            int(n, kind=c_int),                       &
  texture,                                                            &
                            int(texture_dx, kind=c_int),              &
                            int(texture_dy, kind=c_int)))

end function textured_polygon

! Bezier

function bezier_color(renderer, vx, vy, n, s, color)

  type(sdl), intent(in)                      :: renderer

  integer, intent(in)                        :: n, s, color
  integer                                    :: bezier_color
  integer, dimension(0:2), intent(in)        :: vx, vy
  bezier_color =            int(gfx_bezier_color(renderer,            &
                            int(vx, kind=c_short),                    &
                            int(vy, kind=c_short),                    &
                            int(n, kind=c_int),                       &
                            int(s, kind=c_int),                       &
                            int(color, kind=c_uint32_t)))

end function bezier_color

function bezier_rgba(renderer, vx, vy, n, s, r, g, b, a)

  type(sdl), intent(in)                      :: renderer

  integer, intent(in)                        :: n, s, r, g, b, a
  integer                                    :: bezier_rgba
  integer, dimension(0:2), intent(in)        :: vx, vy
  bezier_rgba =             int(gfx_bezier_rgba(renderer,             &
                            int(vx, kind=c_short),                    &
                            int(vy, kind=c_short),                    &
                            int(n, kind=c_int),                       &
                            int(s, kind=c_int),                       &
                            int(r, kind=c_uint8_t),                   &
                            int(g, kind=c_uint8_t),                   &
                            int(b, kind=c_uint8_t),                   &
                            int(a, kind=c_uint8_t)))

end function bezier_rgba

! Characters/Strings

subroutine set_font(fontdata, cw, ch)

  type(sdl), intent(in)                      :: fontdata
  integer, intent(in)                        :: cw, ch

  call gfx_primitives_set_font(fontdata,                              &
                            int(cw, kind=c_uint32_t),                 &
                            int(ch, kind=c_uint32_t))

end subroutine set_font

subroutine set_font_rotation(rotation)

  integer, intent(in)                        :: rotation

  call gfx_primitives_set_font_rotation(                              &
                            int(rotation, kind=c_uint32_t))

end subroutine set_font_rotation

! FIXME - pass null terminated string...
function character_color(renderer, x, y, c, color)

  type(sdl), intent(in)                      :: renderer
  integer, intent(in)                        :: x, y, color
  character(len=1)                           :: c
  integer                                    :: character_color

  character_color =         int(gfx_character_color(renderer,         &
                            int(x, kind=c_short),                     &
                            int(y, kind=c_short),                     &
  c,                                                                  &
                            int(color, kind=c_uint32_t)))

end function character_color

function character_rgba(renderer, x, y, c, r, g, b, a)

  type(sdl), intent(in)                      :: renderer
  integer, intent(in)                        :: x, y, r, g, b, a
  character(len=1)                           :: c
  integer                                    :: character_rgba

  character_rgba =          int(gfx_character_rgba(renderer,          &
                            int(x, kind=c_short),                     &
                            int(y, kind=c_short),                     &
  c,                                                                  &
                            int(r, kind=c_uint8_t),                   &
                            int(g, kind=c_uint8_t),                   &
                            int(b, kind=c_uint8_t),                   &
                            int(a, kind=c_uint8_t)))

end function character_rgba

function string_color(renderer, x, y, s, color)

  type(sdl), intent(in)                      :: renderer
  integer, intent(in)                        :: x, y, color
  character(len=*)                           :: s
  integer                                    :: string_color

  string_color =            int(gfx_string_color(renderer,            &
                            int(x, kind=c_short),                     &
                            int(y, kind=c_short),                     &
  c_str(s),                                                           &
                            int(color, kind=c_uint32_t)))

end function string_color

function string_rgba(renderer, x, y, s, r, g, b, a)

  type(sdl), intent(in)                      :: renderer
  integer, intent(in)                        :: x, y, r, g, b, a
  character(len=*)                           :: s
  integer                                    :: string_rgba

  string_rgba =             int(gfx_string_rgba(renderer,             &
                            int(x, kind=c_short),                     &
                            int(y, kind=c_short),                     &
  c_str(s),                                                           &
                            int(r, kind=c_uint8_t),                   &
                            int(g, kind=c_uint8_t),                   &
                            int(b, kind=c_uint8_t),                   &
                            int(a, kind=c_uint8_t)))

end function string_rgba

function initframerate(manager)

  type(fpsmanager), intent(in)               :: manager
  integer                                    :: r
  integer                                    :: initframerate

  initframerate =           int(sdl_initframerate(manager))

end function initframerate

function setframerate(manager, rate)

  type(fpsmanager), intent(in)               :: manager
  integer                                    :: rate
  integer                                    :: setframerate

  setframerate =            int(sdl_setframerate(manager,             &
                            int(rate, kind=c_uint32_t)))

end function setframerate

function getframerate(manager)

  type(fpsmanager)                           :: manager
  integer                                    :: getframerate

  getframerate =            int(sdl_getframerate(manager))

end function getframerate

function getframecount(manager)

  type(fpsmanager)                           :: manager
  integer                                    :: getframecount

  getframecount =           int(sdl_getframecount(manager))

end function getframecount

function frameratedelay(manager)

  type(fpsmanager)                           :: manager
  integer(kind=c_int)                        :: frameratedelay

  frameratedelay =          int(sdl_frameratedelay(manager))

end function frameratedelay

end module sdl2_gfx
