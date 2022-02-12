! Copyright (c), The Regents of the University of California
! Terms of use are as specified in LICENSE.txt
submodule(collective_subroutines_m) co_min_s
  use iso_c_binding, only : c_ptr, c_size_t, c_null_char, c_f_pointer, c_funloc
  use utilities_m, only : get_c_ptr, get_c_ptr_character, optional_value
  use caffeine_h_m, only : caf_c_co_min, caf_c_same_cfi_type, caf_c_numeric_type
  use assert_m, only : assert
  implicit none

contains

  module procedure caf_co_min
    type(c_ptr) stat_c_ptr, errmsg_c_ptr
    character(len=:), allocatable :: c_string
    character(len=:), pointer :: errmsg_f_ptr

    if (caf_c_numeric_type(a)) then
      stat_c_ptr = get_c_ptr(stat)
      c_string = errmsg // c_null_char
      errmsg_c_ptr = get_c_ptr_character(c_string)
      call caf_c_co_min(a, optional_value(result_image), stat_c_ptr, errmsg_c_ptr, int(product(shape(a)), c_size_t))
      call c_f_pointer(errmsg_c_ptr, errmsg_f_ptr)
      errmsg = errmsg_f_ptr
    else
      call caf_co_reduce(a, c_funloc(alphabetize), optional_value(result_image), stat, errmsg)
      call c_f_pointer(errmsg_c_ptr, errmsg_f_ptr)
      errmsg = errmsg_f_ptr
    end if

  contains

    pure function alphabetize(lhs, rhs) result(first_alphabetically)
      character(len=*), intent(in) :: lhs, rhs 
      character(len=:), allocatable :: first_alphabetically
      call assert(len(lhs)==len(rhs), "co_reduce_s alphabetize: LHS/RHS length match", lhs//" , "//rhs)
      first_alphabetically = min(lhs,rhs)
    end function

  end procedure

end submodule co_min_s
