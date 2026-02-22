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

%% Part 1
fs = 44100;
N = 50000;
dt = 1/fs;
m = 1.0;
s = 2.0;
xo = 0.4;
vo = 0.2;
wo = sqrt(2);
C = 0.424;
phi = deg2rad(19.5);
f0 = (1/(2*pi))*sqrt(s/m);

T = 1/f0;
t = 0:dt:3.*T;
A = xo;
B = vo/wo;
x1 = A*cos(2.*pi.*f0.*t);
x2 = B*sin(2.*pi.*f0.*t);
x_sum = x1 + x2;

plot_function(t,x1,'r',1.5); hold on;
plot_function(t,x2,'b',1.5); 
plot_function(t,x_sum,'g',1.5); 

title_plots(' ','Time (s)','Amplitude (Pa)',14);
legend('Sine','Cosine','Summation');

figure(2);
phi = atan2(-vo./(xo.*wo));
C   = xo/cos(phi);
x_ic = C*cos(2.*pi.*f0.*t+phi);
x_sum = x1 + x2;
plot_function(t,x_sum,'g',1.5); hold on;
plot_function(t,x_ic,'--k',1.5); 

title_plots(' ','Time (s)','Amplitude (Pa)',14);
legend('Summation','Derived');

%% Part 3
clc
clear
fs = 44100;
dt = 1/fs; 
f0 = 1.5677;
T0 = f0;
N  = 100000;

C   = 0.04;
phi = deg2rad(-5.8);
tau = 1;
wd  = 9.85;
B   = 1;
t   = 0:dt:4;
x = C.*exp(-B.*t).*cos(wd.*t + phi);
DR  = max(x)/exp(1);


plot_function(t,x,'b',1.5); hold on;
plot_function(t,-DR.*ones(1,length(x)),'r',1.5);
xlim([0 max(t)]);
title_plots(' ','Time (s)','Amplitude (Pa)',14)


