function [y,t] = MyFFTConv(x,h,fs)
% Convolvles 2 signals together using FFT algorithm

%Set up length of FFT to zero pad such that we get an even signal
%throughout
N_x = length(x); 
N_h = length(h);
N_sum = N_x + N_h - 1;
N_sum_pow2 = nextpow2(N_sum);
N_sum_pow2 = 2.^N_sum_pow2;
N = N_sum_pow2 - 1;

%"Convolve" Multiply frequency domain signals
X = fft(x,N);
H = fft(h,N);
[m,n] = size(H);

if (m > 1)
    H = H;
else
    H = H';
end

Y = H.*X;

%Inverse fourier transform and obtain time domain output
y = real(ifft(Y));
dt = 1/fs;
t = 0:dt:(length(y)*dt)-dt;

