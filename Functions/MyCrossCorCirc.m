function [Cxy] = MyCrossCorCirc(xn, yn)
% [Cxy] = MyCrossCorCirc(xn, yn)
% Inputs:
% x:    Data Array of first time domain signal
% yn:    Data Array of second time domain signal
% Outputs:
% Cxy:    Convolved time domain signal
% By: Matthew Luu
% Last Edit: 10/22/2020
% Finds Cxy 2 signals using circular method

% Begin Code:
%Set up length of FFT to zero pad such that we get an even signal
%throughout
if xn > yn
    N = length(xn);
else
    N = length(yn);
end
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