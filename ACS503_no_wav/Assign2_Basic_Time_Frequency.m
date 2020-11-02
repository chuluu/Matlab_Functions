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

%% White Noise Generation Verification N = 8
% Inputs
N = 8;
fs = 10;
[dt,df,t,freq] = Time_Freq_Arrays(fs,N);
[wn,Y] = White_Noise_Generation(N,dt);



% Plotting
figure(1); % Frequency Domain
subplot(2,1,1); plot_function(freq,abs(Y),'b',1.5);
title_plots('White Noise LS Mag','Freq (HZ)','Amplitude (WU/Hz)',14)
ylim([0.7 1.3]);
subplot(2,1,2); plot_function(freq,pi + angle(Y),'b',1.5);
title_plots('White Noise LS Phase','Freq (HZ)','Phase (rad)',14)



figure(2); % Time Domain
plot_function(t,wn,'r',1.5)
title_plots('White Noise','time (s)','Amplitude (WU)',14)


%% Problem 1
% Inputs
N = 48000;
fs = 24000;
[dt,df,t,freq] = Time_Freq_Arrays(fs,N);
[wn,Y] = White_Noise_Generation(N,dt);

% plotting
figure(1); % Frequency Domain
subplot(3,1,1); plot_function(freq,abs(Y),'b',1.5);
title_plots('White Noise LS MAG','Freq (HZ)','Amplitude (WU)',14)
ylim([0.7 1.3]);
subplot(3,1,2); plot_function(freq,pi+angle(Y),'b',1.5);
title_plots('White Noise LS PHASE','Freq (HZ)','Phase (rad)',14)
subplot(3,1,3); hist(angle(Y),200);
title_plots('White Noise Histogram Phase','Phase Bins','Count',14)

figure(2); % Time Domain
plot_function(t,wn,'r',1.5)
title_plots('White Noise','time (s)','Amplitude (WU)',14)

figure(3);
hist(wn,200);
title_plots('White Noise Histogram','Bins Amplitude (200)','Count',14)


% RMS/Peak value 
wn_rms = MyRMS(wn,N);
wn_peak = max(wn);
wn_ratio = wn_rms/wn_peak;
% Sine Wave Ratio would be 0.707
audiowrite('White_Noise.wav', wn, fs)
double_wn = [wn, wn];

%% Problem 2
% Inputs
N = 48000;
fs = 24000;
[dt,df,t,freq] = Time_Freq_Arrays(fs,N);

% Magnitude Generation
Y_mag = ones(1,N);

% Phase Generation
Y_phase_pos = zeros(N/2,1)';

% Complex Number LS Generation
Y_real_pos = Y_mag(N/2:end-1).*cos(Y_phase_pos);
Y_imag_pos = Y_mag(N/2:end-1).*sin(Y_phase_pos);
Y_pos = Y_real_pos + 1i*Y_imag_pos;
Y_neg = conj(Y_pos);
Y_neg = [Y_neg(1),flip(Y_neg(2:end))];
Y     = [Y_pos,Y_neg];

% plotting
figure(1); % Frequency Domain
subplot(2,1,1); plot_function(freq,abs(Y),'b',1.5);
title_plots('White Noise LS MAG','Freq (HZ)','Amplitude (WU/Hz)',14)
subplot(2,1,2); plot_function(freq,angle(Y),'b',1.5);
title_plots('White Noise LS PHASE','Freq (HZ)','Phase (rad)',14)

figure(2); % Time Domain
y = real(ifft(Y))/dt;
y = ifftshift(y);
plot_function(t,y,'r',1.5)
title_plots('Phase Equals Zero Signal','time (s)','Amplitude (WU)',14)


% RMS/Peak value 
y_rms = MyRMS(y,N);
y_peak = max(y);
y_ratio = y_rms/y_peak;


%% Problem 3
% Inputs
N = 48000;
fs = 24000;
[dt,df,t,freq] = Time_Freq_Arrays(fs,N);
[pn,PN] = Pink_Noise_Generation(N,dt);

