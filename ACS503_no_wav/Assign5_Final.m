%% Intro
%{
Assignment #5: Spectrograms!!!
Description of Code
%{
Spectrograms baby
%}

Color Codes
%{
'red'	'r'	[1 0 0]
'green'	'g'	[0 1 0]
'blue'	'b'	[0 0 1]
'cyan'	'c'	[0 1 1]
'magenta'	'm'	[1 0 1]
'yellow'	'y'	[1 1 0]	
'black'	'k'	[0 0 0]
'white'	'w'	[1 1 1]
%}

Windows
%{
% rectwin( ) - Rectangular window.
% triang( ) - Triangular window.
% bartlett( ) - Bartlett window (Triangle Window with ?0?s at both ends)
% hann( ) - von Hann window (Hanning Window with ?0?s at both ends)
% hanning( ) - Hanning window (With non-zero end samples).
% hamming ( ) - Hamming window.
% blackman( ) - Blackman window.
% kaiser( ) - Kaiser window (with b parameter)
% tukeywin( ) - Tukey window.
% Barthannwin( ) - Modified Bartlett-Hanning window.
% bohmanwin( ) - Bohman window.
% chebwin( ) - Chebyshev window.
% flattopwin( ) - Flat Top window.
% gausswin( ) - Gaussian window.
% blackmanharris( ) - Minimum 4-term Blackman-Harris window
% nuttallwin( ) - Nuttall defined minimum 4-term Blackman-Harris window.
% parzenwin( ) - Parzen (de la Valle-Poussin) window. 
%}

Constants
%{
Atmospheric Pressure      =  2 * 10^-5 Pa
Boltzmann Constant        =  1.38 * 10^-23 J/molecule
Room Temperature          =  21 C
Specific Impedance of air =  420 Rayls
Speed of Sound            =  343 m/2
Permittivity (free space) =  8.85 * 10^-12 
Permeability (free space) =  4π * 10^-12 
%}

Typical Equations
%{
dB pressure         =  20*1og(P/P_ref) dB
dB Intensity        =  10*1og(P/P_ref) dB
dispertion equation =  c = λf m/s
Mechanical f_res    =  (1/2π) * sqrt(k/m) Hz
%}

%}

clear
% Directory for Functions
newpath = 'C:\Users\mbluu\OneDrive\Desktop\MATLAB_Work\Functions';
userpath(newpath)

Intro()
%% sub
t = 0:0.001:2;
fs = 1/0.001;
x = chirp(t,100,1,200,'quadratic');

[Gxx_array,dB_vals,t_array_big,f_array_big] = MYSpectrogram(...
    x,128,0.5,fs,2);

%% Part 1: Test Signal
clear
clc
% Set up Signal
fs = 2048; 
N  = 12288;
T  = 6;

dt = 1/fs;
t  = (0:N-1).*dt;
f0 = 128;
xn_1st = zeros(1,N/3);
xn_2nd = sin(2.*pi.*f0.*t(N/3:2*(N/3)-1));
xn_3rd = zeros(1,N/3);
xn = [xn_1st, xn_2nd, xn_3rd];

overlap = 0.25;
NSTFT   = 256;

[Gxx_array,dB_vals,t_array_big,f_array_big] = MYSpectrogram(...
    xn,NSTFT,overlap,fs,T);

%% Part 2: Longer waveform
clc
clear
[xn,fs] = audioread('T4_C5_3L_dec4a.wav');
xn = xn';

dt = 1/fs;
T  = dt.*length(xn);
overlap = 0.75;
NSTFT   = 512;

[Gxx_array,dB_vals,t_array_big,f_array_big] = MYSpectrogram(...
    xn,NSTFT,overlap,fs);

%% Part 3: Recording
clc
clear
fs = 10000;
[xn,Gxx] = recording_background(fs,16,4);
xlim([0 2000]);
dt = 1/fs;
T  = dt.*length(xn);
overlap = 0.5;
NSTFT   = 1024;

[Gxx_array,dB_vals,t_array_big,f_array_big] = MYSpectrogram(...
    xn,NSTFT,overlap,fs);

ylim([0 2000]);



%% Old work
% 
% % Inputs to bins
% xn         = xn;
% N          = length(xn); % length of total array
% NSTFT      = 512;        % length of STFT
% overlap    = 0.75;
% N_overlap  = round(overlap*NSTFT);        % Overlap sample length
%
% % Constants
% p_ref = 29e-6;
% f_ref = 1;
% G_ref = (p_ref^2)/f_ref;
% 
% % Condition for when overlap is zero (i.e. no overlap)
% if N_overlap == 0
%     NSTFT_real = NSTFT;
% else
%     NSTFT_real = NSTFT - N_overlap;
% end
% 
% NS       = round(N/NSTFT_real)-4; % General Number of STFT times   
% xn_array = zeros(NS-1,NSTFT);     % Per-allocate
% L_window = NSTFT;               % Window lengths
% window   = hann(L_window)';     % Window
% 
% % Begin B&B
% xn_array(1,:) = xn(1:NSTFT);
% 
% for a = 2:NS-1
%     SC  = (NSTFT-N_overlap)*(a-1);
%     xn_array(a,:) = xn(1+SC:NSTFT+SC).*window;
%     [Gxx,Sxx,f_Sxx,f_Gxx] = MyPSDX(xn_array(a,:),fs);
%     Gxx_array(a,:) = Gxx;
% end
% 
% % Formatting all vectors
% dt          = T/NSTFT;              % dt for new array
% f_array_big = f_Gxx;                % frequency array
% t_array_big = (0:1:NS-2).*dt;       % time array 
% dB_vals     = 10*log10(Gxx_array/G_ref)'; % dB-ify values
% dB_vals(dB_vals<-100) = -100;       % Suppress values
% 
% 
% % Plotting
% surf(t_array_big,f_array_big,dB_vals,'EdgeColor','none')
% axis xy; axis tight; colormap(jet); view(0,90);
% hcb = colorbar;
% ylabel(hcb, 'dB', 'fontsize', 14) % Optional label for colorbar
% set(gca, 'fontsize', 14) % set font size for numbers on axes
% xlabel('Time [s]' , 'fontsize', 14)
% ylabel('Frequency [Hz]' , 'fontsize', 14) 



% Plotting 2?
% figure(2) % Call the spectrogram figure number 1
% imagesc(t_array_big, f_array_big, dB_vals);
% axis xy % This command forces the vertical axis to increase upward
% colormap(jet) % This command selects the color mapping for dBvalues
% hcb = colorbar; % This command displays a color bar for relating color to value
% ylabel(hcb, 'dB', 'fontsize', 16) % Optional label for colorbar
% set(gca, 'fontsize', 18) % set font size for numbers on axes
% xlabel('Time [s]' , 'fontsize', 18)
% ylabel('Frequency [Hz]' , 'fontsize', 18) 