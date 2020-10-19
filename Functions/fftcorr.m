function rn = fftcorr(xn, yn)
%FFTCORR Fast cross correlation using fft
% Arguments:
% xn - first signal
% yn - second signal

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