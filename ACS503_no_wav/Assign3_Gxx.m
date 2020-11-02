%% Intro
%{
Description of Code
%{

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

% Directory for Functions
newpath = 'C:\Users\mbluu\OneDrive\Desktop\MATLAB_Work\Functions';
userpath(newpath)

Intro()

%% Part 1 
clc
clear
close all
% Import Data
data = csvread('TRAC1_noise_time.csv');
t = data(:,1)';
xn = data(:,2)';

% Generate Constants
dt = t(4)-t(3);
fs = 1/dt;
N = length(xn);
df = fs/N;

% plot the data
figure(1);
plot_function(t,xn,'r',1.5);
title_plots('TRAC1 Noise','time (s)','Amplitude (WU)',14)

[Gxx,Sxx,f_Sxx,f_Gxx] = MyPSDX(xn,fs);

figure(2);
subplot(2,1,1); plot_function(f_Sxx,Sxx,'b',1.5);
title_plots('TRAC1 Noise Double-Sided (Sxx) PSD','Freq (Hz)','Intensity (WU^2/Hz)',14)
subplot(2,1,2); plot_function(f_Gxx,Gxx,'b',1.5);
title_plots('TRAC1 Noise Single-Sided (Gxx) PSD','Freq (Hz)','Intensity (WU^2/Hz)',14)
xlim([0 2000]);

xn_ms = sum(xn.^2)/N;

disp(['mean-square value: ',num2str(xn_ms),' WU^2']);
disp(['mean-square value: ',num2str(sum(Gxx)*df),' WU^2']);

%% Part 2
clc
clear
close all
data = csvread('TRAC3_sin100_time.csv');
t = data(:,1)';
xn = data(:,2)';

% Generate Constants
dt = t(4)-t(3);
fs = 1/dt;
N = length(xn);
df = fs/N;

% plot the data
figure(1);
plot_function(t,xn,'r',1.5);
title_plots('TRAC3 Sine 100 Hz','time (s)','Amplitude (WU)',14)
xn_rms = MyRMS(xn,N);
xn_pk  = max(xn);
xn_ratio = xn_rms/xn_pk;

% PSDxm
[Gxx,Sxx,f_Sxx,f_Gxx] = MyPSDX(xn,fs);

figure(2);
subplot(2,1,1); plot_function(f_Sxx,Sxx,'b',1.5);
title_plots('TRAC3 Sine Double-Sided PSD (Sxx)','Freq (Hz)','Intensity (WU^2/Hz)',14)
subplot(2,1,2); plot_function(f_Gxx,Gxx,'b',1.5);
title_plots('TRAC3 Sine Single-Sided PSD (Gxx)','Freq (Hz)','Intensity (WU^2/Hz)',14)
xlim([0 max(f_Gxx)]);

disp(['root mean-square value: ',num2str(xn_rms)]);
disp(['RMS from Gxx: ', num2str(sqrt(sum(Gxx)*df))]);
disp(['root mean-square peak ratio: ',num2str(xn_ratio)]);

% Questions:
% What is the frequency of this peak?
% 100Hz 

% What are the units of Gxx?
% dBW (Watts Decibels)

% 100 Hz

%% Play back recording
clc
clear
close all

fs = 44100;
[x_playback,Gxx] = recording_background(fs,16,2);
