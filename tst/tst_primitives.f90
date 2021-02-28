! Andre Smit - Feb 2021, MIT
! WARNING - this produces strobe-like and flashing lights.

program tst_primitives

  use, intrinsic                 :: iso_c_binding,    only : c_associated, c_null_char, c_ptr
  use, intrinsic                 :: iso_fortran_env,  only : stdout => output_unit, stderr => error_unit, &
                                    r4 => real32, i2 => int16, i4 => int32
  use                            :: sdl2
  use                            :: sdl2_gfx

  implicit none

  integer(i4), parameter         :: SCREEN_WIDTH   = 640
  integer(i4), parameter         :: SCREEN_HEIGHT  = 480
  integer(i4), parameter         :: FONT_SIZE      = 8
  integer(i4), parameter         :: MARGIN         = 64

  type(c_ptr)                    :: window
  type(c_ptr)                    :: renderer
  type(sdl_event)                :: event
  type(sdl_surface), pointer     :: image

  real(r4)                       :: w, x, y, r, g, b, rad, from, to
  integer(i4)                    :: rc, n, s
  integer(i4)                    :: func           = 1
  integer(i4)                    :: maxfunc        = 58
  integer(i2)                    :: wi2, xi2, yi2, x1i2, x2i2, x3i2, y1i2, y2i2, y3i2, ri2, gi2, bi2, radi2, fromi2, toi2
  integer(i2), dimension(0:2)    :: vx, vy

  logical                        :: done           = .false.
  logical                        :: clear          = .true.

  character(len=100)             :: title, functitle, string
  character(len=1)               :: schar

  integer(i4), parameter         :: red            = int(z'FF0000FF')
  integer(i4), parameter         :: green          = int(z'FF00FF00')
  integer(i4), parameter         :: blue           = int(z'FFFF0000')
  integer(i4), parameter         :: black          = int(z'FF000000')

  integer(i4), parameter         :: yellow         = ior(red, green)
  integer(i4), parameter         :: magenta        = ior(red, blue)
  integer(i4), parameter         :: cyan           = ior(green, blue)
  integer(i4), parameter         :: white          = ior(yellow, magenta)

  ! initialize the rnd generator
  call random_init(.false., .false.)

  ! initialise SDL
  if (sdl_init(SDL_INIT_VIDEO) < 0) then
    write (stderr, *) 'SDL Error: ', sdl_get_error()
    stop
  end if

  ! create the SDL window
  window = sdl_create_window('tst_primitives' // c_null_char, &
    SDL_WINDOWPOS_UNDEFINED,                                  &
    SDL_WINDOWPOS_UNDEFINED,                                  &
    SCREEN_WIDTH,                                             &
    SCREEN_HEIGHT,                                            &
    SDL_WINDOW_SHOWN)

  if (.not. c_associated(window)) then
    write (stderr, *) 'SDL Error: ', sdl_get_error()
    stop
  end if

  ! create the renderer
  renderer = sdl_create_renderer(window, -1, ior(SDL_RENDERER_ACCELERATED, SDL_RENDERER_TARGETTEXTURE))

  image => null()
  image => sdl_load_bmp('res/texture.bmp' // c_null_char)
  if (.not. associated(image)) then
    error stop "cannot load texture, check the resources folder path"
  end if

  ! event loop
  do while (.not. done)
    call do_events()
    if (clear) call clear_screen()
    call switchboard()
    call sdl_render_present(renderer)  ! Render to screen
  end do

  ! cleanup and  quit
  call sdl_free_surface(image)
  call sdl_destroy_renderer(renderer)
  call sdl_destroy_window(window)
  call sdl_quit()

  contains

    subroutine switchboard()
      select case (func)
        case (1)
          clear = .true.
          functitle = "string_color"
          call func01()
        case (2)
          clear = .true.
          functitle = "string_rgba"
          call func02()
        case (3)
          clear = .false.
          functitle = "pixel_color"
          call func03()
        case (4)
          clear = .false.
          functitle = "pixel_rgba"
          call func04()
        case (5)
          clear = .true.
          functitle = "hline_color"
          call func05()
        case (6)
          clear = .false.
          functitle = "hline_rgba"
          call func06()
        case (7)
          clear = .true.
          functitle = "vline_color"
          call func07()
        case (8)
          clear = .false.
          functitle = "vline_rgba"
          call func08()
        case (9)
          clear = .true.
          functitle = "rectangle_color"
          call func09()
        case (10)
          clear = .false.
          functitle = "rectangle_rgba"
          call func10()
        case (11)
          clear = .true.
          functitle = "rounded_rectangle_color"
          call func11()
        case (12)
          clear = .false.
          functitle = "rounded_rectangle_rgba"
          call func12()
        case (13)
          clear = .true.
          functitle = "box_color"
          call func13()
        case (14)
          clear = .false.
          functitle = "box_rgba"
          call func14()
        case (15)
          clear = .true.
          functitle = "rounded_box_color"
          call func15()
        case (16)
          clear = .false.
          functitle = "rounded_box_rgba"
          call func16()
        case (17)
          clear = .true.
          functitle = "line_color"
          call func17()
        case (18)
          clear = .false.
          functitle = "line_rgba"
          call func18()
        case (19)
          clear = .true.
          functitle = "aaline_color"
          call func19()
        case (20)
          clear = .false.
          functitle = "aaline_rgba"
          call func20()
        case (21)
          clear = .true.
          functitle = "thick_line_color"
          call func21()
        case (22)
          clear = .false.
          functitle = "thick_line_rgba"
          call func22()
        case (23)
          clear = .true.
          functitle = "circle_color"
          call func23()
        case (24)
          clear = .false.
          functitle = "circle_rgba"
          call func24()
        case (25)
          clear = .true.
          functitle = "aacircle_color"
          call func25()
        case (26)
          clear = .false.
          functitle = "aacircle_rgba"
          call func26()
        case (27)
          clear = .true.
          functitle = "arc_color"
          call func27()
        case (28)
          clear = .false.
          functitle = "arc_rgba"
          call func28()
        case (29)
          clear = .true.
          functitle = "filled_circle_color"
          call func29()
        case (30)
          clear = .false.
          functitle = "filled_circle_rgba"
          call func30()
        case (31)
          clear = .true.
          functitle = "ellipse_color"
          call func31()
        case (32)
          clear = .false.
          functitle = "ellipse_rgba"
          call func32()
        case (33)
          clear = .true.
          functitle = "aaellipse_color"
          call func33()
        case (34)
          clear = .false.
          functitle = "aaellipse_rgba"
          call func34()
        case (35)
          clear = .true.
          functitle = "filled_ellipse_color"
          call func35()
        case (36)
          clear = .false.
          functitle = "filled_ellipse_rgba"
          call func36()
        case (37)
          clear = .true.
          functitle = "pie_color"
          call func37()
        case (38)
          clear = .false.
          functitle = "pie_rgba"
          call func38()
        case (39)
          clear = .true.
          functitle = "filled_pie_color"
          call func39()
        case (40)
          clear = .false.
          functitle = "filled_pie_rgba"
          call func40()
        case (41)
          clear = .true.
          functitle = "trigon_color"
          call func41()
        case (42)
          clear = .false.
          functitle = "trigon_rgba"
          call func42()
        case (43)
          clear = .true.
          functitle = "aatrigon_color"
          call func43()
        case (44)
          clear = .false.
          functitle = "aatrigon_rgba"
          call func44()
        case (45)
          clear = .true.
          functitle = "filled_trigon_color"
          call func45()
        case (46)
          clear = .false.
          functitle = "filled_trigon_rgba"
          call func46()
        case (47)
          clear = .true.
          functitle = "polygon_color (n=3)"
          call func47()
        case (48)
          clear = .false.
          functitle = "polygon_rgba (n=3)"
          call func48()
        case (49)
          clear = .true.
          functitle = "aapolygon_color (n=3)"
          call func49()
        case (50)
          clear = .false.
          functitle = "aapolygon_rgba (n=3)"
          call func50()
        case (51)
          clear = .true.
          functitle = "filled_polygon_color (n=3)"
          call func51()
        case (52)
          clear = .false.
          functitle = "filled_polygon_rgba (n=3)"
          call func52()
        case (53)
          clear = .true.
          functitle = "textured_polygon (n=3)"
          call func53()
        case (54)
          clear = .true.
          functitle = "bezier_color (s=3)"
          call func54()
        case (55)
          clear = .false.
          functitle = "bezier_rgba (s=3)"
          call func55()
        case (56)
          clear = .false.
          functitle = "font rotation (2 steps)"
          call func56()
        case (57)
          clear = .false.
          functitle = "character_color"
          call func57()
        case (58)
          clear = .false.
          functitle = "character_rgba"
          call func58()
        case default
          error stop "here be dragons"
      end select
      title = "test primitives ( " // trim(adjustl(i2s(func))) // " / " // trim(adjustl(i2s(maxfunc))) // " )"
      xi2 = int2((SCREEN_WIDTH - string_length(title))/2)
      rc = string_color(renderer, xi2, int2(FONT_SIZE), nts(title) , white)
      xi2 = int2((SCREEN_WIDTH - string_length(functitle))/2)
      yi2 = int2(SCREEN_HEIGHT - 2*FONT_SIZE)
      rc = string_color(renderer, xi2, yi2, nts(functitle), white)
    end subroutine switchboard

    subroutine func58()
      ! character_rgba
      schar = char(101)
      xi2 = SCREEN_WIDTH/2_i2
      yi2 = SCREEN_HEIGHT/2_i2
      rc = character_rgba(renderer, xi2, yi2, nts(schar), uint8(255), uint8(0), uint8(0), uint8(255))
    end subroutine func58

    subroutine func57()
      ! character_color
      schar = char(100)
      xi2 = SCREEN_WIDTH/2_i2
      yi2 = SCREEN_HEIGHT/2_i2
      rc = character_color(renderer, xi2, yi2, nts(schar), green)
    end subroutine func57

    subroutine func56()
      ! font rotation
      string = "font rotation"
      xi2 = int2((SCREEN_WIDTH+string_length(string))/2)
      yi2 = SCREEN_HEIGHT/2_i2
      call gfx_primitives_set_font_rotation(2)
      rc = string_color(renderer, xi2, yi2, nts(string), yellow)
      call gfx_primitives_set_font_rotation(0)
    end subroutine func56

    subroutine func55()
      ! bezier_rgba
      call random_number(x)
      x1i2 = int2(floor(x*real((SCREEN_WIDTH-2*MARGIN+1), r4)))
      x1i2 = int2(MARGIN) + x1i2
      call random_number(y)
      y1i2 = int2(floor(y*real((SCREEN_HEIGHT-2*MARGIN+1), r4)))
      y1i2 = int2(MARGIN) + y1i2
      call random_number(x)
      x2i2 = int2(floor(x*real((SCREEN_WIDTH-2*MARGIN+1), r4)))
      x2i2 = int2(MARGIN) + x2i2
      call random_number(y)
      y2i2 = int2(floor(y*real((SCREEN_HEIGHT-2*MARGIN+1), r4)))
      y2i2 = int2(MARGIN) + y2i2
      call random_number(x)
      x3i2 = int2(floor(x*real((SCREEN_WIDTH-2*MARGIN+1), r4)))
      x3i2 = int2(MARGIN) + x3i2
      call random_number(y)
      y3i2 = int2(floor(y*real((SCREEN_HEIGHT-2*MARGIN+1), r4)))
      y3i2 = int2(MARGIN) + y3i2
      vx(0) = x1i2
      vx(1) = x2i2
      vx(2) = x3i2
      vy(0) = y1i2
      vy(1) = y2i2
      vy(2) = y3i2
      n = 3
      s = 3
      call random_number(r)
      ri2 = int2(floor(r*256_r4))
      call random_number(g)
      gi2 = int2(floor(g*256_r4))
      call random_number(b)
      bi2 = int2(floor(b*256_r4))
      rc = bezier_rgba(renderer, vx(0), vy(0), n, s, uint8(ri2), uint8(gi2), uint8(bi2), &
                                  uint8(SDL_ALPHA_OPAQUE))
    end subroutine func55

    subroutine func54()
      ! bezier_color
      call random_number(x)
      x1i2 = int2(floor(x*real((SCREEN_WIDTH-2*MARGIN+1), r4)))
      x1i2 = int2(MARGIN) + x1i2
      call random_number(y)
      y1i2 = int2(floor(y*real((SCREEN_HEIGHT-2*MARGIN+1), r4)))
      y1i2 = int2(MARGIN) + y1i2
      call random_number(x)
      x2i2 = int2(floor(x*real((SCREEN_WIDTH-2*MARGIN+1), r4)))
      x2i2 = int2(MARGIN) + x2i2
      call random_number(y)
      y2i2 = int2(floor(y*real((SCREEN_HEIGHT-2*MARGIN+1), r4)))
      y2i2 = int2(MARGIN) + y2i2
      call random_number(x)
      x3i2 = int2(floor(x*real((SCREEN_WIDTH-2*MARGIN+1), r4)))
      x3i2 = int2(MARGIN) + x3i2
      call random_number(y)
      y3i2 = int2(floor(y*real((SCREEN_HEIGHT-2*MARGIN+1), r4)))
      y3i2 = int2(MARGIN) + y3i2
      vx(0) = x1i2
      vx(1) = x2i2
      vx(2) = x3i2
      vy(0) = y1i2
      vy(1) = y2i2
      vy(2) = y3i2
      n = 3
      s = 3
      rc = bezier_color(renderer, vx(0), vy(0), n, s, red)
    end subroutine func54

    subroutine func53()
      ! textured_polygon
      call random_number(x)
      x1i2 = int2(floor(x*real((SCREEN_WIDTH-2*MARGIN+1), r4)))
      x1i2 = int2(MARGIN) + x1i2
      call random_number(y)
      y1i2 = int2(floor(y*real((SCREEN_HEIGHT-2*MARGIN+1), r4)))
      y1i2 = int2(MARGIN) + y1i2
      call random_number(x)
      x2i2 = int2(floor(x*real((SCREEN_WIDTH-2*MARGIN+1), r4)))
      x2i2 = int2(MARGIN) + x2i2
      call random_number(y)
      y2i2 = int2(floor(y*real((SCREEN_HEIGHT-2*MARGIN+1), r4)))
      y2i2 = int2(MARGIN) + y2i2
      call random_number(x)
      x3i2 = int2(floor(x*real((SCREEN_WIDTH-2*MARGIN+1), r4)))
      x3i2 = int2(MARGIN) + x3i2
      call random_number(y)
      y3i2 = int2(floor(y*real((SCREEN_HEIGHT-2*MARGIN+1), r4)))
      y3i2 = int2(MARGIN) + y3i2
      vx(0) = x1i2
      vx(1) = x2i2
      vx(2) = x3i2
      vy(0) = y1i2
      vy(1) = y2i2
      vy(2) = y3i2
      n = 3
      rc = textured_polygon(renderer, vx(0), vy(0), n, image, 0, 0)
    end subroutine func53

    subroutine func52()
      ! filled_polygon_rgba
      call random_number(x)
      x1i2 = int2(floor(x*real((SCREEN_WIDTH-2*MARGIN+1), r4)))
      x1i2 = int2(MARGIN) + x1i2
      call random_number(y)
      y1i2 = int2(floor(y*real((SCREEN_HEIGHT-2*MARGIN+1), r4)))
      y1i2 = int2(MARGIN) + y1i2
      call random_number(x)
      x2i2 = int2(floor(x*real((SCREEN_WIDTH-2*MARGIN+1), r4)))
      x2i2 = int2(MARGIN) + x2i2
      call random_number(y)
      y2i2 = int2(floor(y*real((SCREEN_HEIGHT-2*MARGIN+1), r4)))
      y2i2 = int2(MARGIN) + y2i2
      call random_number(x)
      x3i2 = int2(floor(x*real((SCREEN_WIDTH-2*MARGIN+1), r4)))
      x3i2 = int2(MARGIN) + x3i2
      call random_number(y)
      y3i2 = int2(floor(y*real((SCREEN_HEIGHT-2*MARGIN+1), r4)))
      y3i2 = int2(MARGIN) + y3i2
      vx(0) = x1i2
      vx(1) = x2i2
      vx(2) = x3i2
      vy(0) = y1i2
      vy(1) = y2i2
      vy(2) = y3i2
      n = 3
      call random_number(r)
      ri2 = int2(floor(r*256_r4))
      call random_number(g)
      gi2 = int2(floor(g*256_r4))
      call random_number(b)
      bi2 = int2(floor(b*256_r4))
      rc = filled_polygon_rgba(renderer, vx(0), vy(0), n, uint8(ri2), uint8(gi2), uint8(bi2), &
                                  uint8(SDL_ALPHA_OPAQUE))
    end subroutine func52

    subroutine func51()
      ! filled_polygon_color
      call random_number(x)
      x1i2 = int2(floor(x*real((SCREEN_WIDTH-2*MARGIN+1), r4)))
      x1i2 = int2(MARGIN) + x1i2
      call random_number(y)
      y1i2 = int2(floor(y*real((SCREEN_HEIGHT-2*MARGIN+1), r4)))
      y1i2 = int2(MARGIN) + y1i2
      call random_number(x)
      x2i2 = int2(floor(x*real((SCREEN_WIDTH-2*MARGIN+1), r4)))
      x2i2 = int2(MARGIN) + x2i2
      call random_number(y)
      y2i2 = int2(floor(y*real((SCREEN_HEIGHT-2*MARGIN+1), r4)))
      y2i2 = int2(MARGIN) + y2i2
      call random_number(x)
      x3i2 = int2(floor(x*real((SCREEN_WIDTH-2*MARGIN+1), r4)))
      x3i2 = int2(MARGIN) + x3i2
      call random_number(y)
      y3i2 = int2(floor(y*real((SCREEN_HEIGHT-2*MARGIN+1), r4)))
      y3i2 = int2(MARGIN) + y3i2
      vx(0) = x1i2
      vx(1) = x2i2
      vx(2) = x3i2
      vy(0) = y1i2
      vy(1) = y2i2
      vy(2) = y3i2
      n = 3
      rc = filled_polygon_color(renderer, vx(0), vy(0), n, cyan)
    end subroutine func51

    subroutine func50()
      ! aapolygon_rgba
      call random_number(x)
      x1i2 = int2(floor(x*real((SCREEN_WIDTH-2*MARGIN+1), r4)))
      x1i2 = int2(MARGIN) + x1i2
      call random_number(y)
      y1i2 = int2(floor(y*real((SCREEN_HEIGHT-2*MARGIN+1), r4)))
      y1i2 = int2(MARGIN) + y1i2
      call random_number(x)
      x2i2 = int2(floor(x*real((SCREEN_WIDTH-2*MARGIN+1), r4)))
      x2i2 = int2(MARGIN) + x2i2
      call random_number(y)
      y2i2 = int2(floor(y*real((SCREEN_HEIGHT-2*MARGIN+1), r4)))
      y2i2 = int2(MARGIN) + y2i2
      call random_number(x)
      x3i2 = int2(floor(x*real((SCREEN_WIDTH-2*MARGIN+1), r4)))
      x3i2 = int2(MARGIN) + x3i2
      call random_number(y)
      y3i2 = int2(floor(y*real((SCREEN_HEIGHT-2*MARGIN+1), r4)))
      y3i2 = int2(MARGIN) + y3i2
      vx(0) = x1i2
      vx(1) = x2i2
      vx(2) = x3i2
      vy(0) = y1i2
      vy(1) = y2i2
      vy(2) = y3i2
      n = 3
      call random_number(r)
      ri2 = int2(floor(r*256_r4))
      call random_number(g)
      gi2 = int2(floor(g*256_r4))
      call random_number(b)
      bi2 = int2(floor(b*256_r4))
      rc = aapolygon_rgba(renderer, vx(0), vy(0), n, uint8(ri2), uint8(gi2), uint8(bi2), &
                                  uint8(SDL_ALPHA_OPAQUE))
    end subroutine func50

    subroutine func49()
      ! aapolygon_color
      call random_number(x)
      x1i2 = int2(floor(x*real((SCREEN_WIDTH-2*MARGIN+1), r4)))
      x1i2 = int2(MARGIN) + x1i2
      call random_number(y)
      y1i2 = int2(floor(y*real((SCREEN_HEIGHT-2*MARGIN+1), r4)))
      y1i2 = int2(MARGIN) + y1i2
      call random_number(x)
      x2i2 = int2(floor(x*real((SCREEN_WIDTH-2*MARGIN+1), r4)))
      x2i2 = int2(MARGIN) + x2i2
      call random_number(y)
      y2i2 = int2(floor(y*real((SCREEN_HEIGHT-2*MARGIN+1), r4)))
      y2i2 = int2(MARGIN) + y2i2
      call random_number(x)
      x3i2 = int2(floor(x*real((SCREEN_WIDTH-2*MARGIN+1), r4)))
      x3i2 = int2(MARGIN) + x3i2
      call random_number(y)
      y3i2 = int2(floor(y*real((SCREEN_HEIGHT-2*MARGIN+1), r4)))
      y3i2 = int2(MARGIN) + y3i2
      vx(0) = x1i2
      vx(1) = x2i2
      vx(2) = x3i2
      vy(0) = y1i2
      vy(1) = y2i2
      vy(2) = y3i2
      n = 3
      rc = aapolygon_color(renderer, vx(0), vy(0), n, magenta)
    end subroutine func49

    subroutine func48()
      ! polygon_rgba
      call random_number(x)
      x1i2 = int2(floor(x*real((SCREEN_WIDTH-2*MARGIN+1), r4)))
      x1i2 = int2(MARGIN) + x1i2
      call random_number(y)
      y1i2 = int2(floor(y*real((SCREEN_HEIGHT-2*MARGIN+1), r4)))
      y1i2 = int2(MARGIN) + y1i2
      call random_number(x)
      x2i2 = int2(floor(x*real((SCREEN_WIDTH-2*MARGIN+1), r4)))
      x2i2 = int2(MARGIN) + x2i2
      call random_number(y)
      y2i2 = int2(floor(y*real((SCREEN_HEIGHT-2*MARGIN+1), r4)))
      y2i2 = int2(MARGIN) + y2i2
      call random_number(x)
      x3i2 = int2(floor(x*real((SCREEN_WIDTH-2*MARGIN+1), r4)))
      x3i2 = int2(MARGIN) + x3i2
      call random_number(y)
      y3i2 = int2(floor(y*real((SCREEN_HEIGHT-2*MARGIN+1), r4)))
      y3i2 = int2(MARGIN) + y3i2
      vx(0) = x1i2
      vx(1) = x2i2
      vx(2) = x3i2
      vy(0) = y1i2
      vy(1) = y2i2
      vy(2) = y3i2
      n = 3
      call random_number(r)
      ri2 = int2(floor(r*256_r4))
      call random_number(g)
      gi2 = int2(floor(g*256_r4))
      call random_number(b)
      bi2 = int2(floor(b*256_r4))
      rc = polygon_rgba(renderer, vx(0), vy(0), n, uint8(ri2), uint8(gi2), uint8(bi2), &
                                  uint8(SDL_ALPHA_OPAQUE))
    end subroutine func48

    subroutine func47()
      ! polygon_color
      call random_number(x)
      x1i2 = int2(floor(x*real((SCREEN_WIDTH-2*MARGIN+1), r4)))
      x1i2 = int2(MARGIN) + x1i2
      call random_number(y)
      y1i2 = int2(floor(y*real((SCREEN_HEIGHT-2*MARGIN+1), r4)))
      y1i2 = int2(MARGIN) + y1i2
      call random_number(x)
      x2i2 = int2(floor(x*real((SCREEN_WIDTH-2*MARGIN+1), r4)))
      x2i2 = int2(MARGIN) + x2i2
      call random_number(y)
      y2i2 = int2(floor(y*real((SCREEN_HEIGHT-2*MARGIN+1), r4)))
      y2i2 = int2(MARGIN) + y2i2
      call random_number(x)
      x3i2 = int2(floor(x*real((SCREEN_WIDTH-2*MARGIN+1), r4)))
      x3i2 = int2(MARGIN) + x3i2
      call random_number(y)
      y3i2 = int2(floor(y*real((SCREEN_HEIGHT-2*MARGIN+1), r4)))
      y3i2 = int2(MARGIN) + y3i2
      vx(0) = x1i2
      vx(1) = x2i2
      vx(2) = x3i2
      vy(0) = y1i2
      vy(1) = y2i2
      vy(2) = y3i2
      n = 3
      rc = polygon_color(renderer, vx(0), vy(0), n, yellow)
    end subroutine func47

    subroutine func46()
      ! filled_trigon_rgba
      call random_number(x)
      x1i2 = int2(floor(x*real((SCREEN_WIDTH-2*MARGIN+1), r4)))
      x1i2 = int2(MARGIN) + x1i2
      call random_number(y)
      y1i2 = int2(floor(y*real((SCREEN_HEIGHT-2*MARGIN+1), r4)))
      y1i2 = int2(MARGIN) + y1i2
      call random_number(x)
      x2i2 = int2(floor(x*real((SCREEN_WIDTH-2*MARGIN+1), r4)))
      x2i2 = int2(MARGIN) + x2i2
      call random_number(y)
      y2i2 = int2(floor(y*real((SCREEN_HEIGHT-2*MARGIN+1), r4)))
      y2i2 = int2(MARGIN) + y2i2
      call random_number(x)
      x3i2 = int2(floor(x*real((SCREEN_WIDTH-2*MARGIN+1), r4)))
      x3i2 = int2(MARGIN) + x3i2
      call random_number(y)
      y3i2 = int2(floor(y*real((SCREEN_HEIGHT-2*MARGIN+1), r4)))
      y3i2 = int2(MARGIN) + y3i2
      call random_number(r)
      ri2 = int2(floor(r*256_r4))
      call random_number(g)
      gi2 = int2(floor(g*256_r4))
      call random_number(b)
      bi2 = int2(floor(b*256_r4))
      rc = filled_trigon_rgba(renderer, x1i2, y1i2, x2i2, y2i2, x3i2, y3i2, uint8(ri2), uint8(gi2), uint8(bi2), &
                                  uint8(SDL_ALPHA_OPAQUE))
    end subroutine func46

    subroutine func45()
      ! filled_trigon_color
      call random_number(x)
      x1i2 = int2(floor(x*real((SCREEN_WIDTH-2*MARGIN+1), r4)))
      x1i2 = int2(MARGIN) + x1i2
      call random_number(y)
      y1i2 = int2(floor(y*real((SCREEN_HEIGHT-2*MARGIN+1), r4)))
      y1i2 = int2(MARGIN) + y1i2
      call random_number(x)
      x2i2 = int2(floor(x*real((SCREEN_WIDTH-2*MARGIN+1), r4)))
      x2i2 = int2(MARGIN) + x2i2
      call random_number(y)
      y2i2 = int2(floor(y*real((SCREEN_HEIGHT-2*MARGIN+1), r4)))
      y2i2 = int2(MARGIN) + y2i2
      call random_number(x)
      x3i2 = int2(floor(x*real((SCREEN_WIDTH-2*MARGIN+1), r4)))
      x3i2 = int2(MARGIN) + x3i2
      call random_number(y)
      y3i2 = int2(floor(y*real((SCREEN_HEIGHT-2*MARGIN+1), r4)))
      y3i2 = int2(MARGIN) + y3i2
      rc = filled_trigon_color(renderer, x1i2, y1i2, x2i2, y2i2, x3i2, y3i2, blue)
    end subroutine func45

    subroutine func44()
      ! aatrigon_rgba
      call random_number(x)
      x1i2 = int2(floor(x*real((SCREEN_WIDTH-2*MARGIN+1), r4)))
      x1i2 = int2(MARGIN) + x1i2
      call random_number(y)
      y1i2 = int2(floor(y*real((SCREEN_HEIGHT-2*MARGIN+1), r4)))
      y1i2 = int2(MARGIN) + y1i2
      call random_number(x)
      x2i2 = int2(floor(x*real((SCREEN_WIDTH-2*MARGIN+1), r4)))
      x2i2 = int2(MARGIN) + x2i2
      call random_number(y)
      y2i2 = int2(floor(y*real((SCREEN_HEIGHT-2*MARGIN+1), r4)))
      y2i2 = int2(MARGIN) + y2i2
      call random_number(x)
      x3i2 = int2(floor(x*real((SCREEN_WIDTH-2*MARGIN+1), r4)))
      x3i2 = int2(MARGIN) + x3i2
      call random_number(y)
      y3i2 = int2(floor(y*real((SCREEN_HEIGHT-2*MARGIN+1), r4)))
      y3i2 = int2(MARGIN) + y3i2
      call random_number(r)
      ri2 = int2(floor(r*256_r4))
      call random_number(g)
      gi2 = int2(floor(g*256_r4))
      call random_number(b)
      bi2 = int2(floor(b*256_r4))
      rc = aatrigon_rgba(renderer, x1i2, y1i2, x2i2, y2i2, x3i2, y3i2, uint8(ri2), uint8(gi2), uint8(bi2), &
                                  uint8(SDL_ALPHA_OPAQUE))
    end subroutine func44

    subroutine func43()
      ! aatrigon_color
      call random_number(x)
      x1i2 = int2(floor(x*real((SCREEN_WIDTH-2*MARGIN+1), r4)))
      x1i2 = int2(MARGIN) + x1i2
      call random_number(y)
      y1i2 = int2(floor(y*real((SCREEN_HEIGHT-2*MARGIN+1), r4)))
      y1i2 = int2(MARGIN) + y1i2
      call random_number(x)
      x2i2 = int2(floor(x*real((SCREEN_WIDTH-2*MARGIN+1), r4)))
      x2i2 = int2(MARGIN) + x2i2
      call random_number(y)
      y2i2 = int2(floor(y*real((SCREEN_HEIGHT-2*MARGIN+1), r4)))
      y2i2 = int2(MARGIN) + y2i2
      call random_number(x)
      x3i2 = int2(floor(x*real((SCREEN_WIDTH-2*MARGIN+1), r4)))
      x3i2 = int2(MARGIN) + x3i2
      call random_number(y)
      y3i2 = int2(floor(y*real((SCREEN_HEIGHT-2*MARGIN+1), r4)))
      y3i2 = int2(MARGIN) + y3i2
      rc = aatrigon_color(renderer, x1i2, y1i2, x2i2, y2i2, x3i2, y3i2, green)
    end subroutine func43

    subroutine func42()
      ! trigon_rgba
      call random_number(x)
      x1i2 = int2(floor(x*real((SCREEN_WIDTH-2*MARGIN+1), r4)))
      x1i2 = int2(MARGIN) + x1i2
      call random_number(y)
      y1i2 = int2(floor(y*real((SCREEN_HEIGHT-2*MARGIN+1), r4)))
      y1i2 = int2(MARGIN) + y1i2
      call random_number(x)
      x2i2 = int2(floor(x*real((SCREEN_WIDTH-2*MARGIN+1), r4)))
      x2i2 = int2(MARGIN) + x2i2
      call random_number(y)
      y2i2 = int2(floor(y*real((SCREEN_HEIGHT-2*MARGIN+1), r4)))
      y2i2 = int2(MARGIN) + y2i2
      call random_number(x)
      x3i2 = int2(floor(x*real((SCREEN_WIDTH-2*MARGIN+1), r4)))
      x3i2 = int2(MARGIN) + x3i2
      call random_number(y)
      y3i2 = int2(floor(y*real((SCREEN_HEIGHT-2*MARGIN+1), r4)))
      y3i2 = int2(MARGIN) + y3i2
      call random_number(r)
      ri2 = int2(floor(r*256_r4))
      call random_number(g)
      gi2 = int2(floor(g*256_r4))
      call random_number(b)
      bi2 = int2(floor(b*256_r4))
      rc = trigon_rgba(renderer, x1i2, y1i2, x2i2, y2i2, x3i2, y3i2, uint8(ri2), uint8(gi2), uint8(bi2), &
                                  uint8(SDL_ALPHA_OPAQUE))
    end subroutine func42

    subroutine func41()
      ! trigon_color
      call random_number(x)
      x1i2 = int2(floor(x*real((SCREEN_WIDTH-2*MARGIN+1), r4)))
      x1i2 = int2(MARGIN) + x1i2
      call random_number(y)
      y1i2 = int2(floor(y*real((SCREEN_HEIGHT-2*MARGIN+1), r4)))
      y1i2 = int2(MARGIN) + y1i2
      call random_number(x)
      x2i2 = int2(floor(x*real((SCREEN_WIDTH-2*MARGIN+1), r4)))
      x2i2 = int2(MARGIN) + x2i2
      call random_number(y)
      y2i2 = int2(floor(y*real((SCREEN_HEIGHT-2*MARGIN+1), r4)))
      y2i2 = int2(MARGIN) + y2i2
      call random_number(x)
      x3i2 = int2(floor(x*real((SCREEN_WIDTH-2*MARGIN+1), r4)))
      x3i2 = int2(MARGIN) + x3i2
      call random_number(y)
      y3i2 = int2(floor(y*real((SCREEN_HEIGHT-2*MARGIN+1), r4)))
      y3i2 = int2(MARGIN) + y3i2
      rc = trigon_color(renderer, x1i2, y1i2, x2i2, y2i2, x3i2, y3i2, red)
    end subroutine func41

    subroutine func40()
      ! filled_pie_rgba
      xi2 = SCREEN_WIDTH/2_i2
      yi2 = SCREEN_HEIGHT/2_i2
      call random_number(rad)
      radi2 = int2(floor(rad*real((SCREEN_HEIGHT/2_i2-MARGIN+1), r4)))
      call random_number(from)
      call random_number(to)
      fromi2 = int2(floor(from*361_r4))
      toi2 = int2(floor(to*361_r4))
      call random_number(r)
      ri2 = int2(floor(r*256_r4))
      call random_number(g)
      gi2 = int2(floor(g*256_r4))
      call random_number(b)
      bi2 = int2(floor(b*256_r4))
      rc = filled_pie_rgba(renderer, xi2, yi2, radi2, fromi2, toi2, uint8(ri2), uint8(gi2), uint8(bi2), uint8(SDL_ALPHA_OPAQUE))
    end subroutine func40

    subroutine func39()
      ! filled_pie_color
      xi2 = SCREEN_WIDTH/2_i2
      yi2 = SCREEN_HEIGHT/2_i2
      call random_number(rad)
      radi2 = int2(floor(rad*real((SCREEN_HEIGHT/2_i2-MARGIN+1), r4)))
      call random_number(from)
      call random_number(to)
      fromi2 = int2(floor(from*361_r4))
      toi2 = int2(floor(to*361_r4))
      rc = filled_pie_color(renderer, xi2, yi2, radi2, fromi2, toi2, cyan)
    end subroutine func39

    subroutine func38()
      ! pie_rgba
      xi2 = SCREEN_WIDTH/2_i2
      yi2 = SCREEN_HEIGHT/2_i2
      call random_number(rad)
      radi2 = int2(floor(rad*real((SCREEN_HEIGHT/2_i2-MARGIN+1), r4)))
      call random_number(from)
      call random_number(to)
      fromi2 = int2(floor(from*361_r4))
      toi2 = int2(floor(to*361_r4))
      call random_number(r)
      ri2 = int2(floor(r*256_r4))
      call random_number(g)
      gi2 = int2(floor(g*256_r4))
      call random_number(b)
      bi2 = int2(floor(b*256_r4))
      rc = pie_rgba(renderer, xi2, yi2, radi2, fromi2, toi2, uint8(ri2), uint8(gi2), uint8(bi2), uint8(SDL_ALPHA_OPAQUE))
    end subroutine func38

    subroutine func37()
      ! pie_color
      xi2 = SCREEN_WIDTH/2_i2
      yi2 = SCREEN_HEIGHT/2_i2
      call random_number(rad)
      radi2 = int2(floor(rad*real((SCREEN_HEIGHT/2_i2-MARGIN+1), r4)))
      call random_number(from)
      call random_number(to)
      fromi2 = int2(floor(from*361_r4))
      toi2 = int2(floor(to*361_r4))
      rc = pie_color(renderer, xi2, yi2, radi2, fromi2, toi2, magenta)
    end subroutine func37

    subroutine func36()
      ! filled_ellipse_rgba
      x1i2 = SCREEN_WIDTH/2_i2
      y1i2 = SCREEN_HEIGHT/2_i2
      call random_number(x)
      x2i2 = int2(floor(x*real((SCREEN_WIDTH/2_i2-MARGIN+1), r4)))
      call random_number(y)
      y2i2 = int2(floor(y*real((SCREEN_HEIGHT/2_i2-MARGIN+1), r4)))
      call random_number(r)
      ri2 = int2(floor(r*256_r4))
      call random_number(g)
      gi2 = int2(floor(g*256_r4))
      call random_number(b)
      bi2 = int2(floor(b*256_r4))
      rc = filled_ellipse_rgba(renderer, x1i2, y1i2, x2i2, y2i2, uint8(ri2), uint8(gi2), uint8(bi2), &
                                  uint8(SDL_ALPHA_OPAQUE))
    end subroutine func36

    subroutine func35()
      ! filled_ellipse_color
      x1i2 = SCREEN_WIDTH/2_i2
      y1i2 = SCREEN_HEIGHT/2_i2
      call random_number(x)
      x2i2 = int2(floor(x*real((SCREEN_WIDTH/2_i2-MARGIN+1), r4)))
      call random_number(y)
      y2i2 = int2(floor(y*real((SCREEN_HEIGHT/2_i2-MARGIN+1), r4)))
      rc = filled_ellipse_color(renderer, x1i2, y1i2, x2i2, y2i2, yellow)
    end subroutine func35

    subroutine func34()
      ! aaellipse_rgba
      x1i2 = SCREEN_WIDTH/2_i2
      y1i2 = SCREEN_HEIGHT/2_i2
      call random_number(x)
      x2i2 = int2(floor(x*real((SCREEN_WIDTH/2_i2-MARGIN+1), r4)))
      call random_number(y)
      y2i2 = int2(floor(y*real((SCREEN_HEIGHT/2_i2-MARGIN+1), r4)))
      call random_number(r)
      ri2 = int2(floor(r*256_r4))
      call random_number(g)
      gi2 = int2(floor(g*256_r4))
      call random_number(b)
      bi2 = int2(floor(b*256_r4))
      rc = aaellipse_rgba(renderer, x1i2, y1i2, x2i2, y2i2, uint8(ri2), uint8(gi2), uint8(bi2), &
                                  uint8(SDL_ALPHA_OPAQUE))
    end subroutine func34

    subroutine func33()
      ! aaellipse_color
      x1i2 = SCREEN_WIDTH/2_i2
      y1i2 = SCREEN_HEIGHT/2_i2
      call random_number(x)
      x2i2 = int2(floor(x*real((SCREEN_WIDTH/2_i2-MARGIN+1), r4)))
      call random_number(y)
      y2i2 = int2(floor(y*real((SCREEN_HEIGHT/2_i2-MARGIN+1), r4)))
      rc = aaellipse_color(renderer, x1i2, y1i2, x2i2, y2i2, blue)
    end subroutine func33

    subroutine func32()
      ! ellipse_rgba
      x1i2 = SCREEN_WIDTH/2_i2
      y1i2 = SCREEN_HEIGHT/2_i2
      call random_number(x)
      x2i2 = int2(floor(x*real((SCREEN_WIDTH/2_i2-MARGIN+1), r4)))
      call random_number(y)
      y2i2 = int2(floor(y*real((SCREEN_HEIGHT/2_i2-MARGIN+1), r4)))
      call random_number(r)
      ri2 = int2(floor(r*256_r4))
      call random_number(g)
      gi2 = int2(floor(g*256_r4))
      call random_number(b)
      bi2 = int2(floor(b*256_r4))
      rc = ellipse_rgba(renderer, x1i2, y1i2, x2i2, y2i2, uint8(ri2), uint8(gi2), uint8(bi2), &
                                  uint8(SDL_ALPHA_OPAQUE))
    end subroutine func32

    subroutine func31()
      ! ellipse_color
      x1i2 = SCREEN_WIDTH/2_i2
      y1i2 = SCREEN_HEIGHT/2_i2
      call random_number(x)
      x2i2 = int2(floor(x*real((SCREEN_WIDTH/2_i2-MARGIN+1), r4)))
      call random_number(y)
      y2i2 = int2(floor(y*real((SCREEN_HEIGHT/2_i2-MARGIN+1), r4)))
      rc = ellipse_color(renderer, x1i2, y1i2, x2i2, y2i2, green)
    end subroutine func31

    subroutine func30()
      ! filled_circle_rgba
      xi2 = SCREEN_WIDTH/2_i2
      yi2 = SCREEN_HEIGHT/2_i2
      call random_number(rad)
      radi2 = int2(floor(rad*real((SCREEN_HEIGHT/2_i2-MARGIN+1), r4)))
      call random_number(r)
      ri2 = int2(floor(r*256_r4))
      call random_number(g)
      gi2 = int2(floor(g*256_r4))
      call random_number(b)
      bi2 = int2(floor(b*256_r4))
      rc = filled_circle_rgba(renderer, xi2, yi2, radi2, uint8(ri2), uint8(gi2), uint8(bi2), uint8(SDL_ALPHA_OPAQUE))
    end subroutine func30

    subroutine func29()
      ! filled_circle_color
      xi2 = SCREEN_WIDTH/2_i2
      yi2 = SCREEN_HEIGHT/2_i2
      call random_number(rad)
      radi2 = int2(floor(rad*real((SCREEN_HEIGHT/2_i2-MARGIN+1), r4)))
      rc = filled_circle_color(renderer, xi2, yi2, radi2, red)
    end subroutine func29

    subroutine func28()
      ! arc_rgba
      xi2 = SCREEN_WIDTH/2_i2
      yi2 = SCREEN_HEIGHT/2_i2
      call random_number(rad)
      radi2 = int2(floor(rad*real((SCREEN_HEIGHT/2_i2-MARGIN+1), r4)))
      call random_number(from)
      call random_number(to)
      fromi2 = int2(floor(from*361_r4))
      toi2 = int2(floor(to*361_r4))
      call random_number(r)
      ri2 = int2(floor(r*256_r4))
      call random_number(g)
      gi2 = int2(floor(g*256_r4))
      call random_number(b)
      bi2 = int2(floor(b*256_r4))
      rc = arc_rgba(renderer, xi2, yi2, radi2, fromi2, toi2, uint8(ri2), uint8(gi2), uint8(bi2), uint8(SDL_ALPHA_OPAQUE))
    end subroutine func28

    subroutine func27()
      ! arc_color
      xi2 = SCREEN_WIDTH/2_i2
      yi2 = SCREEN_HEIGHT/2_i2
      call random_number(rad)
      radi2 = int2(floor(rad*real((SCREEN_HEIGHT/2_i2-MARGIN+1), r4)))
      call random_number(from)
      call random_number(to)
      fromi2 = int2(floor(from*361_r4))
      toi2 = int2(floor(to*361_r4))
      rc = arc_color(renderer, xi2, yi2, radi2, fromi2, toi2, cyan)
    end subroutine func27

    subroutine func26()
      ! aacircle_rgba
      xi2 = SCREEN_WIDTH/2_i2
      yi2 = SCREEN_HEIGHT/2_i2
      call random_number(rad)
      radi2 = int2(floor(rad*real((SCREEN_HEIGHT/2_i2-MARGIN+1), r4)))
      call random_number(r)
      ri2 = int2(floor(r*256_r4))
      call random_number(g)
      gi2 = int2(floor(g*256_r4))
      call random_number(b)
      bi2 = int2(floor(b*256_r4))
      rc = aacircle_rgba(renderer, xi2, yi2, radi2, uint8(ri2), uint8(gi2), uint8(bi2), uint8(SDL_ALPHA_OPAQUE))
    end subroutine func26

    subroutine func25()
      ! aacircle_color
      xi2 = SCREEN_WIDTH/2_i2
      yi2 = SCREEN_HEIGHT/2_i2
      call random_number(rad)
      radi2 = int2(floor(rad*real((SCREEN_HEIGHT/2_i2-MARGIN+1), r4)))
      rc = aacircle_color(renderer, xi2, yi2, radi2, magenta)
    end subroutine func25

    subroutine func24()
      ! circle_rgba
      xi2 = SCREEN_WIDTH/2_i2
      yi2 = SCREEN_HEIGHT/2_i2
      call random_number(rad)
      radi2 = int2(floor(rad*real((SCREEN_HEIGHT/2_i2-MARGIN+1), r4)))
      call random_number(r)
      ri2 = int2(floor(r*256_r4))
      call random_number(g)
      gi2 = int2(floor(g*256_r4))
      call random_number(b)
      bi2 = int2(floor(b*256_r4))
      rc = circle_rgba(renderer, xi2, yi2, radi2, uint8(ri2), uint8(gi2), uint8(bi2), uint8(SDL_ALPHA_OPAQUE))
    end subroutine func24

    subroutine func23()
      ! circle_color
      xi2 = SCREEN_WIDTH/2_i2
      yi2 = SCREEN_HEIGHT/2_i2
      call random_number(rad)
      radi2 = int2(floor(rad*real((SCREEN_HEIGHT/2_i2-MARGIN+1), r4)))
      rc = circle_color(renderer, xi2, yi2, radi2, magenta)
    end subroutine func23

    subroutine func22()
      ! thick_line_rgba
      call random_number(x)
      x1i2 = int2(floor(x*real((SCREEN_WIDTH-2*MARGIN+1), r4)))
      x1i2 = int2(MARGIN) + x1i2
      x2i2 = int2(SCREEN_WIDTH)-x1i2
      call random_number(y)
      y1i2 = int2(floor(y*real((SCREEN_HEIGHT-2*MARGIN+1), r4)))
      y1i2 = int2(MARGIN) + y1i2
      y2i2 = int2(SCREEN_HEIGHT)-y1i2
      call random_number(w)
      wi2 = int2(floor(w*real(10, r4)))
      call random_number(r)
      ri2 = int2(floor(r*256_r4))
      call random_number(g)
      gi2 = int2(floor(g*256_r4))
      call random_number(b)
      bi2 = int2(floor(b*256_r4))
      rc = thick_line_rgba(renderer, x1i2, y1i2, x2i2, y2i2, uint8(wi2), uint8(ri2), uint8(gi2), uint8(bi2), &
                                  uint8(SDL_ALPHA_OPAQUE))
    end subroutine func22

    subroutine func21()
      ! thick_line_color
      call random_number(x)
      x1i2 = int2(floor(x*real((SCREEN_WIDTH-2*MARGIN+1), r4)))
      x1i2 = int2(MARGIN) + x1i2
      x2i2 = int2(SCREEN_WIDTH)-x1i2
      call random_number(y)
      y1i2 = int2(floor(y*real((SCREEN_HEIGHT-2*MARGIN+1), r4)))
      y1i2 = int2(MARGIN) + y1i2
      y2i2 = int2(SCREEN_HEIGHT)-y1i2
      call random_number(w)
      wi2 = int2(floor(w*real(10, r4)))
      rc = thick_line_color(renderer, x1i2, y1i2, x2i2, y2i2, uint8(wi2), yellow)
    end subroutine func21

    subroutine func20()
      ! aaline_rgba
      call random_number(x)
      x1i2 = int2(floor(x*real((SCREEN_WIDTH-2*MARGIN+1), r4)))
      x1i2 = int2(MARGIN) + x1i2
      x2i2 = int2(SCREEN_WIDTH)-x1i2
      call random_number(y)
      y1i2 = int2(floor(y*real((SCREEN_HEIGHT-2*MARGIN+1), r4)))
      y1i2 = int2(MARGIN) + y1i2
      y2i2 = int2(SCREEN_HEIGHT)-y1i2
      call random_number(r)
      ri2 = int2(floor(r*256_r4))
      call random_number(g)
      gi2 = int2(floor(g*256_r4))
      call random_number(b)
      bi2 = int2(floor(b*256_r4))
      rc = aaline_rgba(renderer, x1i2, y1i2, x2i2, y2i2, uint8(ri2), uint8(gi2), uint8(bi2), &
                                  uint8(SDL_ALPHA_OPAQUE))
    end subroutine func20

    subroutine func19()
      ! aaline_color
      call random_number(x)
      x1i2 = int2(floor(x*real((SCREEN_WIDTH-2*MARGIN+1), r4)))
      x1i2 = int2(MARGIN) + x1i2
      x2i2 = int2(SCREEN_WIDTH)-x1i2
      call random_number(y)
      y1i2 = int2(floor(y*real((SCREEN_HEIGHT-2*MARGIN+1), r4)))
      y1i2 = int2(MARGIN) + y1i2
      y2i2 = int2(SCREEN_HEIGHT)-y1i2
      rc = aaline_color(renderer, x1i2, y1i2, x2i2, y2i2, blue)
    end subroutine func19

    subroutine func18()
      ! line_rgba
      call random_number(x)
      x1i2 = int2(floor(x*real((SCREEN_WIDTH-2*MARGIN+1), r4)))
      x1i2 = int2(MARGIN) + x1i2
      x2i2 = int2(SCREEN_WIDTH)-x1i2
      call random_number(y)
      y1i2 = int2(floor(y*real((SCREEN_HEIGHT-2*MARGIN+1), r4)))
      y1i2 = int2(MARGIN) + y1i2
      y2i2 = int2(SCREEN_HEIGHT)-y1i2
      call random_number(r)
      ri2 = int2(floor(r*256_r4))
      call random_number(g)
      gi2 = int2(floor(g*256_r4))
      call random_number(b)
      bi2 = int2(floor(b*256_r4))
      rc = line_rgba(renderer, x1i2, y1i2, x2i2, y2i2, uint8(ri2), uint8(gi2), uint8(bi2), &
                                  uint8(SDL_ALPHA_OPAQUE))
    end subroutine func18

    subroutine func17()
      ! line_color
      call random_number(x)
      x1i2 = int2(floor(x*real((SCREEN_WIDTH-2*MARGIN+1), r4)))
      x1i2 = int2(MARGIN) + x1i2
      x2i2 = int2(SCREEN_WIDTH)-x1i2
      call random_number(y)
      y1i2 = int2(floor(y*real((SCREEN_HEIGHT-2*MARGIN+1), r4)))
      y1i2 = int2(MARGIN) + y1i2
      y2i2 = int2(SCREEN_HEIGHT)-y1i2
      rc = line_color(renderer, x1i2, y1i2, x2i2, y2i2, green)
    end subroutine func17

    subroutine func16()
      ! irounded_box_rgba
      call random_number(x)
      x1i2 = int2(floor(x*real((SCREEN_WIDTH/2-2*MARGIN+1), r4)))
      x1i2 = int2(MARGIN) + x1i2
      x2i2 = int2(SCREEN_WIDTH)-x1i2
      y1i2 = int2(floor(x*real((SCREEN_HEIGHT/2-2*MARGIN+1), r4)))
      y1i2 = int2(MARGIN) + y1i2
      y2i2 = int2(SCREEN_HEIGHT)-y1i2
      radi2 = int2(MARGIN)
      call random_number(r)
      ri2 = int2(floor(r*256_r4))
      call random_number(g)
      gi2 = int2(floor(g*256_r4))
      call random_number(b)
      bi2 = int2(floor(b*256_r4))
      rc = rounded_box_rgba(renderer, x1i2, y1i2, x2i2, y2i2, radi2, uint8(ri2), uint8(gi2), uint8(bi2), &
                                  uint8(SDL_ALPHA_OPAQUE))
    end subroutine func16

    subroutine func15()
      ! rounded_box_color
      call random_number(x)
      x1i2 = int2(floor(x*real((SCREEN_WIDTH/2-2*MARGIN+1), r4)))
      x1i2 = int2(MARGIN) + x1i2
      x2i2 = int2(SCREEN_WIDTH)-x1i2
      y1i2 = int2(floor(x*real((SCREEN_HEIGHT/2-2*MARGIN+1), r4)))
      y1i2 = int2(MARGIN) + y1i2
      y2i2 = int2(SCREEN_HEIGHT)-y1i2
      radi2 = int2(MARGIN)
      rc = rounded_box_color(renderer, x1i2, y1i2, x2i2, y2i2, radi2, red)
    end subroutine func15

    subroutine func14()
      ! box_rgba
      call random_number(x)
      x1i2 = int2(floor(x*real((SCREEN_WIDTH/2-2*MARGIN+1), r4)))
      x1i2 = int2(MARGIN) + x1i2
      x2i2 = int2(SCREEN_WIDTH)-x1i2
      y1i2 = int2(floor(x*real((SCREEN_HEIGHT/2-2*MARGIN+1), r4)))
      y1i2 = int2(MARGIN) + y1i2
      y2i2 = int2(SCREEN_HEIGHT)-y1i2
      call random_number(r)
      ri2 = int2(floor(r*256_r4))
      call random_number(g)
      gi2 = int2(floor(g*256_r4))
      call random_number(b)
      bi2 = int2(floor(b*256_r4))
      rc = box_rgba(renderer, x1i2, y1i2, x2i2, y2i2, uint8(ri2), uint8(gi2), uint8(bi2), &
                                  uint8(SDL_ALPHA_OPAQUE))
    end subroutine func14

    subroutine func13()
      ! box_color
      call random_number(x)
      x1i2 = int2(floor(x*real((SCREEN_WIDTH/2-2*MARGIN+1), r4)))
      x1i2 = int2(MARGIN) + x1i2
      x2i2 = int2(SCREEN_WIDTH)-x1i2
      y1i2 = int2(floor(x*real((SCREEN_HEIGHT/2-2*MARGIN+1), r4)))
      y1i2 = int2(MARGIN) + y1i2
      y2i2 = int2(SCREEN_HEIGHT)-y1i2
      rc = box_color(renderer, x1i2, y1i2, x2i2, y2i2, cyan)
    end subroutine func13

    subroutine func12()
      ! rounded_rectangle_rgba
      call random_number(x)
      x1i2 = int2(floor(x*real((SCREEN_WIDTH/2-2*MARGIN+1), r4)))
      x1i2 = int2(MARGIN) + x1i2
      x2i2 = int2(SCREEN_WIDTH)-x1i2
      y1i2 = int2(floor(x*real((SCREEN_HEIGHT/2-2*MARGIN+1), r4)))
      y1i2 = int2(MARGIN) + y1i2
      y2i2 = int2(SCREEN_HEIGHT)-y1i2
      radi2 = int2(MARGIN)
      call random_number(r)
      ri2 = int2(floor(r*256_r4))
      call random_number(g)
      gi2 = int2(floor(g*256_r4))
      call random_number(b)
      bi2 = int2(floor(b*256_r4))
      rc = rounded_rectangle_rgba(renderer, x1i2, y1i2, x2i2, y2i2, radi2, uint8(ri2), uint8(gi2), uint8(bi2), &
                                  uint8(SDL_ALPHA_OPAQUE))
    end subroutine func12

    subroutine func11()
      ! rounded_rectangle_color
      call random_number(x)
      x1i2 = int2(floor(x*real((SCREEN_WIDTH/2-2*MARGIN+1), r4)))
      x1i2 = int2(MARGIN) + x1i2
      x2i2 = int2(SCREEN_WIDTH)-x1i2
      y1i2 = int2(floor(x*real((SCREEN_HEIGHT/2-2*MARGIN+1), r4)))
      y1i2 = int2(MARGIN) + y1i2
      y2i2 = int2(SCREEN_HEIGHT)-y1i2
      radi2 = int2(MARGIN)
      rc = rounded_rectangle_color(renderer, x1i2, y1i2, x2i2, y2i2, radi2, magenta)
    end subroutine func11

    subroutine func10()
      ! rectangle_rgba
      call random_number(x)
      x1i2 = int2(floor(x*real((SCREEN_WIDTH/2-2*MARGIN+1), r4)))
      x1i2 = int2(MARGIN) + x1i2
      x2i2 = int2(SCREEN_WIDTH)-x1i2
      y1i2 = int2(floor(x*real((SCREEN_HEIGHT/2-2*MARGIN+1), r4)))
      y1i2 = int2(MARGIN) + y1i2
      y2i2 = int2(SCREEN_HEIGHT)-y1i2
      call random_number(r)
      ri2 = int2(floor(r*256_r4))
      call random_number(g)
      gi2 = int2(floor(g*256_r4))
      call random_number(b)
      bi2 = int2(floor(b*256_r4))
      rc = rectangle_rgba(renderer, x1i2, y1i2, x2i2, y2i2, uint8(ri2), uint8(gi2), uint8(bi2), uint8(SDL_ALPHA_OPAQUE))
    end subroutine func10

    subroutine func09()
      ! rectangle_color
      call random_number(x)
      x1i2 = int2(floor(x*real((SCREEN_WIDTH/2-2*MARGIN+1), r4)))
      x1i2 = int2(MARGIN) + x1i2
      x2i2 = int2(SCREEN_WIDTH)-x1i2
      y1i2 = int2(floor(x*real((SCREEN_HEIGHT/2-2*MARGIN+1), r4)))
      y1i2 = int2(MARGIN) + y1i2
      y2i2 = int2(SCREEN_HEIGHT)-y1i2
      rc = rectangle_color(renderer, x1i2, y1i2, x2i2, y2i2, yellow)
    end subroutine func09

    subroutine func08()
      ! vline_rgba
      y1i2 = int2(MARGIN)
      y2i2 = int2(SCREEN_HEIGHT-MARGIN)
      call random_number(x)
      xi2 = int2(floor(x*real((SCREEN_WIDTH-2*MARGIN+1), r4)))
      xi2 = int2(MARGIN) + xi2
      call random_number(r)
      ri2 = int2(floor(r*256_r4))
      call random_number(g)
      gi2 = int2(floor(g*256_r4))
      call random_number(b)
      bi2 = int2(floor(b*256_r4))
      rc = vline_rgba(renderer, xi2, y1i2, y2i2, uint8(ri2), uint8(gi2), uint8(bi2), uint8(SDL_ALPHA_OPAQUE))
    end subroutine func08

    subroutine func07()
      ! vline_color
      y1i2 = int2(MARGIN)
      y2i2 = int2(SCREEN_HEIGHT-MARGIN)
      call random_number(x)
      xi2 = int2(floor(x*real((SCREEN_WIDTH-2*MARGIN+1), r4)))
      xi2 = int2(MARGIN) + xi2
      rc = vline_color(renderer, xi2, y1i2, y2i2, blue)
    end subroutine func07

    subroutine func06()
      ! hline_rgba
      x1i2 = int2(MARGIN)
      x2i2 = int2(SCREEN_WIDTH-MARGIN)
      call random_number(y)
      yi2 = int2(floor(y*real((SCREEN_HEIGHT-2*MARGIN+1), r4)))
      yi2 = int2(MARGIN) + yi2
      call random_number(r)
      ri2 = int2(floor(r*256_r4))
      call random_number(g)
      gi2 = int2(floor(g*256_r4))
      call random_number(b)
      bi2 = int2(floor(b*256_r4))
      rc = hline_rgba(renderer, x1i2, x2i2, yi2, uint8(ri2), uint8(gi2), uint8(bi2), uint8(SDL_ALPHA_OPAQUE))
    end subroutine func06

    subroutine func05()
      ! hline_color
      x1i2 = int2(MARGIN)
      x2i2 = int2(SCREEN_WIDTH-MARGIN)
      call random_number(y)
      yi2 = int2(floor(y*real((SCREEN_HEIGHT-2*MARGIN+1), r4)))
      yi2 = int2(MARGIN) + yi2
      rc = hline_color(renderer, x1i2, x2i2, yi2, green)
    end subroutine func05

    subroutine func04()
      ! pixel_rgba
      call random_number(x)
      xi2 = int2(floor(x*real((SCREEN_WIDTH-2*MARGIN+1), r4)))
      xi2 = int2(MARGIN) + xi2
      call random_number(y)
      yi2 = int2(floor(y*real((SCREEN_HEIGHT-2*MARGIN+1), r4)))
      yi2 = int2(MARGIN) + yi2
      call random_number(r)
      ri2 = int2(floor(r*256_r4))
      call random_number(g)
      gi2 = int2(floor(g*256_r4))
      call random_number(b)
      bi2 = int2(floor(b*256_r4))
      rc = pixel_rgba(renderer, xi2, yi2, uint8(ri2), uint8(gi2), uint8(bi2), uint8(SDL_ALPHA_OPAQUE))
    end subroutine func04

    subroutine func03()
      ! pixel_color
      call random_number(x)
      xi2 = int2(floor(x*real((SCREEN_WIDTH-2*MARGIN+1), r4)))
      xi2 = int2(MARGIN) + xi2
      call random_number(y)
      yi2 = int2(floor(y*real((SCREEN_HEIGHT-2*MARGIN+1), r4)))
      yi2 = int2(MARGIN) + yi2
      rc = pixel_color(renderer, xi2, yi2, red)
    end subroutine func03

    subroutine func02()
      ! string_rgba
      string = "WARNING - this produces strobe-like and flashing lights"
      xi2 = int2((SCREEN_WIDTH-string_length(string))/2)
      yi2 = SCREEN_HEIGHT/2_i2
      rc = string_rgba(renderer, xi2, yi2, nts(string), uint8(255), uint8(255), uint8(0), uint8(255))
    end subroutine func02

    subroutine func01()
      ! string_color
      string = "use arrow keys to navigate, press ESC to quit"
      xi2 = int2((SCREEN_WIDTH-string_length(string))/2)
      yi2 = SCREEN_HEIGHT/2_i2
      rc = string_color(renderer, xi2, yi2, nts(string), yellow)
    end subroutine func01

    function i2s(num) result(res)
      integer(i4), intent(in) :: num
      character(len = 100)    :: res
      write(res,*) num
    end function

    subroutine do_events()
      ! Catch events.
      do while (sdl_poll_event(event) > 0)
        select case (event%type)
          case (SDL_QUITEVENT)
            done = .true.
          case (SDL_KEYDOWN)
            select case (event%key%key_sym%scan_code)
              case (SDL_SCANCODE_ESCAPE)
                done = .true.
              case (SDL_SCANCODE_UP, SDL_SCANCODE_RIGHT)
                func = func + 1
                clear = .true.
                call clear_screen()
                if (func > maxfunc) func = 1
              case (SDL_SCANCODE_DOWN, SDL_SCANCODE_LEFT)
                func = func - 1
                clear = .true.
                call clear_screen()
                if (func < 1) func = maxfunc
              case default
            end select
          case default
        end select
      end do
    end subroutine do_events

    function nts(s1) result(res)
      character(len = *), intent(in)   :: s1
      character(len = len_trim(s1) + 1) :: res
      res = trim(s1) // c_null_char
    end function nts

    function string_length(s1) result(res)
      character(len = *), intent(in)   :: s1
      integer(i4)                      :: res
      res = len_trim(s1)*FONT_SIZE
    end function string_length

    subroutine clear_screen()
      rc = sdl_set_render_draw_color(renderer, uint8(0), uint8(0), uint8(0), uint8(SDL_ALPHA_OPAQUE))
      rc = sdl_render_clear(renderer)
      rc = rectangle_color(renderer, 0_i2, 0_i2, int2(SCREEN_WIDTH), int2(SCREEN_HEIGHT), white)
    end subroutine clear_screen

end program tst_primitives
