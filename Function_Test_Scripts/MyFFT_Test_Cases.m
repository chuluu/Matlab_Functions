%% Intro
%{
Intro
%{
Matthew Luu
8/28/2020
%}

Description of Code: Assignment #1
%{
Takes Linear Spectrum of different functions for assignment 1
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

clc
clear
[filepath,~,~] = fileparts(pwd);
newpath = [filepath,'\Function_Packages'];
addpath(newpath);
Intro();

%% Sine and COSINE Test Case
% Inputs
C  = 0.5;
fo = 4;
fs = 128;
N = 64;

% Calculated Constants Sine
df = fs/N;
dt = 1/fs;
mo = fo/df;
disp(['mo: ', num2str(mo)]);

% Calculated Arrays Sine
t  = (0:N-1)*dt;
n  = 0:1:N-1;
y  = C.*sin(2.*pi.*fo.*t);
y2 = C.*sin((2.*pi.*mo.*n)./N);
[Y,f] = MyDSP.MyFFT(y,fs,'n',0);
[Yshift,fshift] = MyDSP.MyFFT(y,fs,'y',0);

% Calculated Constnats Cosine
df = fs/N;
dt = 1/fs;
mo = fo/df;
disp(['mo: ', num2str(mo)]);
t  = (0:N-1)*dt;
n  = 0:1:N-1;

% Calculated Arrays Cosine
y_cos  = C.*cos(2.*pi.*fo.*t);
y2_cos = C.*cos((2.*pi.*mo.*n)./N);
[Y_cos,f] = MyDSP.MyFFT(y_cos,fs,'n',0);
[Y_cosshift,fshift] = MyDSP.MyFFT(y_cos,fs,'y',0);

figure(1);
MyGen.plot_function(t,y,'r',2.5); hold on;
MyGen.plot_function(t,y_cos,'g',2.5); 
MyGen.title_plots('4 Hz Time Domain Sine/Cosine','time (s)','Amplitude (WU)',14)

figure(2);
subplot(2,1,1); stem(f,abs(Y),'k'); hold on;
subplot(2,1,1); stem(f,abs(Y_cos),'bx');
legend('Sine','Cosine');
MyGen.title_plots('Linear Spectrum of waveform (magnitude)','Freq (Hz)','Amplitude (WU)',14);

subplot(2,1,2); MyGen.plot_function(f,rad2deg(angle(Y)),'k',1.5); hold on;
subplot(2,1,2); MyGen.plot_function(f,rad2deg(angle(Y_cos)),'--bx',1.5);
MyGen.title_plots('Linear Spectrum of waveform (phase)','Freq (Hz)','Phase (deg)',14);

figure(3);
subplot(2,1,1); stem(fshift,abs(Yshift),'k'); hold on;
subplot(2,1,1); stem(fshift,abs(Y_cosshift),'bx');
legend('Sine','Cosine');
MyGen.title_plots('Linear Spectrum of waveform (magnitude)','Freq (Hz)','Amplitude (WU)',14);

subplot(2,1,2); MyGen.plot_function(f,rad2deg(angle(Yshift)),'k',1.5); hold on;
subplot(2,1,2); MyGen.plot_function(f,rad2deg(angle(Y_cosshift)),'--bx',1.5);
MyGen.title_plots('Linear Spectrum of waveform (phase)','Freq (Hz)','Phase (deg)',14);
