function Cd = drag_coefficient(alt, mach)

% See: https://kth.diva-portal.org/smash/get/diva2:1881325/FULLTEXT01.pdf


c = [8.54*1e-5 1.96*1e-3 -0.357];
k = [0.657 -0.151 0.00979 0.440 -0.164 0.0740 72.1 0.985];

alt = alt*1e-3;

if mach < 0.02; mach = 0.02;   end
if alt < 0.2;    alt  = 0.2;   end

Cd_sea_level = ( (k(1) + k(2)*mach + k(3)*mach.^2 ) + (k(4) + k(5)*mach + k(6)*mach.^2).*exp(-k(7)*(mach - k(8)) )   )...
              ./( 1 + exp(-k(7)*(mach - k(8) ) ) );


delta_Cd     = alt .* (c(1).*alt + c(2) ).*(mach.^c(3));

Cd = Cd_sea_level + delta_Cd;
end