! Andre Smit - Feb 2021, MIT
program cfont

  use :: sdl2_gfx_misc
  use :: sdl2_gfx

  implicit none

  integer, parameter :: SCREEN_WIDTH = 640
  integer, parameter :: SCREEN_HEIGHT = 480
  integer :: FONT_SIZE = 10
  integer, parameter :: MARGIN = 64
  integer, parameter :: red = int(z'FF0000FF')
  integer, parameter :: green = int(z'FF00FF00')
  integer, parameter :: blue = int(z'FFFF0000')
  integer, parameter :: black = int(z'FF000000')
  integer, parameter :: yellow = ior(red, green)
  integer, parameter :: magenta = ior(red, blue)
  integer, parameter :: cyan = ior(green, blue)
  integer, parameter :: white = ior(yellow, magenta)

  type(sdl) :: window
  type(sdl) :: renderer
  type(sdl) :: font1
  type(sdl_event) :: event
  type(sdl_surface), pointer :: image

  ! real :: w, x, y, r, g, b, rad, from, to
  integer :: rc, n, s
  integer :: func = 1
  integer :: maxfunc = 58
  integer :: wi2, xi2, yi2, x1i2, x2i2, x3i2, y1i2, y2i2, y3i2, ri2, gi2, bi2, radi2, fromi2, toi2
  integer, dimension(0:2) :: vx, vy

  logical :: done = .false.
  logical :: clear = .true.

  character(len=:), allocatable :: title, functitle, str
  character(len=1) :: schar

  ! initialise SDL
  if (sdl_init(SDL_INIT_VIDEO) < 0) error stop sdl_get_error()

  ! create the SDL window
  window = sdl_create_window(c_str('tst_primitives'), &
    SDL_WINDOWPOS_UNDEFINED, &
    SDL_WINDOWPOS_UNDEFINED, &
    SCREEN_WIDTH, &
    SCREEN_HEIGHT, &
    SDL_WINDOW_SHOWN)

  if (.not. sdl_associated(window)) error stop sdl_get_error()

  ! create the renderer
  renderer = sdl_create_renderer(window, -1, ior(SDL_RENDERER_ACCELERATED, SDL_RENDERER_TARGETTEXTURE))
  font1 = loadfont(c_str('data/fonts/10x20i.fnt'))
  call set_font(font1, 10, 20)

  do while (.not. done)
    do while (sdl_poll_event(event) > 0)
      select case (event%type)
        case (SDL_QUITEVENT)
          done = .true.
        case (SDL_KEYDOWN)
          select case (event%key%key_sym%scan_code)
            case (SDL_SCANCODE_ESCAPE)
              done = .true.
            case default
          end select
        case default
      end select
    end do
    call func01()
    call sdl_render_present(renderer)
  end do

  ! cleanup and quit
  call sdl_free_surface(image)
  call sdl_destroy_renderer(renderer)
  call sdl_destroy_window(window)
  call sdl_quit()

  contains

  subroutine func01()
    ! string_color
    str = "The quick brown fox ..."
    xi2 = (SCREEN_WIDTH-string_length(str, FONT_SIZE))/2
    yi2 = SCREEN_HEIGHT/2
    rc = string(renderer, xi2, yi2, str, yellow)
  end subroutine func01

end program cfont
