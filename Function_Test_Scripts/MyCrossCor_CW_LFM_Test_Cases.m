%% Intro
% Test Case for halfpower function
clc
clear

[filepath,~,~] = fileparts(pwd);
newpath = [filepath,'\Function_Packages'];
userpath(newpath);
Intro();

%% Part 1: Testing Correlation Function
fs  = 5;
f   = 159;
t_0   = 0:1/fs:0.01; % 0 -> 10ms
tau = 0.001;     % tau = 1ms

x_sine   = sin(2.*pi.*f.*t_0);
x_square = ones(1,length(x_sine));%square(2.*pi.*f.*t);
x_saw    = t_0.*x_square; %sawtooth(2.*pi.*f.*t);
h        = (1/tau)*exp(-(1/tau).*t_0);
 
x        = [1,0,0,0,0,0,0,0];

% Part A,B:
[Cxy]         = MyDSP.MyCrossCorCirc(x, x);
[xcorr_1,lag] = xcorr(x,x); 
stem(Cxy,'LineWidth',2);
MyGen.title_plots('Correlation','Samples', 'Cxx Norm',14);

[Cxy_order,t] = MyDSP.DC_time_shift(Cxy,fs);
stem(t,Cxy_order,'LineWidth',2);
MyGen.title_plots('Correlation','Time Shift (s)', 'Cxx Norm',14);

%% Signal B: CW
clc
clear
fs  = 44100;
f   = 159;
T_pulse = 1/f;
n   = 10;
t   = 0:1/fs:T_pulse*n; % 0 -> 10msT_pulse = 1/f;
CW = MySignal.CW_pulse(f,T_pulse*5,n*T_pulse,fs);
subplot(2,1,1); plot(t,CW,'Linewidth',1.4);
xlim([0 max(t)]);
MyGen.title_plots('Time Domain of Signal','Time (s)', 'Amplitude (WU)',14);

[X,f] = MyDSP.MyFFT(CW,fs,'y',0);
subplot(2,1,2); plot(f,abs(X),'Linewidth',1.4);
xlim([0 500]);
MyGen.title_plots('Linear Spectrum','Freq (Hz)', 'Amplitude (WU/Hz)',14);

%% Signal C: LFM
fs  = 48000;
dt  = 1/fs;
T   = 1;
T_1 = 0.25;
N_1 = T_1*fs;
T_2 = 0.75;
N_2 = T_2*fs;

f1  = 0;
f2  = 500;

[x1,t1] = MySignal.LFM_Pulse(f1,f2,T_1,fs);
[X,f] = MyDSP.MyFFT(x1,fs,'y',0);
subplot(2,1,1); plot(t1,x1,'Linewidth',1.4);
max([0 t1]);
MyGen.title_plots('Time Domain of Signal','Time (s)', 'Amplitude (WU)',14);
subplot(2,1,2); plot(f,abs(X),'Linewidth',1.4);
xlim([0 600]);
MyGen.title_plots('Linear Spectrum','Freq (Hz)', 'Amplitude (WU/Hz)',14);

%% Signal A: 
clc
clear
fs  = 48000;
dt  = 1/fs;

T_1 = 0.25;
N_1 = T_1*fs;
T_2 = 0.75;
N_2 = T_2*fs;
t   = (0:1:(N_1+N_2-1)).*dt;
x_1 = randn(1,N_1);
x_1 = x_1./max(x_1);
x_2 = zeros(1,N_2);
x   = [x_1,x_2];
subplot(2,1,1); plot(t,x,'Linewidth',1.4); grid on;
MyGen.title_plots('Random Signal Time Signal','Time (s)', 'Amplitude (WU)',14);

[Cxy]         = MyDSP.MyCrossCorCirc(x, x);
[Cxy_order,t] = MyDSP.DC_time_shift(Cxy,fs);
subplot(2,1,2); plot(t,Cxy_order,'Linewidth',1.4); grid on;
MyGen.title_plots('Auto Correlation','Time Shift (s)', 'Cxy Norm',14);

ms = (sum(x.^2))/length(x);


%% Signal B: CW
fs  = 48000;
dt  = 1/fs;
T   = 1;
N   = T*fs;
f0  = 1500;
T_pulse = 1/f0;
t   = (0:1:(N-1)).*dt;
x = MySignal.CW_pulse(f0,0.25,1,fs);
subplot(2,1,1); plot(t,x); grid on;
MyGen.title_plots('CW Pulse Time Domain','Time (s)', 'Amplitude (WU)',14);

[Cxy]         = MyDSP.MyCrossCorCirc(x, x);
[Cxy_order,t] = MyDSP.DC_time_shift(Cxy,fs);
subplot(2,1,2); plot(t,Cxy_order); grid on;
MyGen.title_plots('Auto Correlation','Time Shift (s)', 'Cxy Norm',14);

ms = (sum(x.^2))/length(x);

%% Signal C: LFM
fs  = 48000;
dt  = 1/fs;
T   = 1;
T_1 = 0.25;
N_1 = T_1*fs;
T_2 = 0.75;
N_2 = T_2*fs;

f1  = 2000;
T1  = 1/f1;
f2  = 1000;
T2  = 1/f2;

t1  = (0:1:(N_1-1)).*dt;
A = f1;
B = (f2-f1)/(2*T_1);
x1  = sin(2*pi*(A.*t1 + B.*(t1.^2)));
[X,f] = MyDSP.MyFFT(x1,fs,'y',0);


x2  = zeros(1,N_2);
x   = [x1,x2];
t   = (0:1:(N_1+N_2-1)).*dt;
subplot(2,1,1); plot(t,x); grid on;
MyGen.title_plots('LFM Time Domain','Time (s)', 'Amplitude (WU)',14);

[Cxy]         = MyDSP.MyCrossCorCirc(x, x);
[Cxy_order,t] = MyDSP.DC_time_shift(Cxy,fs);
subplot(2,1,2); plot(t,Cxy_order); grid on;
MyGen.title_plots('Auto Correlation','Time Shift (s)', 'Cxy Norm',14);

ms = (sum(x.^2))/length(x);
