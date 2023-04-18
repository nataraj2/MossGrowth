# Moss Growth

Moss grows according to the equation


$B(t) = B(t-1) + P(t)$

where $B(t)$ is the moss biomass (kgC) at time step `$t$, $B(t-1)$ is the biomass 
at the previous time step, and $P(t)$ is the moss productivity at the time step $t$

Moss productivity is calculated as 

$P(t) = S_lA_{max}f_{light}B(t-1) - B(t-1)q$

where $S_l$ is the moss specific leaf area, $A_{max}$ is the moss maximum productivity, 
$f_{light}$ is a growth response factor, and $q$ is a respiration and turnover parameter. 
$f_{light}$ is calculated as 

$f_{light} = \frac{exp(-0.7(LAI_{forest}+LAI_{moss})-l_{comp})}{l_{sat}-l_{comp}}$  

where $LAI_{forest}$ is the leaf area index of the forest, $LAI_{moss} = B\times S_l$ 
is the leaf area index of the moss, $l_{sat}$ is the light saturations point, and 
$l_{comp}$ is the light compensation point.
