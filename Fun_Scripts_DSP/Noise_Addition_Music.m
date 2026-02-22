clear all
clc

%Original audio input plot sound
prompt = 'whats the song?!? ';
song = input(prompt, 's');
[y,fs] = audioread(song); %import Audio File
% p=audioplayer(y,fs); %original outfile sound
Y_mag = fft(y,fs);
size(y);

% Plotting Original Signal With Noise
figure(1);
b = Y_mag;                   % fast fourier transform
lnt = length(b);              
b = abs(b);                  
b = b(1:floor(lnt/2));   
f = (0:lnt/2-1)*fs/lnt;
subplot(2,1,1), plot(f,b);
title('Original Signal'); xlabel('Frequency'); ylabel('Magnitude');

% adding noise to audio file and Plotting
y_noise=awgn(y,10);
X_mag_Noise = fft(y_noise, fs);
lnt_Noise = length(X_mag_Noise);              
X_mag_Noise = abs(X_mag_Noise);                  
X_mag_Noise = X_mag_Noise(1:floor(lnt_Noise/2));   
f_noise = (0:lnt_Noise/2-1)*fs/lnt_Noise;
subplot(2,1,2), plot(f_noise,X_mag_Noise);
title('Noise Added'); xlabel('Frequency'); ylabel('Magnitude');

%Two methods to design a filter:
%designing a built in filter
% hlpf = fdesign.lowpass('Fp,Fst,Ap,Ast',3000,3500,0.5,50,fs); %Filter (lowpass)
% D = design(hlpf); 
% s = filter(D,y_noise); %convolve filter with Audio signal
% sound(s,fs); 
% clear sound

%butterworth filter?!?!?
%butter(order of filter, [points and stops], type)
[b_stop, a_stop] = butter(4, 0.3,'low'); % BandPass Filter: %[b_stop a_stop] = butter(4,[0 .3],'bandpass ');
num_bins = length(Y_mag);
H_response = freqz(b_stop,a_stop, floor(num_bins/2));

figure(2);
plot([0:1/(num_bins/2 -1):1], abs(H_response),'r');
title('Freq Response of LowPass Filter'); xlabel('Frequency'); ylabel('Magnitude');

%filters the original input signal
x_filtered = filter(b_stop,a_stop,y);

% %spectrogram practice
% y_new = y(:,1);
% length(y_new)
% subplot(2,2,1);
% %plot(psd(spectrum.periodogram,y_new,'Fs',fs,'NFFT',length(y_new)));
% %title('nonfiltered');

% x_new = x_filtered(:,1);
% length(x_new)
% subplot(2,2,2);
%plot(psd(spectrum.periodogram,x_new,'Fs',fs,'NFFT',length(x_new)));
%title('filtered bandpass');

%FFT Graphs
figure(3);
b_noise = X_mag_Noise;                   % fast fourier transform
lnt_noise_new = length(b_noise);              
b_noise = abs(b_noise);                  
b_noise = b_noise(1:floor(lnt_noise_new/2));   
f_noise_new = (0:lnt_noise_new/2-1)*fs/lnt_noise_new;
subplot(2,1,1), plot(f_noise_new,b_noise);
title('No Filter (Noise)'); xlabel('Frequency'); ylabel('Magnitude');

b_filter = fft(x_filtered);                   % fast fourier transform
lnt = length(b_filter);              
b_filter = abs(b_filter);                  
b_filter = b_filter(1:floor(lnt/2));
f_filter = (0:lnt/2-1)*fs/lnt;
subplot(2,1,2), plot(f_filter,b_filter);
title('filtered bandpass'); xlabel('Frequency'); ylabel('Magnitude');

%Prompt to play noise or no noise
Noise_or_No = '(1) For Noise, (2) For No Noise (Filter), (3) Poor Sampling Rate, (4) All Pass Filter, (5) Just the Song ';
choose = input(Noise_or_No);
if choose == 1
    sound(y_noise,fs);
elseif choose == 2
    sound(x_filtered,fs);
elseif choose == 3
    sampling_rate = 'What sampling rate you want? ';
    SR = input(sampling_rate);
    sound(y,SR);
    figure(4);
    y_SR_Low = fft(y,SR);
    lnt_SR_Low = length(y_SR_Low);              
    y_SR_Low = abs(y_SR_Low);                  
    y_SR_Low = y_SR_Low(1:floor(lnt_SR_Low/2));   
    f_SR_Low = (0:lnt_SR_Low/2-1)*fs/lnt_SR_Low;
    subplot(2,1,1); plot(f_SR_Low,y_SR_Low);
    title('Sampling Rate Changes'); xlabel('Frequency'); ylabel('Magnitude');
    subplot(2,1,2); plot(f,b);
    title('Original Signal'); xlabel('Frequency'); ylabel('Magnitude');
elseif choose == 4
    B = [1,1.3333,1.7778];
    A = [1,0.75,0.5625];
    Zeta_filtered = filter(B,A,y);
    sound(Zeta_filtered,fs);
else
    sound(y,fs);
end


