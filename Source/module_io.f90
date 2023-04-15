module module_io

use module_moss

implicit none

contains

	subroutine read_inputs(input_filename, moss, num_moss)
		implicit none

		character(len=10), intent(in) :: input_filename 
		type(moss_type), intent(inout) :: moss(num_moss)
		integer, intent(in) :: num_moss
		
		integer :: err, i, dummy_int
		integer, parameter :: io_error = 1
		logical :: file_exists
		character(len=10) :: line
		double precision :: initial_mass, val
		! Open file with status specifier
		open(unit=10, file=input_filename, status='old', action='read', iostat=err)

		! Check if file was successfully opened
		file_exists = (err == 0)
		if (file_exists) then
			read(10,*)dummy_int
			do i = 1, num_moss
				read(10,*)val
				call moss(i)%set_mass(val)
				read(10,*)val
				call moss(i)%set_specific_leaf_area(val)
				read(10,*)val
				call moss(i)%set_max_prod_per_unit_area(val)
				read(10,*)val
				call moss(i)%set_resp_turnover(val)
				read(10,*)val
				call moss(i)%set_light_sat(val)
				read(10,*)val
				call moss(i)%set_light_comp(val)
				if(i.lt.num_moss)read(10, '(A)', iostat=err) line
			end do	
			close(10)
		else
			call file_opening_error(input_filename)
    		stop io_error
  		end if
		
	end subroutine read_inputs	
		

	function read_number_of_moss_types(input_filename) result(num_moss)
		implicit none

        character(len=10), intent(in) :: input_filename

		integer :: err, num_moss
        integer, parameter :: io_error = 1
        logical :: file_exists

        ! Open file with status specifier
        open(unit=10, file=input_filename, status='old', action='read', iostat=err)
		file_exists = (err == 0)
		if (file_exists) then
			read(10,*)num_moss
		else
			call file_opening_error(input_filename)
            stop io_error
        end if
		close(10)
	end function read_number_of_moss_types
			
	subroutine file_opening_error(input_filename)
		implicit none
		
		character(len=10) :: input_filename
		write(*,*) 'The inputs file ', input_filename, ' does not exist'
	end subroutine file_opening_error
		
	subroutine output_initialization(moss, num_moss)
		implicit none	

		integer, intent(in) :: num_moss
		type(moss_type), intent(in) :: moss(num_moss)
		
		integer :: i
	 	write(*,'(A40)')"Initialization parameters"
    	write(*,'(A5, A5, A12, A5, A13, A5, A10, A5, A20, A5, A10, A5, A10)')"Index", " ", "Initial mass", " " , "Specific Area", &
														 " ", "Max. Prod.", " ", "Resp and turnover", " ", "Light sat", " " , "Light comp"

    	do i= 1, num_moss
        	write(*, '(I2, A10, F8.4, A10, F8.4, A8, F8.4, A10, F8.4, A15, F8.4, A5, F8.4)')i, " ", moss(i)%get_mass(), &
										  " " , moss(i)%get_specific_leaf_area(), &
                                          " ", moss(i)%get_max_prod_per_unit_area(), &
                                          " ", moss(i)%get_resp_turnover(),&
										  " ", moss(i)%get_light_sat(), &
										  " ", moss(i)%get_light_comp()
    	end do
	end subroutine output_initialization


	subroutine open_output_files(num_moss)
		implicit none

		integer, intent(in) :: num_moss	

		integer :: i, iter
        character(len=20) :: format_string
        character(len=40) :: filename
        character(len=100) :: dir_path
        logical :: dirExists

        dir_path = "Output"
        inquire(file=dir_path,exist=dirExists)
        if(dirExists)then
            call SYSTEM("rm -rf "//trim(dir_path))
            call SYSTEM("mkdir "//trim(dir_path))
        else
            call SYSTEM("mkdir "//trim(dir_path))
        end if

        if(num_moss .lt. 10)then
            format_string = '(A,I0.1,A)'
        else if(num_moss .le. 100)then
            format_string = '(A,I0.2,A)'
        else if(num_moss .le. 1000)then
            format_string = '(A,I0.3,A)'
        else if(num_moss .le. 10000)then
            format_string = '(A,I0.4,A)'
        else if(num_moss .le. 100000)then
            format_string = '(A,I0.5,A)'
        else if(num_moss .le. 1000000)then
            format_string = '(A,I0.6,A)'
        else if(num_moss .le. 10000000)then
            format_string = '(A,I0.7,A)'
        else if(num_moss .le. 100000000)then
            format_string = '(A,I0.8,A)'
        else if(num_moss .le. 1000000000)then
            format_string = '(A,I0.9,A)'
        endif

        do i=1,num_moss
            filename = './Output/output'
            write(filename, trim(format_string)) TRIM(filename), i,".txt"
            open(unit=i,file=filename,position='append')
        end do
	end subroutine open_output_files

	subroutine close_output_files(num_moss)
		implicit none

		integer, intent(in) :: num_moss

		integer :: i
		
		do i=1,num_moss
            close(i)
        end do
	end subroutine close_output_files


end module module_io
