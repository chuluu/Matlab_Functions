clear all
clc

%Whats the file?
%prompt = 'whats the song?!?';
wav = 'Zarathustra.wav'; %input(prompt, 's');
[y,fs] = audioread(wav);
audioinfo(wav)

mp3 = 'Zarathustra.mp3'; 
[y_mp3,fs_mp3] = audioread(mp3);
audioinfo(mp3)

y = y(:,1);
dt = 1/fs;
t = 0:dt:(length(y)*dt)-dt; %time from 0: in steps of sampling time:full length of y with respects to sampling time
plot(t,y,'b'); title('Good Sample'); xlabel('Seconds'); ylabel('Amplitude'); hold on
t_mp3 = 0:dt:(length(y_mp3)*dt)-dt;
plot(t_mp3,y_mp3,'r');


[Y,f] = MyFFT(y,1/fs,0);


%Downsample
% fs2 = 2000;
% audiowrite('desample.wav', y, fs2);
% [y_2 fs2] = audioread('desample.wav');
% figure
% y_2 = y_2(:,1);
% dt_2 = 1/fs2;
% t_2 = 0:dt_2:(length(y)*dt_2)-dt_2; %time from 0: in steps of sampling time:full length of y with respects to sampling time
% plot(t_2,y_2); title('DownSample'); xlabel('Seconds'); ylabel('Amplitude');
% % plot(psd(spectrum.periodogram,y,'Fs',fs,'NFFT',length(y)));