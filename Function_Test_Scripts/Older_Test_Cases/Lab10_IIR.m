%% Requirements
RS = 0.013; 
RP = 0.013;
Fp = 0.1333;
Fs = 0.2667;
Ft = 0.1333;
fs = 1000;

%f = [Fp*fs, Fs*fs];
%% Parks Mc-Clellan
F = [Fp Fs];
a = [1 0];
Dev = [RS RP];
[N,Fo,Ao,WP] = firpmord(F*2,a,Dev);

hP = firpm(N,[0 Fp Fs .5]*2,[1 1 0 0]); 

[HF_P, W] = freqz(hP, 1, 2000);

Fd = W./(2.*pi);
plot_freq_responses(Fd, HF_P, fs, 5); 

[poles,zeros,HF,Fd,hn,n] = show_filter_responses(1,hP,fs,1000,50,10)
%% ButterWorth
Rp_B = -20*log10(1-RP);
Rs_B = -20*log10(RS);
[N_B,Wn_B] = buttord(Fp*2, Fs*2, Rp_B, Rs_B);

[B_B,A_B] = butter(N_B,Wn_B);


[HF_Butter, W] = freqz(B_B, A_B, 2000);
Fd_B = W./(2.*pi);
plot_freq_responses(Fd_B, HF_Butter, fs, 5); 

%[poles,zeros,HF,Fd,hn,n] = show_filter_responses(A_B,B_B,fs,1000,50,10)
%% Test 
% Specifications
Rp = 0.013;
Rs = 0.013;
Rp_dB = -20 * log10(1 - Rp);
Rs_dB = -20 * log10(Rs);
Fp = 0.1333;
Fs = 0.2667;
Ft = 0.1333;
fsample = 1000;


% Chebyshev Type 2
[order, Wn] = cheb2ord(Fp*2, Fs*2, Rp_dB, Rs_dB);
[B, A] = cheby2(order, Rs_dB, Wn);

[~, ~, HF_cheby2, Fd, ~, ~] = show_filter_responses(A, B, fsample, 10000, 100, 1);