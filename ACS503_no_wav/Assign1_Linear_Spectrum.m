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

% Directory for Functions
newpath = 'C:\Users\mbluu\OneDrive\Desktop\MATLAB_Work\Functions';
userpath(newpath)

Intro()
%% Part A
% Inputs
dt = 0.01;
xn = [1, 0, 2, 5, -1, 4, -2, 2,2]; %V
% xn = [1 ,-1, 1, -1, 1, -1, 1, -1];

% Constants Calculated
Fs = 1/dt;
N = length(xn);
df = 1/(dt*N);
f = (0:N-1)*df
t = (0:N-1)*dt;

% B&B
Xm = fft(xn).*dt;
N = length(Xm);      % Normalize by sample length.
%[RAND_Y,freq] = MyFFT(rand_y,Fs,'n',0);


plot_function(f,abs(Xm),'r',1.5);
title_plots('Linear Spectrum of Random Data Set','Frequency (Hz)','Amplitude (WU)',14)

% Question Answers
% What values are real?
% m = 0 - real
% m = 5 - real
% This is because the fft has a range of F (digital freq) -0.5 --> 0.5 so
% the whole thing copies on itself. True 0 Hz is at m = 5

% What pairs are complex conjugates
% m = 1 and m = 8
% m = 2 and m = 7
% m = 3 and m = 6 

% Determine the frequencies that correspond to the value of the LS
% 0 Hz corresponds to the outlier point which is a part of the previous
% spectral copy
% fs/2 Hz is actually DC when put in the -fs/2 --> fs/2 spectrum. This
% value is the true 0 Hz, but it is the same as the actual 0 Hz because,
% again, it is just another cycle of the spectral copies within the nyquist
% boundary.

% How does the basic equation for linear spectrum simplify at 0 frequency?
% @ 0 Hz, this will be a summation of the xn array * df, since the
% expontential term will always be 1

% In this case, in code it would be:
X_0 = sum(xn)*dt; % This value is the same as calculated with fft! 

%% Part A alternating signs
% Inputs
dt = 0.01;
xn = [1 ,1, 1, 1, 1, 1, 1, 1];

% Constants Calculated
Fs = 1/dt;
N = length(xn);
df = 1/(dt*N);
f = (0:N-1)*df

% B&B
Xm = fft(xn)*dt;
N = length(Xm);      % Normalize by sample length.
%[RAND_Y,freq] = MyFFT(rand_y,Fs,'n',0);


plot_function(f,abs(Xm),'r',1.5);
title_plots('Linear Spectrum of Alternating Amplitudes','Frequency (Hz)','Amplitude (WU)',14)

%Question Answers
% This one is cool! A fast oscillating data set with, essentially, the
% highest possible captured frequency (Nyquist) This is why there is a
% spike around fs/2. In this example fs = 100Hz, and the spike is at 50Hz,
% therefore this time series corralates to a periodic signal at nyquist
% rate


%% Extra ranting
%{ 
% frequency resolution is 125 Hz in this small example therefore the
% spectrum will go at 125 Hz steps. The max frequency of the spectrum will
% be N*df, which is 1000. the middle frequency is the frequency range
% divided by 2. Since the FFT is cyclical, we have a spectral copy on both
% sides, typically the frequency band is between 1/2 of frequency range
% (positive to negative) in simpler terms, the digital frequency is 
% F = fo/fs. Nyquist rate is 0.5, so our perceieved band is -0.5 - 0.5 with
% spectral copies begin cut off from there. The digital frequency max is
% 0.5 Aliasing may occur is sampling rate is too low compared to the data
% set, since this is a random data set, who knows. 
% The extra value "negative" amplitude value for the even data set is on
% nyquist rate, therefore the sample is a cyclical variable to wrap the
% spectral copies. (half an oscillation in each time interval)there is no
% real "middle point" so we get an extra unsymmetric sample, but in reality
% it is symmetric, when you include spectral copies outside of nyquist
% a cool thing
% is if your df value is to coarse, we begin to get sidelobes at
% fundamental
% frequency for a signal

% if you have alternating points, this is essentially a square wave. at
% really high frequency, therefore the signal aliases and we essentially
% get a flat line

%}

%% Part B
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
[Y,f] = MyFFT(y,fs,'n',0);

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
[Y_cos,f] = MyFFT(y_cos,fs,'n',0);

figure(1);
plot_function(t,y,'r',2.5); hold on;
plot_function(t,y2,'bx',2.5);
plot_function(t,y_cos,'g',2.5); 
plot_function(t,y2_cos,'kx',2.5);
title_plots('4 Hz Time Domain Sine/Cosine','time (s)','Amplitude (WU)',14)
legend('MATLAB Time Vector Sine','Proven ADC Equation Sine', 'MATLAB Time Vector Cosine','Proven ADC Equation Cosine');

figure(2);
subplot(2,1,1); stem(f,abs(Y),'k'); hold on;
subplot(2,1,1); stem(f,abs(Y_cos),'bx');
legend('Sine','Cosine');
title_plots('Linear Spectrum of waveform (magnitude)','Freq (Hz)','Amplitude (WU)',14);

subplot(2,1,2); plot_function(f,rad2deg(angle(Y)),'k',1.5); hold on;
subplot(2,1,2); plot_function(f,rad2deg(angle(Y_cos)),'--bx',1.5);
title_plots('Linear Spectrum of waveform (phase)','Freq (Hz)','Phase (deg)',14);
legend('Sine','Cosine');

