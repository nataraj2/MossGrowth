module module_global

use module_moss	

implicit none

	integer :: num_moss, num_iterations, freq_output
	type(moss_type), allocatable :: moss(:)

end module module_global
