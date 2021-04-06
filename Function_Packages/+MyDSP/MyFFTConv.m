function [y,t] = MyFFTConv(x,h,fs,pad)
% [y,t] = MyFFTConv(x,h,fs)
% Inputs:
% x = signal 1 time array
% h = signal 2 time array
% fs = sampling rate
% pad = 'y' - keep zero pad part, 'n' - get rid of zero pad part
% Outputs:
% y = convolved time array signal
% t = time array for convolution
% Info:
% By: Matthew Luu
% Last Edit: 10/23/2020
% Convolvles 2 signals together using FFT algorithm

% Begin Code:
%Set up length of FFT to zero pad such that we get an even signal
%throughout

if nargin < 4
    pad = 'y'; 
end

N_x = length(x); 
N_h = length(h);
N_sum = N_x + N_h - 1;
N_sum_pow2 = nextpow2(N_sum);
N_sum_pow2 = 2.^N_sum_pow2;
N = N_sum_pow2 - 1;

if N_h > N_x
    T = N_x/fs;
    Nt = N_h;
elseif N_h == N_x
    T = N_x/fs;
    Nt = N_h;
else
    T = N_h/fs;
    Nt = N_x;
end

%N = N_x;
%"Convolve" Multiply frequency domain signals
X = fft(x,N);
H = fft(h,N);
[m,n] = size(H);

if (m == 1)
    H = H;
else
    H = H.';
end

Y = H.*X;
length(Y)
% 
% Y_ang = angle(Y);
% Y_mag = abs(Y);
% Y_ang = Y_ang - pi/2;
% Y = Y_mag.*cos(Y_ang) + 1i.*Y_mag.*sin(Y_ang);

%Inverse fourier transform and obtain time domain output
y = real(ifft(Y));
y = y(1:Nt);
if pad == 'y'
    dt = T/length(y);
    t = 0:dt:((length(y))*dt)-dt;
else
    dt = T/N_h;
    t = 0:dt:((N_h)*dt)-dt;
    %y = -flip(y(1:N_h)); % Quick hack fix, doesnt really work but it gets job
    % Phase is all wrong doing it this way, our goal is to try and kill the
    % zeros but there still needs to be some work and thought on how to do
    % that properly for now we just take conjugate essentially?
end

end