% Questions 
% Relationship between m0 and f0?
% m0 = fo/df;

% What is m0 for this example?
% m0 = 2, where fo = 4 Hz and df = fs/N = 2

% Cosine vs. Sine
% Cosine and Sine have the same magnitude, but are -90 degrees phase shifted
% apart at 4 Hz. So if we look at the phase difference at 4 Hz on our phase
% chart, or even looking at the phase data for the auto spectrum, one can
% see that the cosine phase has a shift of -90, while sine has a phase of
% approximately 0. This proves that our magnitude is the same for sine and
% cosine, but cosine is -90 degrees phase shifted. Cosine lags Sine


%% Extra Rants
%{
% two values are -4 Hz and 4 Hz, our sine signal. Sine in frequency domain
% is an impulse so this makes sense at 0.25 amplitude because the 0.5
% amplitude is split into 2 impulses when put in frequency domain, if you
% look at any laplace table there is typically a 1/2 to confirm this.
%}

%% Part B Sidelobe miss
% Inputs
C  = 0.5;
fo = 5;
fs = 128;
N = 64;

% Calculated constants Sine
df = fs/N;
dt = 1/fs;
mo = fo/df;
disp(['mo: ', num2str(mo)])

% Calculated arrays Sine
t  = (0:N-1)*dt;
n  = 0:1:N-1;
y  = C.*sin(2.*pi.*fo.*t);
y2 = C.*sin((2.*pi.*mo.*n)./N);
[Y,f] = MyFFT(y,fs,'n',0);

% Calculated constants Cosine
df = fs/N;
dt = 1/fs;
mo = fo/df;
disp(['mo: ', num2str(mo)])
t  = (0:N-1)*dt;
n  = 0:1:N-1;

% Calculated arrays cosine
y_cos  = C.*cos(2.*pi.*fo.*t);
y2_cos = C.*cos((2.*pi.*mo.*n)./N);
[Y_cos,f] = MyFFT(y_cos,fs,'n',0);

figure(1);
plot_function(t,y_cos,'k',2.5);  hold on;
plot_function(t,y2_cos,'bx',2.5);
title_plots('5 Hz Cosine Wave','time (s)','Amplitude',14)
legend('MATLAB Time Vector Cosine','Proven ADC Equation Cosine');

figure(2);
subplot(2,1,1); stem(f,abs(Y_cos),'k','Linewidth',1.5);
title_plots('Linear Spectrum of example 5 Hz Cosine (magnitude)','Freq (Hz)','Amplitude (WU)',14);
grid on;

subplot(2,1,2); plot_function(f,rad2deg(angle(Y_cos)),'k',1.5);
title_plots('Linear Spectrum of example 5 Hz Cosine (phase)','Freq (Hz)','Phase (deg)',14);

% two values are -4 Hz and 4 Hz, our sine signal. Sine in frequency domain
% is an impulse so this makes sense at 0.25 amplitude because the 0.5
% amplitude is split into 2 impulses when put in frequency domain, if you
% look at any laplace table there is typically a 1/2 to confirm this.

%% Part B 252 Hz
C  = 0.5;
fo = 252;
fs = 128;
N = 64;

df = fs/N;
dt = 1/fs;
mo = fo/df;
disp(['mo: ', num2str(mo)])
t  = (0:N-1)*dt;
n  = 0:1:N-1;

y  = C.*sin(2.*pi.*fo.*t);
y2 = C.*sin((2.*pi.*mo.*n)./N);
[Y,f] = MyFFT(y,fs,'n',0);

df = fs/N;
dt = 1/fs;
mo = fo/df;
disp(['mo: ', num2str(mo)])
t  = (0:N-1)*dt;
n  = 0:1:N-1;

y_cos  = C.*cos(2.*pi.*fo.*t);
y2_cos = C.*cos((2.*pi.*mo.*n)./N);
[Y_cos,f] = MyFFT(y_cos,fs,'n',0);

figure(1);
plot_function(t,y_cos,'r',2.5);  hold on;
plot_function(t,y2_cos,'bx',2.5);
title_plots('5 Hz Cosine Wave','time (s)','Amplitude',14)
legend('MATLAB Time Vector Cosine','Proven ADC Equation Cosine');

figure(2);
subplot(2,1,1); plot_function(f,abs(Y_cos),'k',1.5);
title_plots('Linear Spectrum of example 252 Hz Cosine (magnitude)','Freq (Hz)','Amplitude (V)',14);

subplot(2,1,2); plot_function(f,rad2deg(angle(Y_cos)),'k',1.5);
title_plots('Linear Spectrum of example 252 Hz Cosine (phase)','Freq (Hz)','Phase (deg)',14);

% FFT is a cyclical algorithm, so essentially we are locating a different
% point of the nyquist band. Since nyquist is 64, anything above 64 Hz will
% be cyclical and just wrap around (essentially we are looking at a
% different spectral copy of the FFT) We are hardcore aliasing

%% Extra stuff
[Y,f] = MyFFT(y,fs,'n',0);
[Y2,f2] = MyFFT(y,fs,'y',0);
[Y3] = fftshift(Y2);
figure(3);
y_back = real(ifft(Y)/dt);
plot_function(t,y_back,'r',2.5); hold on;
title_plots('4 Hz Sine Wave Reconstructed','time (s)','Amplitude',14)
