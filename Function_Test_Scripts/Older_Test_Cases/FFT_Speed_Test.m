%% Set up Data
%Input Data here
Fs = 4000;
n = 0:1/Fs:1;
data =  sin(2*pi*1000*n);

% data = [1, -1, 1, -1, 1, -1, 1, -1, 1];
%% Test Data
disp('Weak Definition DFT')
tic 
FFT_S = weakfft(data);
toc

disp('KISS Cooley-Turkey FFT')
tic
[FFT_Result,f] = SuperFFT(data,Fs);
toc

disp('MatLAB fft')
tic
[FFT_R,f_R] = MyFFT(data,1/Fs,0);
toc


%% Graphing Will always graph
FFT_abs = abs(FFT_Result);
FFT_phase = angle(FFT_Result);

FFT_abs = fftshift(FFT_abs);    % Put DC in the middle.
subplot(2,1,1); plot(f,FFT_abs); title('FFT (Magnitude)');
subplot(2,1,2); plot(f,FFT_phase); title('FFT (Phase)');


