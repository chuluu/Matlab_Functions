clc
clear

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
[Cxy]         = MyCrossCorCirc(x, x);
[xcorr_1,lag] = xcorr(x,x); 
stem(Cxy,'LineWidth',2);
title_plots('Correlation','Samples', 'Cxx Norm',14);

[Cxy_order,t] = DC_time_shift(Cxy,fs);
stem(t,Cxy_order,'LineWidth',2);
title_plots('Correlation','Time Shift (s)', 'Cxx Norm',14);

%% Part CW Test
clc
clear
fs  = 44100;
f   = 159;
T_pulse = 1/f;
n   = 10;
t   = 0:1/fs:T_pulse*n; % 0 -> 10msT_pulse = 1/f;
CW = CW_pulse(f,T_pulse*5,n*T_pulse,fs);
subplot(2,1,1); plot(t,CW,'Linewidth',1.4);
xlim([0 max(t)]);
title_plots('Time Domain of Signal','Time (s)', 'Amplitude (WU)',14);

[X,f] = MyFFT(CW,fs,'y',0);
subplot(2,1,2); plot(f,abs(X),'Linewidth',1.4);
xlim([0 500]);
title_plots('Linear Spectrum','Freq (Hz)', 'Amplitude (WU/Hz)',14);

%% Signal C: LFM
fs  = 48000;
dt  = 1/fs;
T   = 1;
T_1 = 0.25;
N_1 = T_1*fs;
T_2 = 0.75;
N_2 = T_2*fs;

f1  = 0;
T1  = 1/f1;
f2  = 500;
T2  = 1/f2;

t1  = (0:1:(N_1-1)).*dt;
A = f1;
B = (f2-f1)/(2*T_1);
x1  = sin(2*pi*(A.*t1 + B.*(t1.^2)));
[X,f] = MyFFT(x1,fs,'y',0);
subplot(2,1,1); plot(t1,x1,'Linewidth',1.4);
max([0 t1]);
title_plots('Time Domain of Signal','Time (s)', 'Amplitude (WU)',14);
subplot(2,1,2); plot(f,abs(X),'Linewidth',1.4);
xlim([0 600]);
title_plots('Linear Spectrum','Freq (Hz)', 'Amplitude (WU/Hz)',14);


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
title_plots('Random Signal Time Signal','Time (s)', 'Amplitude (WU)',14);

[Cxy]         = MyCrossCorCirc(x, x);
[Cxy_order,t] = DC_time_shift(Cxy,fs);
subplot(2,1,2); plot(t,Cxy_order,'Linewidth',1.4); grid on;
title_plots('Auto Correlation','Time Shift (s)', 'Cxy Norm',14);

ms = (sum(x.^2))/length(x)


%% Signal B: CW
fs  = 48000;
dt  = 1/fs;
T   = 1;
N   = T*fs;
f0  = 1500;
T_pulse = 1/f0;
t   = (0:1:(N-1)).*dt;
x = CW_pulse(f0,0.25,1,fs);
subplot(2,1,1); plot(t,x); grid on;
title_plots('CW Pulse Time Domain','Time (s)', 'Amplitude (WU)',14);

[Cxy]         = MyCrossCorCirc(x, x);
[Cxy_order,t] = DC_time_shift(Cxy,fs);
subplot(2,1,2); plot(t,Cxy_order); grid on;
title_plots('Auto Correlation','Time Shift (s)', 'Cxy Norm',14);

ms = (sum(x.^2))/length(x)

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
[X,f] = MyFFT(x1,fs,'y',0);


x2  = zeros(1,N_2);
x   = [x1,x2];
t   = (0:1:(N_1+N_2-1)).*dt;
subplot(2,1,1); plot(t,x); grid on;
title_plots('LFM Time Domain','Time (s)', 'Amplitude (WU)',14);

[Cxy]         = MyCrossCorCirc(x, x);
[Cxy_order,t] = DC_time_shift(Cxy,fs);
subplot(2,1,2); plot(t,Cxy_order); grid on;
title_plots('Auto Correlation','Time Shift (s)', 'Cxy Norm',14);

ms = (sum(x.^2))/length(x)

%% Signal E:LFM/CW
fs  = 44100;
dt  = 1/fs;
T1  = 0.25;
N1  = T1*fs;

T2  = 0.75;
N2  = T2*fs;

T3  = 30;
N3  = T3*fs;
f1  = 2000;
f2  = 1000;
f0  = 1500;

t1  = (0:1:(N1-1)).*dt;
A = f1;
B = (f2-f1)/(2*T1);
xlf  = sin(2*pi*(A.*t1 + B.*(t1.^2)));

x2  = zeros(1,N2);
xolfm = zeros(1,1);
xocw  = zeros(1,1);

xdlfm = horzcat(xlf,x2);
xdcw  = CW_pulse(f0,0.25,1,fs);

for a = 1:T3
    xlfm  = [xolfm,xdlfm];
    xolfm = xlfm;

    xcw  = [xocw,xdcw];
    xocw = xcw;
end

t = (0:1:(N3-1)).*dt;
xlfm = xlfm(2:end);
xcw = xcw(2:end);


subplot(2,1,1); plot(t,xlfm); grid on;
title_plots('Time Domain of Signal','Time (s)', 'Amplitude (WU)',14);
[Cxy]         = MyCrossCorCirc(xlfm, xlfm);
[Cxy_order,t] = DC_time_shift(Cxy,fs);
subplot(2,1,2); plot(t,Cxy_order); grid on;
title_plots('Auto Correlation','Time Shift (s)', 'Cxy Norm',14);


% ms = (sum(x.^2))/length(x)
%% 
%sound(xcw,fs)
sound(xlfm,fs)

 
%% Part III Replica CC part 1
[xn,fs] = audioread('V0_LFM15K.wav');
[yn,~] = audioread('R0_LFMhigh.wav');
dt = 1/fs;
T_rec   = 1;
N_rec   = T_rec*fs;

[Gxx_avg,f_Gxx] = MyAvgGxx_Overlap(xn',N_rec,0.5,fs);
loglog(f_Gxx,Gxx_avg) 
title_plots('Avg Gxx - 50% Overlap 1 second Rec','Freq (Hz)', 'Intensity (WU^2/Hz)',14);
xlim([0 22000]);
grid on;

%% Part III Replica CC part 1

N_x = length(xn); 
N_y = length(yn);
yn_pad = [yn;zeros(abs(N_x-N_y),1)];
t_yn = (0:1:N_x-1).*dt;
[Cxy_order,t_shift] = DC_time_shift(yn_pad,fs);
xlim([min(t_shift) max(t_shift)]);

[Cxy]         = MyCrossCorCirc(xn, yn_pad);
[Cxy_order,t] = DC_time_shift(Cxy,fs);
subplot(3,1,1); plot(t_yn,xn); grid on;
title_plots('V0LFM15K Time Domain','Time (s)', 'Amplitude (WU)',14);
xlim([0 6]);
subplot(3,1,2); plot(t_yn,yn_pad);
xlim([0 6]);

subplot(3,1,3); plot(t_yn,Cxy,'Linewidth',1.4); grid on;
title_plots('Replica Cross Correlation','Time Shift (s)', 'Cxy Norm',14);
xlim([0 6]);
