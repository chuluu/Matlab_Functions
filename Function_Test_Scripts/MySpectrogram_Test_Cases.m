%% Intro
%{
Assignment #5: Spectrograms!!!
Description of Code
%{
Spectrograms baby
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

Windows
%{
% rectwin( ) - Rectangular window.
% triang( ) - Triangular window.
% bartlett( ) - Bartlett window (Triangle Window with ?0?s at both ends)
% hann( ) - von Hann window (Hanning Window with ?0?s at both ends)
% hanning( ) - Hanning window (With non-zero end samples).
% hamming ( ) - Hamming window.
% blackman( ) - Blackman window.
% kaiser( ) - Kaiser window (with b parameter)
% tukeywin( ) - Tukey window.
% Barthannwin( ) - Modified Bartlett-Hanning window.
% bohmanwin( ) - Bohman window.
% chebwin( ) - Chebyshev window.
% flattopwin( ) - Flat Top window.
% gausswin( ) - Gaussian window.
% blackmanharris( ) - Minimum 4-term Blackman-Harris window
% nuttallwin( ) - Nuttall defined minimum 4-term Blackman-Harris window.
% parzenwin( ) - Parzen (de la Valle-Poussin) window. 
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
userpath(newpath);
Intro();
%% sub
t = 0:0.001:2;
fs = 1/0.001;
x = chirp(t,100,1,200,'quadratic');

[Gxx_array,dB_vals,t_array_big,f_array_big] = MyDSP.MYSpectrogram(...
    x,128,0.5,fs,2);

%% Part 1: Test Signal
clear
clc
% Set up Signal
fs = 2048; 
N  = 12288;
T  = 6;

dt = 1/fs;
t  = (0:N-1).*dt;
f0 = 128;
xn_1st = zeros(1,N/3);
xn_2nd = sin(2.*pi.*f0.*t(N/3:2*(N/3)-1));
xn_3rd = zeros(1,N/3);
xn = [xn_1st, xn_2nd, xn_3rd];

overlap = 0.25;
NSTFT   = 256;

[Gxx_array,dB_vals,t_array_big,f_array_big] = MyDSP.MYSpectrogram(...
    xn,NSTFT,overlap,fs,T);

%% Part 3: Recording
clc
clear
fs = 10000;
[xn,Gxx] = MyDSP.recording_background(fs,16,2);
xlim([0 2000]);
dt = 1/fs;
T  = dt.*length(xn);
overlap = 0.5;
NSTFT   = 1024;

[Gxx_array,dB_vals,t_array_big,f_array_big] = MyDSP.MYSpectrogram(...
    xn,NSTFT,overlap,fs);

ylim([0 2000]);


