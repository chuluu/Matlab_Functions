function [rn,t] = fftcorrnorm(xn, yn, Fs)

rxx = fftcorr(xn, xn);
ryy = fftcorr(yn, yn);

Ex = rxx(1);
Ey = ryy(1);

rn = fftcorr(xn,yn)./sqrt(Ex*Ey);

nx = 0:length(xn)-1;
ny = 0:length(yn)-1;
k = 0:length(rn)-1;

dt = 1/Fs;
t = (0:1:length(rn)-1).*dt;  %Time domain from sampling rate
end