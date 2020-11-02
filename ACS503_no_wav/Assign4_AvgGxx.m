%% Intro
%{
Assignment #4 Average Gxx
Description of Code
%{
Goal is to find the average Gxx for different signals and test the
developed function.
%}

Color Codes
%{
'red'	'r'	[1 0 0]
'green'	'g'	[0 1 0]
'blue'	'b'	[0 0 1]
'cyan'	'c'	[0 1 1]
'magenta'	'm'	[1 0 1]
'yellow'	'y'	[1 1 0]	
'black'	'k'	[0 0 0]
'white'	'w'	[1 1 1]
%}

Constants
%{
Atmospheric Pressure      =  2 * 10^-5 Pa
Boltzmann Constant        =  1.38 * 10^-23 J/molecule
Room Temperature          =  21 C
Specific Impedance of air =  420 Rayls
Speed of Sound            =  343 m/2
Permittivity (free space) =  8.85 * 10^-12 
Permeability (free space) =  4π * 10^-12 
%}

Typical Equations
%{
dB pressure         =  20*1og(P/P_ref) dB
dB Intensity        =  10*1og(P/P_ref) dB
dispertion equation =  c = λf m/s
Mechanical f_res    =  (1/2π) * sqrt(k/m) Hz
%}

%}

clear
% Directory for Functions
newpath = 'C:\Users\mbluu\OneDrive\Desktop\MATLAB_Work\Functions';
userpath(newpath)

Intro()

