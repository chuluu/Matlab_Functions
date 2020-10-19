function psi_AF = AF_Plotter(N,d,wavelength,theta,theta_not)
    Beta   = ((2*pi)/wavelength);
    alpha  = -Beta*d*cos(theta_not);
    psi    = alpha + Beta*d*cos(theta);
    psi_AF = Universal_AF(N,psi);
end
