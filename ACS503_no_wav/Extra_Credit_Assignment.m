%% 
% Create a linear frequency sweep (LFM) using a sample rate of 
% 48000 samples per second, 
% sweeping from 3000 Hz to 1000 Hz from t = 0 to t = 2.0 seconds.

fs  = 48000;
Tp  = 2;
f1  = 3000;
f2  = 1000;

[xn,t] = LFM_Pulse(f1,f2,Tp,fs);
subplot(3,1,1); plot(t,xn);

% Test the pulse look at freq domain
[X,f]  = MyFFT(xn,fs);
subplot(3,1,2); plot(f,abs(X));
xlim([0 5000]);

% Also look at spectrogram domain
subplot(3,1,3); [Gxx_array,dB_vals,t_array_big,f_array_big] = MYSpectrogram(...
    xn,500,0.5,fs);