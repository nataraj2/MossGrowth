module module_moss

implicit none

type :: moss_type
	double precision :: B, S_l, A_max, q, l_sat, l_comp
contains 
	procedure :: set_mass
	procedure :: set_specific_leaf_area
	procedure :: set_max_prod_per_unit_area
	procedure :: set_resp_turnover
	procedure :: set_light_sat
	procedure :: set_light_comp
	procedure :: get_mass
	procedure :: get_specific_leaf_area
	procedure :: get_max_prod_per_unit_area
	procedure :: get_resp_turnover
	procedure :: get_light_sat
	procedure :: get_light_comp
	procedure :: moss_productivity	
	
	
end type moss_type

contains

	subroutine set_mass(this, val)
		implicit none
		class(moss_type), intent(inout) :: this
		double precision, intent(in) :: val
		this%B = val
	end subroutine set_mass

	subroutine set_specific_leaf_area(this, val)
		implicit none
		class(moss_type), intent(inout) :: this
		double precision, intent(in) :: val
		this%S_l = val
	end subroutine set_specific_leaf_area

	subroutine set_max_prod_per_unit_area(this, val)
		implicit none
		class(moss_type), intent(inout) :: this
		double precision, intent(in) :: val
		this%A_max = val
	end subroutine set_max_prod_per_unit_area

	subroutine set_resp_turnover(this,val)
		implicit none
		class(moss_type), intent(inout) :: this
		double precision, intent(in) :: val
		this%q = val
	end subroutine set_resp_turnover

	subroutine set_light_sat(this,val)
		implicit none
		class(moss_type), intent(inout) :: this
		double precision, intent(in) :: val
		this%l_sat = val
	end subroutine set_light_sat

	subroutine set_light_comp(this,val)
		implicit none
		class(moss_type), intent(inout) :: this
		double precision, intent(in) :: val
		this%l_comp = val
	end subroutine set_light_comp
	
	function get_mass(this) result(mass)
		class(moss_type), intent(in) :: this
		double precision :: mass
		mass = this%B
	end function get_mass

	function get_specific_leaf_area(this) result(S_l)
		implicit none
        class(moss_type), intent(in) :: this
		double precision :: S_l
        S_l = this%S_l
    end function get_specific_leaf_area

	function get_max_prod_per_unit_area(this) result(A_max)
		implicit none
        class(moss_type), intent(in) :: this
		double precision :: A_max
        A_max = this%A_max
    end function get_max_prod_per_unit_area

	function get_resp_turnover(this) result(q)
		implicit none
		class(moss_type), intent(in) :: this
		double precision :: q
		q = this%q
	end function get_resp_turnover

	function get_light_sat(this) result(l_sat)
		implicit none
		class(moss_type), intent(in) :: this
		double precision :: l_sat
		l_sat = this%l_sat
	end function get_light_sat

	function get_light_comp(this) result(l_comp)
		implicit none
		class(moss_type), intent(in) :: this
		double precision :: l_comp
		l_comp = this%l_comp
	end function get_light_comp

	function moss_productivity(this, LAI_forest) result(P)
		implicit none
        class(moss_type), intent(in) :: this
		double precision, intent(in) :: LAI_forest
		double precision :: LAI_moss, f_light, P
		
		! f_light = exp(-0.7*(LAI_forest+LAI_moss)-l_comp))/(l_sat-l_comp)

		LAI_moss = this%B*this%S_l
		f_light = (exp(-0.7*(LAI_forest+LAI_moss)-this%l_comp))/(this%l_sat-this%l_comp)
		P = this%S_l*this%A_max*f_light*this%B - this%B*this%q
	end function moss_productivity 
		
end module module_moss
