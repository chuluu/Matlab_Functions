function P_E = percent_error(Approx,Experimental)
% P_E = percent_error(Approx,Experimental)
% Inputs:
% Approx = Approximate value
% Experimental = actual value to be found
% Outputs:
% P_E = percent error
% Info:
% By: Matthew Luu
% Last Edit: 5/17/2020
% Percent error of a value 

% Begin Code
    P_E = (abs(Approx - Experimental)./Experimental).*100;
    P_E = P_E( ~any( isnan( P_E ) | isinf( P_E ), 2 ),: );
end