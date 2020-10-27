function c = Wave_Speed(E,rho,v)
% c = Wave_Speed(E,rho,v)
% Inputs:
% E   = Young's Modulus (Pa)
% rho = Density (kg/m3)
% v   = Poisson's Ratio (can be ommited if E and rho are only provided)
% Outputs:
% c = Wave Speed
% Info:
% By: Matthew Luu
% Last Edit: 10/27/2020
% Calculates Longitudinal sound speed

% Begin Code
    if nargin < 3
        disp(['Approx no poisson']);
        c = sqrt((E/rho));
    else
        disp(['longitudinal w/ poisson']);
        C_part = (1-v)/((1+v)*(1-(2*v)));
        c = sqrt((E/rho)*C_part);
    end
end