! SDL2_framerate.h: framerate manager

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

! Fortran bindings: Andre Smit  -- freevryheid at gmail dot com*/

module framerate

use, intrinsic                         :: iso_c_binding
use                                    :: c_util
! use                                    :: sdl2_surface

implicit none

integer(  kind=c_int), parameter       :: FPS_UPPER_LIMIT = 200
  !! Highest possible rate supported by framerate controller in Hz (1/s).
integer(  kind=c_int), parameter       :: FPS_LOWER_LIMIT = 1
  !! Lowest possible rate supported by framerate controller in Hz (1/s).
integer(  kind=c_int), parameter       :: FPS_DEFAULT = 30
  !! Default rate of framerate controller in Hz (1/s).

type, bind(c)                          :: fpsmanager
  integer(kind=c_uint32_t)             :: framecount
  real(   kind=c_float)                :: rateticks
  integer(kind=c_uint32_t)             :: baseticks
  integer(kind=c_uint32_t)             :: lastticks
  integer(kind=c_uint32_t)             :: rate
end type fpsmanager

interface

! SDL2_FRAMERATE_SCOPE void SDL_initFramerate(FPSmanager * manager);
function sdl_initframerate(manager) bind(c, name='SDL_initFramerate')
  import                               :: c_int, fpsmanager
  type(fpsmanager), intent(in)         :: manager
  integer(kind=c_int)                  :: sdl_initframerate
end function sdl_initframerate

! SDL2_FRAMERATE_SCOPE int SDL_setFramerate(FPSmanager * manager, Uint32 rate);
function sdl_setframerate(manager, rate) bind(c, name='SDL_setFramerate')
  import                               :: c_int, c_uint32_t, fpsmanager
  type(fpsmanager), intent(in)         :: manager
  integer(kind=c_uint32_t), intent(in) :: rate
  integer(kind=c_int)                  :: sdl_setframerate
end function sdl_setframerate

! SDL2_FRAMERATE_SCOPE int SDL_getFramerate(FPSmanager * manager);
function sdl_getframerate(manager) bind(c, name='SDL_getFramerate')
  import                               :: c_int, fpsmanager
  type(fpsmanager), intent(in)         :: manager
  integer(kind=c_int)                  :: sdl_getframerate
end function sdl_getframerate

! SDL2_FRAMERATE_SCOPE int SDL_getFramecount(FPSmanager * manager);
function sdl_getframecount(manager) bind(c, name='SDL_getFramecount')
  import                               :: c_int, fpsmanager
  type(fpsmanager), intent(in)         :: manager
  integer(kind=c_int)                  :: sdl_getframecount
end function sdl_getframecount

! SDL2_FRAMERATE_SCOPE Uint32 SDL_framerateDelay(FPSmanager * manager);
function sdl_frameratedelay(manager) bind(c, name='SDL_framerateDelay')
  import                               :: c_int, fpsmanager
  type(fpsmanager), intent(in)         :: manager
  integer(kind=c_int)                  :: sdl_frameratedelay
end function sdl_frameratedelay

end interface

end module framerate

