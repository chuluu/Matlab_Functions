function psi_AF = AF_Plotter(N,d,wavelength,theta,theta_not)
% psi_AF = AF_Plotter(N,d,wavelength,theta,theta_not)
% Inputs:
% N = number of arrays
% d = Phase array length
% wavelength = wavelength
% theta = angles to plot
% theta_not = cetner theta
% Outputs:
% psi_AF = Anetnna Factor 
% Info:
% By: Matthew Luu 
% Last edit: 5/17/2020
 

% Begin Code
    Beta   = ((2*pi)/wavelength);
    alpha  = -Beta*d*cos(theta_not);
    psi    = alpha + Beta*d*cos(theta);
    psi_AF = Universal_AF(N,psi);
end
