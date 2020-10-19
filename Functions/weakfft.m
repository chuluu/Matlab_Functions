%% Perform FFT Using Matrix Multiplication (Still brute Force Method but faster than loops)function FFT_Result = weakfft(data)
function FFT_Result = weakfft(data)
data_length = length(data);
N_sum_pow2 = nextpow2(data_length);
N_sum_pow2 = 2.^N_sum_pow2;

zero_append_length = N_sum_pow2 - data_length;

y = [data,zeros(1,zero_append_length)];
N = length(y); 

k_bin = 0:1:N-1;
Num = 0:1:N-1;
Wk = exp(((-1i*2*pi*Num)./N)'*k_bin); % Basis 
FFT_Result = y * Wk;
end

%% Code that was previously used, but not needed

%% Seperate Arrays into odd and even --> We are gonna need this for something
% even_samples = zeros(1,4);
% odd_samples = zeros(1,4);
% e_o = 1;
% 
% for x = 1:N
%     if mod(x,2)
%         even_samples(1,e_o) = y(x);
%     else
%         odd_samples(1,e_o) = y(x-1);
%         e_o = e_o + 1;
%     end
% end

%% Perform FFT Math and double loops, slow, inneficient and brute force
% k = 1;
% x = 0;
% m = 1;
% loser = 1;
% K_bin_Result = zeros(1,N);
% FFT_Result = zeros(1,N);
% 
% while k < N
% if k == loser
%     k = k - 1;
% else 
%     k = k;
% end
%     while x < N
%         WkN = exp((-1i*2*pi*x*k)/N);
%         if rem(m,2) == 2
%             K_bin_Result(1,m) = y(m+1)*WkN;
%         else
%             K_bin_Result(1,m) = y(m)*WkN;
%         end
%         x = x + 1;
%         m = m + 1;
%     end
% k = k + 1;
% FFT_Result(1,k) = sum(K_bin_Result);
% K_bin_Result = zeros(1,N);
% x = 0;
% m = 1;
% loser = loser + 1;
% end


