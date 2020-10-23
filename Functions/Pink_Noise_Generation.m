function [pn,PN] = Pink_Noise_Generation(N,dt)
% [pn,PN] = Pink_Noise_Generation(N,dt)
% Inputs:
% N  = number of saples
% dt = time differential
% Outputs:
% wn = Time Domain white noise
% WN = Frequency Domain white noise
% Info:
% By: Matthew Luu
% Last Edit: 9/17/2020
% Pink Noise generation through freq domain into time domain


% Magnitude Generation
    m = 0:1:N/2-1;
    Y_mag = 1./sqrt(m);
    Y_mag(1) = 0; %Inf for m = 1, so cap it

    % Phase Generation
    Y_phase_pos = (2*pi)*rand(1,N/2);
    Y_phase_pos(1) = 0;

    % Complex Number LS Generation
    Y_real_pos = Y_mag.*cos(Y_phase_pos);
    Y_imag_pos = Y_mag.*sin(Y_phase_pos);
    Y_pos = Y_real_pos + 1i*Y_imag_pos;
    Y_neg = conj(Y_pos);
    Y_neg = [Y_neg(1),flip(Y_neg(2:end))];
    PN    = [Y_pos,Y_neg];
    
    pn = real(ifft(PN))./dt;
    pn = ifftshift(pn);
end
