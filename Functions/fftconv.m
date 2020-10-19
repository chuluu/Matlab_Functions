function [y,Y,t] = fftconv(x,h,fs,figure_num)
% Convolvles 2 signals together using FFT algorithm
%Inputs:
%x:    Data Array of first time domain signal
%h:    Data Array of second time domain signal
%fs:   Sampling rate
%figure_num:   label figures generated

%Outputs:
%y:    Convolved time domain signal
%t:    Time samples based off of sampling rate

%Figure Outputs:
%figure_num: time domain plots of x,h, and y
%figure_num + 1:  Digital Frequency Spectrum of X, H, and Y
%figure_num + 2:  Analog frequency Spectrum of X, H, and Y

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
[X_m,X_n] = size(X); %Used to check for inccorect matrix multiplication
[H_m,H_n] = size(H); %Used to check for inccorect matrix multiplication

if (H_n == X_n)  %Used to check for inccorect matrix multiplication
    H = H;
else
    H = H';
end

Y = H.*X;
[Y_m,Y_n] = size(Y);

if (Y_n > 1)  %Used to properly have the right array length
    Y = Y';
end

%Inverse fourier transform and obtain time domain output
y = real(ifft(Y));
n_y = 0:1:length(y)-1;
n_y = n_y';
dt = 1/fs;
t = (0:1:length(y)-1).*dt;  %Time domain from sampling rate

% Plotting
% Time Domain
n_x = 0:1:N_x-1;
n_h = 0:1:N_h-1;
n_y = 0:1:length(y)-1;
figure(figure_num);
subplot(3,1,1); stem(n_x,x); title('x[n] Sequence'); xlabel('Sample n'); ylabel('Amplitude');
subplot(3,1,2); stem(n_h,h); title('h[n] Sequence'); xlabel('Sample n'); ylabel('Amplitude');
subplot(3,1,3); stem(n_y,y); title('y[n] Sequence'); xlabel('Sample n'); ylabel('Amplitude');

% Frequency Domain Digital
%[X_c,f_x] = plot_DFT_mag(x,fs,figure_num+1);
%[H_c,f_h] = plot_DFT_mag(h,fs,figure_num+2);
%[Y_c,f_y] = plot_DFT_mag(y,fs,figure_num+3);
F = (0:1:N-1)./N;
figure(figure_num+1);
subplot(3,1,1); plot(F,abs(X)); title('X[k] Spectrum'); ylabel('Magnitude Response'); xlabel('Digital Frequency (cyc/sample)');
subplot(3,1,2); plot(F,abs(H)); title('H[k] Spectrum'); ylabel('Magnitude Response'); xlabel('Digital Frequency (cyc/sample)');
subplot(3,1,3); plot(F,abs(Y)); title('Y[k] Spectrum'); ylabel('Magnitude Response'); xlabel('Digital Frequency (cyc/sample)');

% Analog
if rem(N,2) == 0
    % even number of samples.
    f = fs*((N/-2):(-1+N/2))/N;
else
    % odd number of samples.
    f = fs*(((N-1)/-2):((N-1)/2))/N;
end
figure(figure_num+2);
subplot(3,1,1); plot(f,abs(X)); title('X[f] Spectrum'); ylabel('Magnitude Response'); xlabel('Analog Frequency (Hz)');
subplot(3,1,2); plot(f,abs(H)); title('H[f] Spectrum'); ylabel('Magnitude Response'); xlabel('Analog Frequency (Hz)');
subplot(3,1,3); plot(f,abs(Y)); title('Y[f] Spectrum'); ylabel('Magnitude Response'); xlabel('Analog Frequency (Hz)');


end

