%%
clc
clear
[filepath,~,~] = fileparts(pwd);
newpath = ['C:\Users\tonel\Desktop\MATLAB_Work\','\Function_Packages'];
userpath(newpath);
Intro();

%% Part a -c: Testing the functions
fs = 44100;
dt = 1/fs;

f_pt = [100,500,100];
ang_pt = [pi/2, pi, 3*pi/2];
t_pt = [0,3,6];

[f_poly,f_coef,t] = Quadratic_Frequency_Sweep_Freq(f_pt,t_pt,fs);
[ang_poly,ang_coef,t] = Quadratic_Frequency_Sweep_Ang(ang_pt,t_pt,fs);

plot(t,f_poly,'Linewidth',1.6); grid on;
MyGen.title_plots('Quadratic Frequency Sweep (f(t))','Time (s)', 'Frequency (Hz)',14);
% subplot(2,1,2); plot(t,ang_poly,'Linewidth',1.6); grid on;
% MyGen.title_plots('Quadratic Frequency Sweep (\phi(t))','Time (s)', '\phi (rad)',14);

%% part d and e 
clc
clear
fs = 44100;
dt = 1/fs;

% Setup array
t = 0:dt:0.4;
xn_array = zeros(1,length(t));
N1 = round(0.145*fs);
N2 = round(0.280*fs);

% Insert the points
f_pt = [1020,1410,990];
t_pt = [0.145,0.190,0.280];

% Execute
[f_t,f_coef,t_pulse] = Quadratic_Frequency_Sweep_Freq(f_pt,t_pt,fs);

% Part d and e
% Need the integral for instantaneous phase
f_t_integral = f_coef(1).*(t_pulse.^3)./3 + f_coef(2).*(t_pulse.^2)./2 + f_coef(3).*t_pulse;
phase_t = 2*pi*f_t_integral;

% Get the quadratic pulse
xn = sin(phase_t);
xn_array(N1:N2) = xn;

% Look at freq and time domain
[X,f] = MyDSP.MyFFT(xn,fs,'y',0);

figure(1);
subplot(2,1,1); plot(t,xn_array);
MyGen.title_plots('Part 2d Quadratic Chirp','Time (s)', 'Amplitude (WU)',14);

subplot(2,1,2); plot(f,abs(X));
MyGen.title_plots('Part 2d Quadratic Chirp','Frequency (Hz)', 'Amplitude (WU/Hz)',14);

xlim([0 1600]);

% Check spectrogram to see the profile part e
figure(2);
[Gxx_array,dB_vals,t_array_big,f_array_big] = MyDSP.MYSpectrogram(xn_array,1024,0.9,fs);
ylim([0 3000]);

%%
sound(xn)

%% Bird Call
clc
clear
[xn,fs] = audioread('Bird_call_iso1.wav');
[Gxx_array,dB_vals,t_array_big,f_array_big] = MyDSP.MYSpectrogram(xn',512,0.9,fs);

% Look at spectrogram, notice it is a quadratic sweep, create harmonics and
% fundamental of the quadratic sweep
%% 
function [f_poly,f_coef,t] = Quadratic_Frequency_Sweep_Freq(f_pt,t_pt,fs)
    f_coef = polyfit(t_pt,f_pt,2);
    dt = 1/fs;
    t = (t_pt(1):dt:t_pt(3));
    f_poly = f_coef(1).*t.^2 + f_coef(2).*t + f_coef(3);
end

function [ang_poly,ang_coef,t] = Quadratic_Frequency_Sweep_Ang(ang_pt,t_pt,fs)
    ang_coef = polyfit(t_pt,ang_pt,2);
    dt = 1/fs;
    t = (t_pt(1):dt:t_pt(3));
    ang_poly = ang_coef(1).*t.^2 + ang_coef(2).*t + ang_coef(3);
end 
