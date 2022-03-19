program manager

  use :: sdl2_gfx_misc
  use :: sdl2_gfx
  implicit none

  integer, parameter :: SCREEN_WIDTH = 640
  integer, parameter :: SCREEN_HEIGHT = 480
  integer, parameter :: FONT_SIZE = 8
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
  type(sdl_event) :: event
  ! type(sdl_surface), pointer :: image
  type(fpsmanager) :: fps

  integer :: rc, rate  !, n, s
  ! integer :: func = 1
  ! integer :: maxfunc = 58
  integer :: wi2, xi2, yi2, x1i2, x2i2, x3i2, y1i2, y2i2, y3i2, ri2, gi2, bi2, radi2, fromi2, toi2
  ! integer, dimension(0:2) :: vx, vy
  ! character(len=:), allocatable :: title, functitle, str
  ! character(len=:), allocatable :: str
  character(len=100) :: str
  logical :: done = .false.

  ! r=rand() & 255;
  ! g=rand() & 255;
  ! b=rand() & 255;

  ! initialise SDL
  if (sdl_init(SDL_INIT_VIDEO) < 0) error stop sdl_get_error()

  ! create the SDL window
  window = sdl_create_window(c_str('manager'), &
    SDL_WINDOWPOS_UNDEFINED, &
    SDL_WINDOWPOS_UNDEFINED, &
    SCREEN_WIDTH, &
    SCREEN_HEIGHT, &
    SDL_WINDOW_SHOWN)

  if (.not. sdl_associated(window)) error stop sdl_get_error()

  ! create the renderer
  renderer = sdl_create_renderer(window, -1, ior(SDL_RENDERER_ACCELERATED, SDL_RENDERER_TARGETTEXTURE))

  call initframerate(fps)

  ! print *, rate

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
  ! call sdl_free_surface(image)
  call sdl_destroy_renderer(renderer)
  call sdl_destroy_window(window)
  call sdl_quit()

  contains

    subroutine func01()
      ! string_color
      rate = getframerate(fps)
      write(str, *) rate
      ! str = "The quick brown fox ..."
      xi2 = (SCREEN_WIDTH-string_length(str, FONT_SIZE))/2
      yi2 = SCREEN_HEIGHT/2
      rc = string(renderer, xi2, yi2, str, yellow)
    end subroutine func01

end program manager

