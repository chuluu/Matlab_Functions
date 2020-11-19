function [Gxx_avg,f_Gxx] = MyAvgGxx_Overlap(xn,NSTFT,overlap,fs)
% [Gxx_avg,f_Gxx] = MyAvgGxx_Overlap(xn,NSTFT,overlap,fs)
% Inputs:
% xn         = Input Vector Time Array
% NSTFT      = Length of each record desired
% overlap    = Overlap percentage
% fs         = Sampling Rate
% Outputs:
% Gxx_Avg    = Average Gxx from the operation
% f_Gxx      = Frequency of the Gxx average
% By: Matthew Luu
% Last Edit: 9/20/2020
% Finds average Gxx of signal given number of samples in each rec

% Begin Code:
N_overlap  = round(overlap*NSTFT);        % Overlap sample length
N          = length(xn); % length of total array

% Condition for when overlap is zero (i.e. no overlap)
if N_overlap == 0
    NSTFT_real = NSTFT;
else
    NSTFT_real = NSTFT - N_overlap;
end

if overlap == 0 
    NS       = round(N/NSTFT_real);
elseif overlap < 0.51
    NS       = round(N/NSTFT_real)-2; % General Number of STFT times 
elseif overlap < 0.76
    NS       = round(N/NSTFT_real)-4;
elseif overlap < 0.86
    NS       = round(N/NSTFT_real)-7;
elseif overlap < 0.91
    NS       = round(N/NSTFT_real)-10;
end

xn_array = zeros(NS-1,NSTFT);     % Per-allocate
L_window = NSTFT;               % Window lengths
window   = hann(L_window,'periodic')';     % Window
ms = sum(window.*window)/L_window;
window = window/sqrt(ms);

% Begin B&B
xn_array(1,:) = xn(1:NSTFT);
[Gxx,Sxx,f_Sxx,f_Gxx] = MyDSP.MyPSDX(xn_array(1,:),fs);
Gxx_array(1,:) = Gxx;
for a = 2:NS
    SC  = (NSTFT-N_overlap)*(a-1);
    xn_array(a,:) = xn(1+SC:NSTFT+SC).*window;
    [Gxx,Sxx,f_Sxx,f_Gxx] = MyDSP.MyPSDX(xn_array(a,:),fs);
    Gxx_array(a,:) = Gxx;
end

Gxx_avg = sum(Gxx_array,1)./NS;
df = fs/NSTFT;
RMS = sqrt(sum(Gxx_avg).*df);
disp(['The RMS: ', num2str(RMS)]);
end

