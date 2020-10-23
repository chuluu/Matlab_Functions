function rn = fftcorr(xn, yn)
% rn = fftcorr(xn, yn)
%Inputs:
%x:    Data Array of first time domain signal
%h:    Data Array of second time domain signal
%Outputs:
%rn:    Correlated time domain signal
% Info:
% By: Matthew Luu, and 419 Partners
% Last edit: 3/17/2019
% One way for fftconv
% Correlates 2 signals together using FFT algorithm

% Begin Code:
Mx = length(xn);
My = length(yn);
M = Mx + My;
Mfft = 2.^nextpow2(M);

Xk = fft(xn, Mfft);
Yk = fft(yn, Mfft);

Rk = Xk .* conj(Yk);
rn = real(ifft(Rk));
%rn = rn(1:M-1);

end