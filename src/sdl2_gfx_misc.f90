module sdl2_gfx_misc
! @Note: everything in here is public
use, intrinsic :: iso_c_binding, sdl => c_ptr, sdl_associated => c_associated
use, intrinsic :: iso_fortran_env, stdout => output_unit, stderr => error_unit
use sdl2

implicit none

contains

function c_str(fstr)
  character(len=*), intent(in) :: fstr
  character(len=:), allocatable :: c_str
  c_str = trim(fstr) // c_null_char
end function c_str

end module sdl2_gfx_misc
