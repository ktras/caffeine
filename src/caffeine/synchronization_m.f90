! Copyright (c), The Regents of the University of California
! Terms of use are as specified in LICENSE.txt
module synchronization_m
    implicit none
    private
    public :: prif_sync_all
    
    interface

      module subroutine prif_sync_all()
      end subroutine

    end interface

end module synchronization_m
