%%
clc
clear
[filepath,~,~] = fileparts(pwd);
newpath = ['C:\Users\tonel\Desktop\MATLAB_Work\','\Function_Packages'];
userpath(newpath);
Intro();

%% Part a 
% At r = 0, this filter is an all pass, yn = "xn"
% at r = 1, this filter is a no pass, yn = yn-1, but xn = 0 so no pass
% anywhere else its a low pass filter

%% Part b/c -- Testing
r = 1.0;
aa = [1, -r];
bb = [0, sqrt(1-(r^2))];
fs = 44100;
MyDSP.plot_filter_simple_Ak_BK(aa,bb,1000,fs,1);

%% part d
r = 0.85;
aa = [1, -r];
bb = [0, sqrt(1-(r^2))];
fs = 5000;
MyDSP.plot_filter_simple_Ak_BK(aa,bb,1000,fs,1,[0 fs/2]);
fx = -fs*log(r)/(2*pi);
figure(1);
labasd = 0:1/fs/2:0.8-(1/fs);
subplot(2,1,1); plot(fx*ones(1,length(labasd)),labasd,'Linewidth',1.6);

%% Part e
[dn, ~] = MyDSP.unit_sample(1000,'n');
h = filter(bb,aa,dn);
[H,f] = MyDSP.MyFFT(h,fs,'n',0);
dB_down = 0.707*max(abs(H));
Idx = MyDSP.find_val(abs(H),dB_down,0.001,0.001);
f_dB_down = f(Idx(1));
fx = -fs*log(r)/(2*pi);

disp(['Determined 3dB down pt: ',num2str(f_dB_down)]);
disp(['Determined fx: ',num2str(fx)]);

% This is the 3dB down point fx
%%

