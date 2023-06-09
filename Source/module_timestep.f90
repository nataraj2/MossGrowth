module module_timestep

use module_io

implicit none

contains

	subroutine advance_timestep(num_moss, moss, LAI_forest, num_iterations, freq_output)
		implicit none

		integer, intent(in) :: num_moss
		type(moss_type), intent(inout) :: moss(num_moss)
		double precision, intent(in) :: LAI_forest
		integer, intent(in):: num_iterations, freq_output

		integer :: i, iter

		call open_output_files(num_moss)

		write(*,*)"Moss growth vs time"
		do i=1, num_moss
            write(i+10,*)iter, moss(i)%B
        end do	

		write(*,'(I3,12(F15.10))')0,(moss(i)%get_mass(),i=1,num_moss)
		do iter = 1, num_iterations
        	do i=1, num_moss
            	moss(i)%B = moss(i)%B + moss(i)%moss_productivity(LAI_forest)
        	end do

			if(mod(iter,freq_output).eq.0)then
        		do i=1, num_moss
            		write(i+10,*)iter, moss(i)%B
       			end do
			end if
			write(*,'(I3,12(F15.10))')iter,(moss(i)%get_mass(),i=1,num_moss)
		end do

		call close_output_files(num_moss)
		
	end subroutine advance_timestep


end module module_timestep
