function [wn,WN] = White_Noise_Generation(N,dt)
% [wn,WN] = White_Noise_Generation(N,dt)
% Inputs:
% N  = number of saples
% dt = time differential
% Outputs:
% wn = Time Domain white noise
% WN = Frequency Domain white noise
    % Magnitude Generation
    Y_mag = ones(1,N);

    % Phase Generation
    Y_phase_pos = (2*pi)*rand(1,N/2);
    Y_phase_pos(1) = 0;

    % Complex Number LS Generation
    Y_real_pos = Y_mag(N/2:end-1).*cos(Y_phase_pos);
    Y_imag_pos = Y_mag(N/2:end-1).*sin(Y_phase_pos);
    Y_pos = Y_real_pos + 1i*Y_imag_pos;
    Y_neg = conj(Y_pos);
    Y_neg = [Y_neg(1),flip(Y_neg(2:end))];
    WN    = [Y_pos,Y_neg];
    
    
    wn = ifft(WN)./dt;
    wn = real(wn);
    wn = ifftshift(wn);
end
