program main

	use module_timestep

	implicit none

	integer :: num_moss, num_iterations, freq_output
    type(moss_type), allocatable :: moss(:)

	double precision :: LAI_forest !Just for testing. Computed elsewhere in code
		
	num_moss = read_number_of_moss_types("inputs.inp");
    allocate(moss(num_moss))	

	call read_inputs("inputs.inp", moss, num_moss)

	call output_initialization(moss, num_moss)
	
	!!!! LAI_forest computed elsewhere in code
	!call compute_LAI_forest
	LAI_forest = 0.01 ! Just for testing

	num_iterations = 2
	freq_output = 1

	call advance_timestep(num_moss, moss, LAI_forest, num_iterations, freq_output)

end program main


