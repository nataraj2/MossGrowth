program main

	use module_global
	use module_initialize
	use module_timestep

	implicit none

	double precision :: LAI_forest !Just for testing. Computed elsewhere in code

	call initialize
	
	call read_inputs("inputs.inp", moss, num_moss)

	call output_initialization(moss, num_moss)
	
	!!!! LAI_forest computed elsewhere in code
	!call compute_LAI_forest
	LAI_forest = 0.01 ! Just for testing

	num_iterations = 2
	freq_output = 1

	call advance_timestep(num_moss, moss, LAI_forest, num_iterations, freq_output)

end program main


