module module_initialize

use module_io
use module_global
	
implicit none

contains

	subroutine initialize
		implicit none

		num_moss = read_number_of_moss_types("inputs.inp");
    	allocate(moss(num_moss))

	end subroutine initialize

end module module_initialize
