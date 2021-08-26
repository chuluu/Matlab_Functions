fs = 44100;
N = 8;
k = 0.8;
Ak = [1,zeros(1,N-1),-k];
Bk = [k,zeros(1,N-1),1];

show_filter_responses(Ak,Bk,fs,10000,200,1)

% %% 
% fs = 44100;
% A = 0.8; 
% d = 10;
% Ak = 1;
% Bk = [zeros(1,d-1),0.8];
% [poles,zeros,HF,Fd,hn,n] = show_filter_responses(Ak,Bk,fs,10000,200,1)
% hn_lp = FIR_Filter_By_Window(21,00.09,hann(21)); 
% [H_LP, W] = freqz(hn_lp, 1, 10000);
% %% asd
% Htotal = HF.*H_LP;