%% Part 1: Test Function with known signal
% Import Data
data = csvread('TRAC3_sin100_time.csv');
t = [data(:,1)'];
xn = [data(:,2)'];
% Generate Constants
dt = t(4)-t(3);
fs = 1/dt;
N = length(xn);
df = fs/N;
Nrecs=4;
[Gxx_avg,f] = MyAvgGxx(xn,fs,Nrecs);
plot_function(f,Gxx_avg,'b',1.5);
xlim([0 max(f)]);
title_plots('TRAC3 Sine Single-Sided Average PSD','Freq (Hz)',...
    'Intensity (WU^2/Hz)',14)

%% Part 2 - 4: S_plus_N_20 Test
clear
clc
% Import Data
[xn,fs] = audioread('S_plus_N_20.wav');
xn = xn(1:204800);
N  = length(xn);
Nrecs = 200;

[Gxx_avg,f] = MyAvgGxx(xn,fs,Nrecs);
[Gxx_avg_less,f2] = MyAvgGxx(xn,fs,Nrecs/2);
[Gxx,f_Gxx_noavg] = MyAvgGxx(xn,fs,Nrecs/Nrecs);

subplot(3,1,1); plot_function(f_Gxx_noavg,Gxx,'b',1.5);
xlim([0 max(f_Gxx_noavg)]);
title_plots('S plus N20 Sine Single-Sided No Avg','Freq (Hz)',...
    'Intensity (WU^2/Hz)',14)

subplot(3,1,2); plot_function(f2,Gxx_avg_less,'b',1.5);
xlim([0 max(f2)]);
title_plots('S plus N20 Sine Single-Sided Avg Nrec = 100','Freq (Hz)',...
    'Intensity (WU^2/Hz)',14)

subplot(3,1,3); plot_function(f,Gxx_avg,'b',1.5);
xlim([0 max(f)]);
title_plots('S plus N20 Sine Single-Sided Avg Nrec = 200','Freq (Hz)',...
    'Intensity (WU^2/Hz)',14)

% Sine wave at 375 Hz.

%% Part A (A.3)
clear
clc

% Import Data
[xn,fs] = audioread('S_plus_N_20.wav');
xn = xn(1:204800);
N  = length(xn);
Nrecs = 200;
[Gxx_avg,f] = MyAvgGxx(xn,fs,Nrecs);
% One record
N = length(xn);
N_new = N/Nrecs;
df = fs/N_new;
xn_array = zeros(Nrecs,N_new);
for a = 1:Nrecs
    xn_array(a,:) = xn(floor(1+(N_new*(a-1))):floor(N/Nrecs+(N_new*(a-1))));
end
[Gxx,Sxx,f_Sxx,f_Gxx] = MyPSDX(xn_array(10,:),fs);
RMS = sqrt(sum(Gxx).*df);
disp(['The RMS: ', num2str(RMS)]);


plot(f,Gxx_avg,'b','Linewidth',1.5); hold on
plot(f_Gxx,Gxx,'--r','Linewidth',1.5);
legend('Avg Gxx', 'Single Record Gxx');
xlim([0 max(f)]);
title_plots('S plus N20 Sine Single-Sided Avg Nrec = 200','Freq (Hz)',...
    'Intensity (WU^2/Hz)',14);

%% Part A (A.4)
clear
clc

% Import Data
[xn,fs] = audioread('S_plus_N_20.wav');
xn = xn(1:204800);
N  = length(xn);
df = fs/N;
Nrecs = 200;
[Gxx_avg,f] = MyAvgGxx(xn,fs,Nrecs);
[Gxx,Sxx,f_Sxx,f_Gxx] = MyPSDX(xn',fs);
RMS = sqrt(sum(Gxx).*df);
disp(['The RMS Total Spectrum: ', num2str(RMS)]);

RMS = sqrt(max(Gxx).*df);
disp(['The RMS Single Sine Spectrum Total: ', num2str(RMS)]);

semilogy(f_Gxx,Gxx,'--g','Linewidth',1.5); hold on
semilogy(f,Gxx_avg,'b','Linewidth',2);

legend('Total Record', 'Avg Nrec = 200');
xlim([0 max(f)]);
title_plots('S plus N20 Sine Single-Sided','Freq (Hz)',...
    'Intensity (WU^2/Hz)',14);

%% Part B Pulses in noise (Part 2) (B.2)
clear
clc
close all
[xn,fs] = audioread('P_plus_N_10.wav');
xn = xn(1:204800);
N  = length(xn);

Nrecs = 200;
[Gxx_avg,f] = MyAvgGxx(xn,fs,Nrecs);
[Gxx_avg_less,f2] = MyAvgGxx(xn,fs,Nrecs/2);
[Gxx,f_Gxx_noavg] = MyAvgGxx(xn,fs,Nrecs/Nrecs);

subplot(3,1,1); plot_function(f_Gxx_noavg,Gxx,'b',1.5);
xlim([0 max(f_Gxx_noavg)]);
title_plots('P plus N10 Sine Single-Sided No Avg','Freq (Hz)',...
    'Intensity (WU^2/Hz)',14)

subplot(3,1,2); plot_function(f2,Gxx_avg_less,'b',1.5);
xlim([0 max(f2)]);
title_plots('P plus N10 Sine Single-Sided Avg N = 100','Freq (Hz)',...
    'Intensity (WU^2/Hz)',14)

subplot(3,1,3); plot_function(f,Gxx_avg,'b',1.5);
xlim([0 max(f)]);
title_plots('P plus N10 Sine Single-Sided Avg N = 200','Freq (Hz)',...
    'Intensity (WU^2/Hz)',14)


%% Part B Pulses in noise (Synchronous) (B.3)
clear
clc
close all

[xn,fs] = audioread('P_plus_N_10.wav');
xn = xn(1:262196);
% Synched Gxx Avg
N  = length(xn);
Nrecs = 200;
% N_new = N/Nrecs;
N_new = 1024;
df = fs/N_new;
xn_array = zeros(Nrecs,1024);

for a = 1:Nrecs
    xn_array(a,:) = xn(1+a*1111:1024 + a*1111);
    [Gxx(a,:),Sxx,f,f_Gxx] = MyPSDX(xn_array(a,:),fs);
end

Gxx_avg_Synch = sum(Gxx,1)./Nrecs;
f = f_Gxx;

RMS = sqrt(sum(Gxx_avg_Synch).*df);
disp(['The RMS: ', num2str(RMS)]);
subplot(2,1,1); plot_function(f,Gxx_avg_Synch,'b',1.5);
xlim([0 max(f)]);
title_plots('P plus N10 Sine Single-Sided Synchronous Avg','Freq (Hz)',...
    'Intensity (WU^2/Hz)',14)

% Unsynched Gxx Avg
xn = xn(1:204800);
[Gxx_avg_Unsynch,f_avg] = MyAvgGxx(xn,fs,Nrecs);

subplot(2,1,2); plot_function(f_avg,Gxx_avg_Unsynch,'b',1.5);
xlim([0 max(f)]);
title_plots('P plus N10 Sine Single-Sided Unsynchronous Avg','Freq (Hz)',...
    'Intensity (WU^2/Hz)',14)


%% 
semilogx(f,Gxx_avg_Synch); hold on;
semilogx(f_avg,Gxx_avg_Unsynch); 


%% Part B Time Domain Avg (Linear Spectrum Avg) (B.4)
clear
clc
close all

% Import data
[xn,fs] = audioread('P_plus_N_10.wav');
xn = xn(1:262196);
N_new = 1024;
% Synched linear spectrum
Nrecs = 200;


xn_array = zeros(Nrecs,N_new);
for a = 1:Nrecs
    xn_array(a,:) = xn(1+a*1111:1024 + a*1111);
    [X(a,:),f] = MyFFT(xn_array(a,:),fs,'n',0);
end

X_avg = sum(X,1)./Nrecs;
N  = length(X_avg);
df = fs/N;
Sxx = (abs(X_avg).^2) * df;
Gxx_sy = [Sxx(1),2*Sxx(2:N/2),Sxx((N/2)+1)]; 
% Unsynch linear spectrum
xn = xn(1:204800);
xn_array_2 = zeros(Nrecs,N_new);
for a = 1:Nrecs
    xn_array_2(a,:) = xn(floor(1+(N_new*(a-1))):floor(N_new+(N_new*(a-1))));
    [X_1024(a,:),f_1024] = MyFFT(xn_array_2(a,:),fs,'n',0);
end

% Avg the linear spectrums
X_avg_1024 = sum(X_1024,1)./Nrecs;

Sxx = (abs(X_avg_1024).^2) * df;
Gxx_un = [Sxx(1),2*Sxx(2:N/2),Sxx((N/2)+1)]; 

subplot(2,1,1); plot_function(f_1024(1:floor(N_new/2)+1),Gxx_un,'b',1.5);
xlim([0 max(f_1024(1:floor(N_new/2)))]);
title_plots('P plus N10 Sine Linear Spectrum Unsynch Avg','Freq (Hz)',...
    'Amplitude (WU^2/Hz)',14)

subplot(2,1,2); plot_function(f(1:floor(N_new/2)+1),Gxx_sy,'b',1.5);
xlim([0 max(f(1:floor(N_new/2)))]);
title_plots('P plus N10 Sine Linear Spectrum Synch Avg','Freq (Hz)',...
    'Amplitude (WU^2/Hz)',14)



%% Part B Time Domain Avg (Unsynched - 1024 pts, 256 records)
clear
clc
close all

[xn,fs] = audioread('P_plus_N_10.wav');

% Unsynched
Number_of_pts = 204800;
xn = xn(1:Number_of_pts);
N  = length(xn);
[dt,df,t,freq] = Time_Freq_Arrays(fs,N);

Nrecs = 200;
N_new = 1024;
xn_array = zeros(Nrecs,N_new);

for a = 1:Nrecs
    xn_array(a,:) = xn(floor(1+(N_new*(a-1))):floor(N_new+(N_new*(a-1))));
end
xn_avg = sum(xn_array,1)./Nrecs;
t_avg = (0:N_new-1).*dt;
[Gxx,Sxx,f_Sxx,f_Gxx] = MyPSDX(xn_avg,fs);

subplot(2,1,1); plot_function(t_avg,xn_array(2,:),'b',1.5); hold on;
plot_function(t_avg,xn_avg,'r',1.5);
title_plots('P plus N10 Sine Single-Sided','Time (s)',...
    'Amplitude (WU)',14)
subplot(2,1,2); plot_function(f_Gxx,Gxx,'b',1.5);
xlim([0 max(f_Gxx)]);
title_plots('','Freq (Hz)',...
    'Intensity (WU^2/Hz)',14)



%% Part B Time Domain Avg (Synched???)
clear
clc
close all

[xn,fs] = audioread('P_plus_N_10.wav');
Number_of_pts = 262144;
xn = xn(1:Number_of_pts);
N  = length(xn);
[dt,df,t,freq] = Time_Freq_Arrays(fs,N);

Nrecs = 200;
N_new = 1024;
xn_array = zeros(Nrecs,1024);

for a = 1:Nrecs
    xn_array(a,:) = xn(1+a*1111:1024 + a*1111);
end

xn_avg = sum(xn_array,1)./Nrecs;
t_avg = (0:1024-1).*dt;

subplot(2,1,1); plot_function(t_avg,xn_array(2,:),'b',1.5); hold on;
 plot_function(t_avg,xn_avg,'r',1.5);
title_plots('P plus N10 Sine Single-Sided','Time (s)',...
    'IAmplitude (WU)',14)

[Gxx,Sxx,f_Sxx,f_Gxx] = MyPSDX(xn_avg,fs);
subplot(2,1,2); plot_function(f_Gxx,Gxx,'b',1.5);
xlim([0 max(f_Gxx)]);
title_plots('','Freq (Hz)',...
    'Intensity (WU^2/Hz)',14)


%% Skeleton Code old for avg algorithm
% Nrecs = 4;
% N_new = N/Nrecs;
% 
% xn_array = zeros(Nrecs,N_new);
% for a = 1:Nrecs
%     xn_array(a,:) = xn(1+(N_new*(a-1)):N/Nrecs+(N_new*(a-1)));
%     
%     [Gxx(a,:),Sxx,f] = MyPSDX(xn_array(a,:),fs);
% end
% Gxx_avg = sum(Gxx,1)./Nrecs;