% plotting
figure(1); % Frequency Domain
subplot(2,1,1); semilogx(freq,20*log10(abs(PN)),'b','Linewidth',1.5);
title_plots('White Noise LS MAG log scale','Freq (HZ)','Amplitude WU/Hz dB',14)
xlim([1 10000]);
grid on;
subplot(2,1,2); semilogx(freq,angle(PN),'b','Linewidth',1.5);
title_plots('White Noise LS PHASE log scale','Freq (HZ)','Phase (rad)',14)
xlim([1 10000]);
grid on;

figure(2); % Frequency Domain
subplot(2,1,1); plot(freq,abs(PN),'b','Linewidth',1.5);
title_plots('White Noise LS MAG linear scale','Freq (HZ)','Amplitude WU/Hz dB',14)
grid on;
subplot(2,1,2); plot(freq,angle(PN),'b','Linewidth',1.5);
title_plots('White Noise LS PHASE linear scale','Freq (HZ)','Phase (rad)',14)
grid on;

figure(3); % Time Domain
plot_function(t,pn,'r',1.5)
title_plots('Pink Noise','time (s)','Amplitude (WU)',14)

% Note: Put in semilog dB scale to show that my pink noise generation is
% -10dB/dec which is pink noise!

audiowrite('Pink_Noise.wav', pn, fs)

% RMS/Peak value 
pn_rms = MyRMS(pn,N);
pn_peak = max(pn);
pn_ratio = pn_rms/pn_peak;
% Sine Wave Ratio would be 0.707

double_pn = [pn, pn];

%% Display RMS
disp(['RMS to Peak ratio: ', num2str(wn_ratio)]);
disp(['Wn RMS: ', num2str(wn_rms), ' WU_rms']);
disp(['RMS to Peak ratio: ', num2str(y_ratio)]);
disp(['Impulse RMS: ', num2str(y_rms), ' WU_rms']);
disp(['RMS to Peak ration: ', num2str(pn_ratio)]);
disp(['Pn RMS: ', num2str(pn_rms), ' WU_rms']);

%% Recoding and playback
fs = 24000;
sound(double_wn/2,fs);
recObj = audiorecorder(fs,16,1);
disp('Recording Begins');
recordblocking(recObj,6);
disp('Recording Ends');
wn_playback = getaudiodata(recObj);

%% Analyze Recording
[WN_orig,f_orig] = MyFFT(wn,fs,'n',0);

%% White Noise
% Start
wn_contracted = wn_playback(10000:10000+48000-1);
N_wn = length(wn_contracted);
wn_con_mean = mean(wn_contracted);
wn_processed = wn_contracted-wn_con_mean;

figure(1);
plot(wn_contracted);

[WN_rec,f] = MyFFT(wn_processed,fs*2,'n',0);
% End

% Plotting
figure(2);
plot_function(f(1:N_wn/2),abs(WN_rec(1:N_wn/2)),'r',1.5);
title_plots('Recorded White Noise','Freq (HZ)','Amplitude Pa/Hz',14)

%% Extra side stuff for sine wave (0.707 for 1 amplitude sine wave checks out)
%{
clc 
clear

C  = 1;
fo = 5;
fs = 128;
N = 64;

df = fs/N;
dt = 1/fs;
mo = fo/df;
disp(['mo: ', num2str(mo)])
t  = (0:N-1)*dt;
n  = 0:1:N-1;

y  = C.*sin(2.*pi.*fo.*t);

y_Sqr  = y.^2;
y_rm   = sum(y_Sqr)/N;
y_rms  = sqrt(y_rm);
y_peak = max(y);

y_ratio = y_rms/y_peak;

% %% Old Method
% % Magnitude Generation
% Y_mag = ones(1,N);
% 
% % Phase Generation
% Y_phase_pos = [(2*pi)*rand(N/2,1)]';
% Y_phase_pos(1) = 0;
% Y_phase_pos(end) = 0;
% 
% % Complex Number LS Generation
% Y_real_pos = Y_mag(N/2:end-1).*cos(Y_phase_pos);
% Y_imag_pos = Y_mag(N/2:end-1).*sin(Y_phase_pos);
% Y_pos = Y_real_pos + 1i*Y_imag_pos;
% Y_neg = flip(conj(Y_pos));
% Y     = [Y_neg,Y_pos];
%}