function polarplotterpro(theta,fnc)
% polarplotterpro(theta,fnc)
% Inputs:
% theta: theta array variable
% fnc:   Data that theta calculated
% Outputs:
% Figure --> Plot in cartesian form
% Info:
% By: Matthew Luu
% Last Edit: 5/27/2020

% Begin Code:
    y_a_r = fnc.*sin(theta);
    y_a_z = fnc.*cos(theta);
    plot(y_a_z,y_a_r); axis equal
    grid on
    title('Plotter','Fontsize',14); 
    xlabel('z - axis','Fontsize',14); 
    ylabel('rho - axis','Fontsize',14);
end