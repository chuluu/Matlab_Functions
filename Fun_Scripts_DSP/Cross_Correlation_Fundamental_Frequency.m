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

%%
filename = 'PianoC2.mp3';
[x,fs] = audioread(filename);

%% Record audio Data
% recObj = audiorecorder(44100, 24, 1); %recorder = audiorecorder(Fs,nBits,nChannels) We can change the quality of the audio
% %fs = Amount of samples taken (Becomes muffled and distorted when less samples due to less distinct harmonics in the signal
% %nBits = Quantization or how many bits can of "Magnitude" can be portrayed. If you have 1 bit, then you got either loud or not load, 8 bits breaks it up 8 times, etc.
% %nChannels = Mono = 1, Stereo = 2
% 
% disp('Start speaking.')
% recordblocking(recObj, 2); %We can signify how long we are recording
% disp('End of Recording.');
% 
% % Play back the recording.
% My_Voice = audioplayer(recObj); %Saves the object for playback Same deal we can change the quality of the output audio based of Fs and nBits
% 
% % Store data in double-precision array.
% x = getaudiodata(recObj);%Samples and magnitudes? 
% x = x';

%% Cross Correlation using the function 
%We can use cross correlation to determine the period of a random periodic
%signal
freq = [3000, 500, 1000, 2000];
fs = 10000;
dt = 1/fs;
t = 0:dt:1;%(length(x)*dt)-dt;

x = sin(2*pi*freq(1).*t) + sin(2*pi*freq(2).*t) + sin(2*pi*freq(3).*t);
%x = awgn(x,10,'measured'); % White Gaussian Noise
figure(1);
plot(t,x)
[X, f] = MyFFT(x,1/fs,0);
figure(2);
plot(f,abs(X));


%% Filters Gaussian Noise out of signal
[b_stop, a_stop] = butter(32, 0.3,'low');
num_bins = length(x);
H_response = freqz(b_stop,a_stop, floor(num_bins/2));
figure(1);
plot([0:1/(num_bins/2 -1):1], abs(H_response),'r');
title('Freq Response of LowPass Filter'); xlabel('Frequency'); ylabel('Magnitude');

x_filtered = filter(b_stop,a_stop,x); %Filter The Gaussian Noise
[X_Filter, f_filter] = MyFFT(x_filtered,1/fs,0);

%% Plot Refiltered Signal
figure(2);
plot(t,x_filtered); hold on

figure (3);
plot(f_filter,abs(X_Filter)); hold on
%plot(f,abs(X));


%% Finds Cross Correlation
[Fundamental_Frequency, x_corr_1, time_period] = MATLAB_CrossCor(x,fs);
figure(4);
plot(time_period,x_corr_1); title('xcorr signal'); xlabel('Time_Delay'); ylabel('Amplitude');
xlim([-0.01 0.01]);
Fundamental_Frequency



