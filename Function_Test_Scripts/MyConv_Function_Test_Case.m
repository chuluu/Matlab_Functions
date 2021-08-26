%% Intro
% Test Case for Numerical Integration using trapezoids

clc
clear
[filepath,~,~] = fileparts(pwd);
newpath = [filepath,'\Function_Packages'];
addpath(newpath);
Intro();

%% Question 1:
% Given the filter coeficients:
% aa = [1.00000, -3.66103, 5.09866, -3.20228, 0.76601];
% bb = [7.82021, 0.00000, -15.64042, 0.00000, 7.82021]/1000;
% Do the following
% a) use 1s long impulse to find the input of this filter and find the
% frequency respons. plot the magnitude and phase as a function of
% frequency from 0 to fs/2Hz
clc
clear
aa = [1.00000, -3.66103, 5.09866, -3.20228, 0.76601];
bb = [7.82021, 0.00000, -15.64042, 0.00000, 7.82021]/1000;
fs = 1000;
dt = 1/fs;
T  = 1;
N  = fs*T;
df = 1/(N*dt);
t  = (0:1:N-1)*dt;

%% Part A: 1s impulse response and magnitude/phase response
clc
% Obtain unit sample response
[dn ,n] = unit_sample(N);
hn = filter(bb, aa, dn);
figure(1); 
stem(t,hn,'.','Linewidth',1.6);
title('Unit Sample Response'); 
xlabel('Time (s)','Fontsize',12); 
ylabel('Magnitude (WU)','Fontsize',12); 

% Obtain frequency filter response by taking the linear spectrum
[HF,f] = MyDSP.MyFFT(hn,fs,'y',0);

% Plot the magnitude of HF on a linear scale
figure(2);
subplot(2,1,1); plot(f,abs(HF),'Linewidth',1.6); hold on %New Changes 
grid on
xlabel('Analog Frequency (Hz)','Fontsize',12); 
ylabel('Magnitude Response','Fontsize',12); 
title('Frequency Response of Filter','Fontsize',12); 
xlim([0 fs/2]);
% Phase
subplot(2,1,2); plot(f,angle(HF),'Linewidth',1.6); %New Changes
grid on
xlabel('Analog Frequency (Hz)','Fontsize',12); 
ylabel('Phase Response(rad)','Fontsize',12); 
xlim([0 fs/2]);

%%
% Part 1 Generate the sine wave
f0 = 100; 
A = 1;
x = A*sin(2.*pi.*f0.*t); % Wait why pick 100 Hz?


% Part 2 Calculate the linear spectrum
[X,f] = MyDSP.MyFFT(x,fs,'y',0);

% Part 3 Apply filter function and A and B
y1 = filter(bb, aa, x);
[y,t_2] = MyDSP.MyFFTConv(x',hn,fs,'n');
figure(1);
plot(t,x); hold on;
plot(t_2,y);
plot(t,y1);
% Part 4 Calculate the linear spectrum
[Y,f] = MyDSP.MyFFT(y,fs,'y',0);

%plot(t_n,y);
% Comparison plotting (Extra visualization step
figure(2);
plot(f,abs(X)); hold on %New Changes 
plot(f,abs(Y)); hold on %New Changes 
xlim([0 fs/2]);
figure(3);
plot(f,abs(HF)); hold on %New Changes 
xlim([0 fs/2]);

% Part 5 Compare the magnitude difference between the two sine waves
f_idx  = find(f == 100);
HF_mag_100_R = abs(Y(f_idx))/abs(X(f_idx)) % Actual magnitude difference at 100Hz

% Part 6 Obtain magnitude on frequency curve at 100 Hz
HF_mag_100 = abs(HF(f_idx)) % Expected magnituide difference at 100 Hz

% Part 7 Find difference of two magnitudes
H_diff    = ((HF_mag_100-HF_mag_100_R)/HF_mag_100)*100;
%%
% Part 4 Calculate the linear spectrum
[Y,f2] = MyDSP.MyFFT(y,fs,'y',0);

% Comparison plotting (Extra visualization step
figure(2);
plot(f,abs(X)); hold on %New Changes 
plot(f2,abs(Y)); hold on %New Changes 
xlim([0 fs/2]);
figure(3);
plot(f,abs(HF)); hold on %New Changes 
xlim([0 fs/2]);

% Part 5 Compare the magnitude difference between the two sine waves
f_idx  = find(f == 100);
HF_mag_100_R = abs(Y(f_idx))/abs(X(f_idx)) % Actual magnitude difference at 100Hz

% Part 6 Obtain magnitude on frequency curve at 100 Hz
HF_mag_100 = abs(HF(f_idx)) % Expected magnituide difference at 100 Hz

% Part 7 Find difference of two magnitudes
H_diff    = ((HF_mag_100-HF_mag_100_R)/HF_mag_100)*100;
% HF_ang_100 = angle(HF(f_idx))
% HF_ang_100_R = angle(Y(f_idx)) % Actual magnitude difference at 100Hz
% 
% plot(f,angle(Y)); hold on;
% plot(f,angle(X));
% xlim([0 fs/2]);f0 = 100; 
A = 1;
x = A*sin(2.*pi.*f0.*t); % Wait why pick 100 Hz?
plot(t,x); hold on;
%%
function [dn, n] = unit_sample(number_of_samples)
%Inputs: Number of Samples for unit sample
%Outputs: dn = unit sample at 0, n = index for plotting
zero_dn = zeros(1,(number_of_samples-1));
dn = 1/(number_of_samples)*[number_of_samples, zero_dn]; %Set unit sample to 1 amplitude
n = 0:1:(number_of_samples-1);
end