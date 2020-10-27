function [Cxy_order,t_new] = DC_time_shift(Cxy,fs)
% [Cxy_order,t_new] = DC_time_shift(Cxy,fs)
% Inputs:
% Cxy = Cross correlation without time shift
% fs  = sampling rate
% Outputs: 
% Cxy_order = Re-ordered cross correlation
% t_new     = time shifted time

% Begin Code:
    dt = 1/fs;
    N  = length(Cxy);
    if rem(N,2) == 0
        % even number of samples.
        t_new = (((N/-2)+1):(+N/2)).*dt;
        Cxy_order = fftshift(Cxy);
        old = Cxy_order((N/2));
        Cxy_order(N/2) = Cxy_order((N/2)+1);
        Cxy_order((N/2)+1) = old;
    else
        % odd number of samples.
        t_new = (((N-1)/-2):((N-1)/2)).*dt;
        Cxy_order = fftshift(Cxy);
    end
end