%% Test Case rectangle, hamming, and kaiser
clc
clear

fs = 1000;
hn_lp_rect = MyDSP.FIR_Filter_By_Window(15,0.2,rectwin(15));
hn_lp_hamm = MyDSP.FIR_Filter_By_Window(15,0.2,hamming(15)); 

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

hn_lp_kaiser = MyDSP.FIR_Filter_By_Window(15,0.2,kaiser(15,B));
[HF_kaiser, W] = freqz(hn_lp_kaiser, 1, 1000);
[HF_rect, W] = freqz(hn_lp_rect, 1, 1000);
[HF_hamm, W] = freqz(hn_lp_hamm, 1, 1000);

Fd = W./(2.*pi);

plot(Fd,abs(HF_kaiser)); hold on;
plot(Fd,abs(HF_rect)); hold on;
plot(Fd,abs(HF_hamm)); hold on;
legend('kaiser','rectangle','hamming');
grid on;
