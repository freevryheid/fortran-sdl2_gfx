module sdl2_gfx_misc
  ! @Note: everything in here is public
  use, intrinsic :: iso_c_binding, sdl => c_ptr, sdl_associated => c_associated
  use, intrinsic :: iso_fortran_env, stdin => input_unit, stdout => output_unit, stderr => error_unit
  use sdl2

  implicit none

  interface

    ! char *loadFont(char *name)
    function loadfont(name) bind(c, name='loadFont') result(r)
      import :: c_char, c_ptr
      implicit none
      character(kind=c_char), intent(in) :: name
      type(c_ptr) :: r
    end function loadfont

  end interface

  contains

    function c_str(fstr)
      character(len=*), intent(in) :: fstr
      character(len=:), allocatable :: c_str
      c_str = trim(fstr) // c_null_char
    end function c_str

    function string_length(s1, fontsize) result(res)
      character(len=*), intent(in) :: s1
      integer, intent(in) :: fontsize
      integer :: res
      res = len_trim(s1)*fontsize
    end function string_length

end module sdl2_gfx_misc
