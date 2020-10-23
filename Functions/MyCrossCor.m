function [Cxy] = MyCrossCor(xn, yn)
% [Cxy] = MyCrossCor(xn, yn)
% Inputs:
% x:    Data Array of first time domain signal
% h:    Data Array of second time domain signal
% fs:   Sampling rate
% Outputs:
% Cxy:    Convolved time domain signal
% t:    Time samples based off of sampling rate
% By: Matthew Luu
% Last Edit: 10/22/2020
% Finds Cxy 2 signals

% Begin Code:
%Set up length of FFT to zero pad such that we get an even signal
%throughout
N_x = length(xn); 
N_h = length(yn);
N_sum = N_x + N_h - 1;
N_sum_pow2 = nextpow2(N_sum);
N_sum_pow2 = 2.^N_sum_pow2;
N = N_sum_pow2 - 1;
%"Convolve" Multiply frequency domain signals
X = fft(xn,N);
Y = fft(yn,N);
Y = conj(Y);
[X_m,X_n] = size(X); %Used to check for inccorect matrix multiplication
[Y_m,Y_n] = size(Y); %Used to check for inccorect matrix multiplication

if (Y_n == X_n)  %Used to check for inccorect matrix multiplication
    Y = Y;
else
    Y = Y';
end

% AutoCorrelation Section:
XX  = X.*conj(X);
YY  = Y.*conj(Y);
CXY = Y.*X;

[CXY_m,CXY_n] = size(CXY);

if (CXY_n > 1)  %Used to properly have the right array length
    CXY = CXY';
end

%Inverse fourier transform and obtain time domain output
Cxy = real(ifft(CXY));
xx = real(ifft(XX));
yy = real(ifft(YY));
Cxy = Cxy./(sqrt(xx(1)*yy(1)));
end