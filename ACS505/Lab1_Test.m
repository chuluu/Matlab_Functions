%% Intro
% Test Case for MyModeStringSolver

clc
clear
[filepath,~,~] = fileparts(pwd);
newpath = [filepath,'\Function_Packages'];
addpath(newpath);
Intro();

%% Input data
Dat = importfile('assasd.csv');

Dat_arr  = table2array(Dat);
BLK_Size = str2num(Dat_arr(2,1));       % Blocksize constant
fs       = str2num(Dat_arr(2,2));           % Sampling rate constant
avg      = str2num(Dat_arr(2,3));           % Sampling rate constant
t        = ((0:1:BLK_Size-1)./fs);             % Time array for time plotting

% Personal preference to seperate columns (This is a waist of variables rly
Col1 = Dat_arr(:,1);
Col2 = Dat_arr(:,2);
Col3 = Dat_arr(:,3);
Col4 = Dat_arr(:,4);
Col5 = Dat_arr(:,5);

%% Parse through time data

% We can locate certain data by the missing table values.
MIS = ismissing(Col2);         % Locate SSSSS
MIS_ind = find(MIS == 1);      % Find missing in logical array
avg_start = MIS_ind(5:5:end);  % Index by 5 (just the way the data is set up
avg_end = MIS_ind(1:5:end);

% Get the channel1 and channel2 time data
CH1 = [];
for ii = 1:avg
    CH1(ii,:) = Col2(avg_start(ii)+1:avg_end(ii+1)-1);
    CH1_win(ii,:)   = CH1(ii,:).*(hann(500).');
end

CH2 = [];
for ii = 1:avg
    CH2(ii,:) = Col3(avg_start(ii)+1:avg_end(ii+1)-1);
    CH2_win(ii,:)   = CH2(ii,:).*(hann(500).');
end

% Format the data correctly for PSDX fnc and plot the channels
CH1_big = [];
CH2_big = [];
for ii = 1:avg
    figure(1);
    plot(t,CH1(ii,:)); hold on;
    CH1_big = [CH1_big,CH1(ii,:)];
    
    figure(2);
    plot(t,CH2(ii,:)); hold on;
    CH2_big = [CH2_big,CH2(ii,:)];
end

CH1_avg = sum(CH1_win,1)./avg;
CH2_avg = sum(CH2_win,1)./avg;
N = length(CH1_big);

% Output CH1
% Output CH2
% Output CH1_big
% Output CH2_big

%% PSDX - Works
[Nrecs,~] = size(CH1);
[Gxx_avg1,f_Gxx1] = MyDSP.MyAvgGxx(CH1_big,fs,Nrecs,hann(N/Nrecs));
[Gxx_avg2,~] = MyDSP.MyAvgGxx(CH2_big,fs,Nrecs,hann(N/Nrecs));
[Gxx_avg12,f_Gxx2] = MyDSP.MyAvgGxx(CH2_big./CH1_big,fs,Nrecs,hann(N/Nrecs));

figure(3);
plot(f_Gxx1,10*log10(Gxx_avg1)); hold on;
plot(f_Gxx2,10*log10(Gxx_avg2));
MyGen.title_plots('PSDX','Frequency (Hz)','Mag (WU/Hz^2)',10);
xlim([f_Gxx1(1) f_Gxx1(end)]); 
grid on;


%% Test FFT channels - Doesn't Work, the averaging part doesn't work, but the fft part works
% This is because the magnitude is the same when only 1 sample is used. So
% going from 1 sample to multiple samples is screwing smthn up

win = hann(N/Nrecs);
window = win.';
L_window = length(window);
ms = sum(window.*window)/L_window;
win = window/sqrt(ms);

for ii = 1:avg
    [H1(ii,:),f1] = MyDSP.MyFFT(CH1(ii,:).*win,fs,'n');
    [H2(ii,:),f2] = MyDSP.MyFFT(CH2(ii,:).*win,fs,'n');

    mag1(ii,:) = H2(ii,:)./H1(ii,:);
    mag2(ii,:) = H1(ii,:)./H1(ii,:);

    mag1_avg(ii,:) = sum(mag1,1)./avg;
    mag2_avg(ii,:) = sum(mag2,1)./avg;
end

mag1_avg = (sum(mag1,1)./avg);
mag2_avg = (sum(mag2,1)./avg);

H1_avg = sum(H1,1)./avg;
H2_avg = sum(H2,1)./avg;

mag1_avg2 = H2_avg./H1_avg;
mag2_avg2 = H1_avg./H1_avg;

% [H1,f1] = MyDSP.MyFFT(CH1(7,:).*win,fs,'n');
% [H2,f2] = MyDSP.MyFFT(CH2(7,:).*win,fs,'n');
% 
% mag1_avg = H2./H1./avg;
% mag2_avg = H1./H1./avg;
[FRF_mag1,FRF_mag2,FRF_ang1,FRF_ang2] = Get_FRF(mag1_avg,mag2_avg);
[FRF1_mag1,FRF1_mag2,FRF1_ang1,FRF1_ang2] = Get_FRF(mag1_avg2,mag2_avg2);

% Method 2 
% for ii = 1:avg
%     [H1(ii,:),f1] = MyDSP.MyFFT(CH1(ii,:).*win,fs,'n');
%     [H2(ii,:),f2] = MyDSP.MyFFT(CH2(ii,:).*win,fs,'n');
% 
%     mag1(ii,:) = abs(H2(ii,:))./abs(H1(ii,:));
%     mag2(ii,:) = abs(H1(ii,:))./abs(H1(ii,:));
%     ang1(ii,:) = angle(H2(ii,:)) - angle(H1(ii,:));
%     ang2(ii,:) = angle(H1(ii,:)) - angle(H1(ii,:));
% end
% 
% FRF_mag1 = sum(mag1,1)./avg;
% FRF_mag2 = sum(mag2,1)./avg;
% 
% FRF_ang1 = sum(ang1,1)./avg;
% FRF_ang2 = sum(ang2,1)./avg;


% Old way of doing it
% [H_avg1,f1] = MyDSP.MyAvgFFT(CH1_big,fs,Nrecs,hann(N/Nrecs));
% [H_avg2,~] = MyDSP.MyAvgFFT(CH2_big,fs,Nrecs,hann(N/Nrecs));
% 
% FRF_mag1 = abs(H_avg2)./abs(H_avg1);
% FRF_mag2 = abs(H_avg1)./abs(H_avg1);
% FRF_ang1 = angle(H_avg2) - angle(H_avg1);
% FRF_ang2 = angle(H_avg1) - angle(H_avg1);

subplot(2,1,1);
plot(f1(1:end/2),20*log10(abs(FRF_mag1(1:end/2)))); hold on;
plot(f1(1:end/2),20*log10(abs(FRF_mag2(1:end/2))));
plot(f1(1:end/2),20*log10(abs(FRF1_mag1(1:end/2)))); hold on;
plot(f1(1:end/2),20*log10(abs(FRF1_mag2(1:end/2))));

subplot(2,1,2);
plot(f1(1:end/2),rad2deg(FRF_ang1(1:end/2))); hold on;
plot(f1(1:end/2),rad2deg(FRF_ang2(1:end/2)));
plot(f1(1:end/2),rad2deg(FRF1_ang1(1:end/2))); hold on;
plot(f1(1:end/2),rad2deg(FRF1_ang2(1:end/2)));

%% Coherence - Doesn't Work
% x = CH1_avg;
% y = CH2_avg;
% win = hann(N);
% % pxy = cpsd(x,y,win,0,500);
% % pxx = periodogram(x,win,500);
% % pyy = periodogram(y,win,500);
% % Cxy = (abs(pxy).^2) ./(pxx.*pyy);
% 
% [Cxy,f2] = mscohere(x,y);
% plot(f2,Cxy);


%% Parse through freq data
clc
[M,~] = size(Col4);
Freq_start = find(contains(Col4,'FRF Phase')); % Find the FRF Phase point
Freq_range(1,:) = Freq_start(1)+1:Freq_start(2)-1; % Channel 1 frequency range
Freq_range(2,:) = Freq_start(2)+1:length(Col1);    % Channel 2 frequency range

Freq_NI  = double(Col1(Freq_range(1,:)));

for ii = 1:2
    CHPSDX(ii,:)    = double(Col2(Freq_range(ii,:)));
    CHFRFMAG(ii,:)  = double(Col3(Freq_range(ii,:)));
    CHFRFPH(ii,:)   = double(Col4(Freq_range(ii,:)));
    CHCOH(ii,:)     = double(Col5(Freq_range(ii,:)));
end 


figure(4);
subplot(2,2,1);
plot(Freq_NI,CHPSDX(1,:)); hold on;
plot(Freq_NI,CHPSDX(2,:)); 
MyGen.title_plots('NI PSDX','Frequency (Hz)','Mag (WU/Hz^2)',10);
xlim([Freq_NI(1) Freq_NI(end)]); 
grid on;

subplot(2,2,2);
plot(Freq_NI,CHFRFMAG(1,:)); hold on;
plot(Freq_NI,CHFRFMAG(2,:)); 
MyGen.title_plots('NI FRF','Frequency (Hz)','Mag (WU)',10);
xlim([Freq_NI(1) Freq_NI(end)]); 
grid on;

subplot(2,2,3);
plot(Freq_NI,CHFRFPH(1,:)); hold on;
plot(Freq_NI,CHFRFPH(2,:)); 
MyGen.title_plots('NI FRF Phase','Frequency (Hz)','Phase (deg)',10);
xlim([Freq_NI(1) Freq_NI(end)]); 
grid on;

subplot(2,2,4);
plot(Freq_NI,CHCOH(1,:)); hold on;
plot(Freq_NI,CHCOH(2,:)); 
MyGen.title_plots('NI COH','Frequency (Hz)','Mag (1)',10);
xlim([Freq_NI(1) Freq_NI(end)]); 
grid on;


%% 
figure(5);

% PSDX works
subplot(2,2,1);
plot(Freq_NI,CHPSDX(1,:)); hold on;
plot(Freq_NI,CHPSDX(2,:)); 
plot(f_Gxx1,10*log10(Gxx_avg1)); hold on;
plot(f_Gxx2,10*log10(Gxx_avg2));
MyGen.title_plots('NI PSDX','Frequency (Hz)','Mag (WU/Hz^2)',10);
xlim([Freq_NI(1) Freq_NI(end)]); 
grid on;

% Magnitude Fails
subplot(2,2,2);
plot(Freq_NI,CHFRFMAG(1,:)); hold on;
plot(Freq_NI,CHFRFMAG(2,:)); 
plot(f1(1:end/2),20*log10(abs(FRF_mag1(1:end/2)))); hold on;
plot(f1(1:end/2),20*log10(abs(FRF_mag2(1:end/2))));
MyGen.title_plots('NI FRF','Frequency (Hz)','Mag (WU)',10);
xlim([Freq_NI(1) Freq_NI(end)]); 
grid on;

% Phase Fails
subplot(2,2,3);
plot(Freq_NI,CHFRFPH(1,:)); hold on;
plot(Freq_NI,CHFRFPH(2,:)); 
plot(f1(1:end/2),rad2deg(FRF_ang1(1:end/2))); hold on;
plot(f1(1:end/2),rad2deg(FRF_ang2(1:end/2)));
MyGen.title_plots('NI FRF Phase','Frequency (Hz)','Phase (deg)',10);
xlim([Freq_NI(1) Freq_NI(end)]); 
grid on;

% Coherence Fails
subplot(2,2,4);
plot(Freq_NI,CHCOH(1,:)); hold on;
plot(Freq_NI,CHCOH(2,:)); 
MyGen.title_plots('NI COH','Frequency (Hz)','Mag (1)',10);
xlim([Freq_NI(1) Freq_NI(end)]); 
grid on;

function [FRF_mag1,FRF_mag2,FRF_ang1,FRF_ang2] = Get_FRF(mag1_avg,mag2_avg);
    FRF_mag1 = abs(mag1_avg);
    FRF_mag2 = abs(mag2_avg);

    FRF_ang1 = angle(mag1_avg);
    FRF_ang2 = angle(mag2_avg);
end