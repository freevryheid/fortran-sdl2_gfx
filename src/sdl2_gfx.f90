module sdl2_gfx

  use    :: primitives

  implicit none

  private

  !  primitives subs/funcs
  public :: pixel_color
  public :: pixel_rgba
  public :: hline_color
  public :: hline_rgba
  public :: vline_color
  public :: vline_rgba
  public :: rectangle_color
  public :: rectangle_rgba
  public :: rounded_rectangle_color
  public :: rounded_rectangle_rgba
  public :: box_color
  public :: box_rgba
  public :: rounded_box_color
  public :: rounded_box_rgba
  public :: line_color
  public :: line_rgba
  public :: aaline_color
  public :: aaline_rgba
  public :: thick_line_color
  public :: thick_line_rgba
  public :: circle_color
  public :: circle_rgba
  public :: arc_color
  public :: arc_rgba
  public :: aacircle_color
  public :: aacircle_rgba
  public :: filled_circle_color
  public :: filled_circle_rgba
  public :: ellipse_color
  public :: ellipse_rgba
  public :: aaellipse_color
  public :: aaellipse_rgba
  public :: filled_ellipse_color
  public :: filled_ellipse_rgba
  public :: pie_color
  public :: pie_rgba
  public :: filled_pie_color
  public :: filled_pie_rgba
  public :: trigon_color
  public :: trigon_rgba
  public :: aatrigon_color
  public :: aatrigon_rgba
  public :: filled_trigon_color
  public :: filled_trigon_rgba
  public :: polygon_color
  public :: polygon_rgba
  public :: aapolygon_color
  public :: aapolygon_rgba
  public :: filled_polygon_color
  public :: filled_polygon_rgba
  public :: textured_polygon
  public :: bezier_color
  public :: bezier_rgba
  public :: gfx_primitives_set_font
  public :: gfx_primitives_set_font_rotation
  public :: character_color
  public :: character_rgba
  public :: string_color
  public :: string_rgba

end module sdl2_gfx
