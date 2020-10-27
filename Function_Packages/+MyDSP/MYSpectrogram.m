function [Gxx_array,dB_vals,t_array_big,f_array_big] = MYSpectrogram(...
    xn,NSTFT,overlap,fs,T)
% Inputs:
% xn      = time array to analyze
% NSTFT   = number of samples per record
% overlap = % of overlap
% fs      = sampling rate
% T       = Desired time to look at
% Outputs:
% Gxx_array   = array of Gxx values in spectrogram
% dB_vals     = dB_vals of Gxx_array
% t_array_big = time array for spectrogram
% f_array_big = frequency array for spectrogram
% By: Matthew Luu
% Last Edit: 9/18/20
% My version on plotting the spectrogram of a signal

% Begin Code:
N_overlap  = round(overlap*NSTFT);        % Overlap sample length
N          = length(xn); % length of total array

if nargin < 5
    T = N/fs;
else
    T = T;
end
% Constants
p_ref = 29e-6;
f_ref = 1;
G_ref = (p_ref^2)/f_ref;
% G_ref = 1;

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

xn_array = zeros(NS,NSTFT);     % Per-allocate
L_window = NSTFT;               % Window lengths
window   = hann(L_window,'periodic')';     % Window
ms = sum(window.*window)/L_window;
window = window/sqrt(ms);

% Begin B&B
xn_array(1,:) = xn(1:NSTFT);
[Gxx,Sxx,f_Sxx,f_Gxx] = MyPSDX(xn_array(1,:),fs);
Gxx_array(1,:) = Gxx;

for a = 2:NS
    SC  = (NSTFT-N_overlap)*(a-1);
    xn_array(a,:) = xn(1+SC:NSTFT+SC).*window;
    [Gxx,Sxx,f_Sxx,f_Gxx] = MyPSDX(xn_array(a,:),fs);
    Gxx_array(a,:) = Gxx;
end

% Formatting all vectors
dt          = T/NS;                 % dt for new array
f_array_big = f_Gxx;                % frequency array
t_array_big = (0:1:NS-1).*dt;       % time array 
dB_vals     = 10*log10(Gxx_array/G_ref)'; % dB-ify values
dB_vals(dB_vals<-100) = -100;       % Suppress values
% dB_vals = Gxx_array';

% Plotting
figure(2) % Call the spectrogram figure number 1
imagesc(t_array_big, f_array_big, dB_vals);
axis xy % This command forces the vertical axis to increase upward
colormap(jet) % This command selects the color mapping for dBvalues
hcb = colorbar; % This command displays a color bar for relating color to value
ylabel(hcb, 'dB', 'fontsize', 14) % Optional label for colorbar
set(gca, 'fontsize', 14) % set font size for numbers on axes
xlabel('Time [s]' , 'fontsize', 14)
ylabel('Frequency [Hz]' , 'fontsize', 14) 
ylim([0,max(f_array_big)*0.8]);
end