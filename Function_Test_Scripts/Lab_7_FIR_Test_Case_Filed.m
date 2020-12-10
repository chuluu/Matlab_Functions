hn_lp = FIR_Filter_By_Window(11,0.25,blackman(11)); 
fs = 16000;

%[HF_help, W] = freqz(hn_lp, 1, 1000);
%Fd = W./(2.*pi);

%plot_freq_responses(Fd, HF_help, fs, 5); 

%%
M = 7; 
Fc = 0.22;
n = -(M-1)/2:1:(M-1)/2;
h = 2.*Fc.*(sin(2*pi*Fc.*n)./(2*pi*Fc.*n))
h(n==0) = 2.*Fc;

n = 0:1:4;
sup = ((-1).^n)

w = hann(7);
w = w';

ASD = w.*h;

help = FIR_Filter_By_Window(7,0.22,hann(7));
help_HP = sup.*help(2:6);

[HF_help, W] = freqz(help_HP, 1, 1000);
Fd = W./(2.*pi);
plot_freq_responses(Fd, HF_help, 2800, 5); 

% Bk = hn_lp;
% Ak = 1;
% [poles,zeros,HF,Fd,hn,n] = show_filter_responses(Ak,Bk,fs,100,50,5);
%% Part 5
fs = 1000;
hn_lp_rect = FIR_Filter_By_Window(15,0.2,rectwin(15));
hn_lp_hamm = FIR_Filter_By_Window(15,0.2,hamming(15)); 

As = -20*log10(0.03);
Ap = 20*log10((1+0.03)/(1-0.03));

A = max(As,Ap);
if (A > 50)
    B = 0.01102*(A-8.7);
elseif (A > 21 || A < 50)
    B = (0.5842*(A-21)^0.4) + (0.07886*(A-21));
elseif (A <= 21)
    B = 0;
end

hn_lp_kaiser = FIR_Filter_By_Window(15,0.2,kaiser(15,B));

[HF_rect, W] = freqz(hn_lp_rect, 1, 1000);
[HF_hamm, W] = freqz(hn_lp_hamm, 1, 1000);
[HF_kaiser, W] = freqz(hn_lp_kaiser, 1, 1000);

Fd = W./(2.*pi);


%% Part 5 Design by frequency by sampling
% 
% Fc = 0.2;
% Fp = 0.1335;
% Fs = 0.2665;
% 
% H = [1,1,0.75,0.25,0,0,0,0,0,0,0,0,0,0,0];
% n = (0:1:14)./15;
% stem(n,H)
% 
% [hn, HF, F] = FIR_Filter_By_Freq_Sample(H, 15)

H = [0.00197739822934969, 0.00486996778999742, -0.00200000000000064, -0.0300969802431327, -0.0368699677899980, 0.0730891706856589, 0.287030411328124, 0.404000000000000, 0.287030411328124, 0.0730891706856584, -0.0368699677899981, -0.0300969802431321, -0.00199999999999935, 0.00486996778999869, 0.00197739822935020];

[H_freq_type, W] = freqz(H, 1, 1000);

Fd = W./(2.*pi);

%% PArt 5 optimal design
fs = 1000;
N = 14;
F = [0 0.1335 .2665 .5]*2;
A = [1 1 0 0];

B = firpm(N,F,A);

[HF_B, W] = freqz(B, 1, 1000);
Fd = W./(2.*pi);

%% Plotting
plot_freq_responses(Fd, HF_rect, fs, 5); 
plot_freq_responses(Fd, HF_hamm, fs, 5); 
plot_freq_responses(Fd, HF_kaiser, fs, 5);
plot_freq_responses(Fd, H_freq_type, fs, 5); 
plot_freq_responses(Fd, HF_B, fs, 5); 

[mean_abs_error, mean_sq_error] = magnitude_response_error(H_freq_type,Fd,Fc)
%% Frequency sampling HW_7
Fc = 0.275;
Fp = 0.223; 
Fs = 0.327;
M = 13;

H = [1,1,1,0.925,0.17,0,0,0,0,0.17,0.925,1,1];
n = (0:1:M-1)./M;

[hn, HF, F] = FIR_Filter_By_Freq_Sample(H, M)
figure(3);
stem(n,hn); title('Impulse Response');
xlabel('sample index'); ylabel('Magnitude');

hn
%% HW#6_5 optimal design

%Frequencies
fs = 48000;

As = 42;
Ap = 0.5;

Fp1 = 1200/fs;
Fp2 = 2400/fs;

Fs1 = 800/fs;
Fs2 = 2600/fs;

ripple_s = (1+ripple_A)*10^(-As/20);
ripple_A = ((10^(Ap/20))-1)/((10^(Ap/20))+1);

% Setups
F = [0 Fs1 Fp1 Fp2 Fs2 0.5]*2;
A = [0 0 1 1 0 0];
DEV = [ripple_s ripple_A ripple_s];

[N,Fo,Ao,Wasd] = firpmord([Fs1 Fp1 Fp2 Fs2]*2,[0 1 0], DEV);
%N = 403 right now, but it is not enough for attenuation so bring it up
N = 493;

B = firpm(N,F,A); 

[HF_B, W] = freqz(B, 1, 4000);
Fd = W./(2.*pi);

plot_freq_responses(Fd, HF_B, fs, 5); 