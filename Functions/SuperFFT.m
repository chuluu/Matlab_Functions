function [FFT_Result,f] = SuperFFT(data,Fs)
% [FFT_Result,f] = SuperFFT(data,Fs)
% Inputs: 
% data = data array to b fft'd
% Fs   = sampling rate
% Outputs:
% FFT_Result = result of the FFT
% f          = frequency Vector
% Info:
% By: Matthew Luu
% Last Edit: 11/17/18
% This function will take fft of time series using the cooley-tukey method
% of recurssion 
% FFT Function NEED To learn how recurssion really works

%data manipulation to be correct lengths
data_length = length(data);
N_sum_pow2 = nextpow2(data_length);
N_sum_pow2 = 2.^N_sum_pow2;

zero_append_length = N_sum_pow2 - data_length;

y = [data,zeros(1,zero_append_length)];
N = length(y); 

FFT_Result = fft_2(y);
f = Fs*((N/-2):(-1+N/2))/N;
end

function FFT_Result = fft_2(x)
N = length(x);  %define Length of recurssion length
if N == 1       %This section is used to know when to end the recurssive splitting (The ground level of recurssion)
    FFT_Result = x;
else
    %[even_num, odd_num] = seperate(x,N); %Seperates odds and evens
    even_num = x(1:2:N);  %Seperates odds and evens
    odd_num  = x(2:2:N);  %Seperates odds and evens
    even = fft_2(even_num);    %Computes just the even coefficients recurssively
    odd  = fft_2(odd_num);     %Computes just the odd coefficients recurssively
    Wn   = twiddle(N);         %Obtains the twiddle factor for which stage you are on
    FFT_Result_1 = even + odd.*Wn;      %Computes the answers of the layer of recurssion
    FFT_Result_2 = even - odd.*Wn;      %Computes the answers of the layer of recurssion
    FFT_Result = [FFT_Result_1 FFT_Result_2];
end
end

function W = twiddle(k)
N_t = k;
n = 0:1:((N_t)/2)-1;
W = exp((1i*2*pi.*n)/N_t);
end





%% Split function
% function [even_samples, odd_samples] = seperate(y,N)
% % Seperates the array into the data points you need
% even_samples = zeros(1,N/2);
% odd_samples = zeros(1,N/2);
% e_o = 1;
% 
% for x = 1:N
%     if mod(x,2) == 1
%         even_samples(1,e_o) = y(x);
%     else
%         odd_samples(1,e_o) = y(x);
%         e_o = e_o + 1;
%     end
%     even_odd = [even_samples,odd_samples];
% end
% end
