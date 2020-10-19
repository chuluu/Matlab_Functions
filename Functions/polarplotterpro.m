function polarplotterpro(theta,fnc)
    y_a_r = fnc.*sin(theta);
    y_a_z = fnc.*cos(theta);
    plot(y_a_z,y_a_r); axis equal
    grid on
    title('Plotter','Fontsize',14); 
    xlabel('z - axis','Fontsize',14); 
    ylabel('rho - axis','Fontsize',14);
end