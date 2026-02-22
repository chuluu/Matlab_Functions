%%
clc
clear

%% Part 4 of code: ignore if you want, this was just here so I can keep in one file
% http://www.mit.edu/~6.777/matprops/aluminum.htm properties
L   = 59*10^-2;
a   = 6*10^-3;
E   = 70*10^9;
rho = 2700;
I   = pi*(a^4)/4;
A   = pi*(a^2);
cL  = sqrt(E/rho);
knL = [4.73, 7.853, 10.996, 14.137,17.279];
for n = 1:5
    fn_l(n) = n.*cL./(2*L);
    fn_b(n) = ((knL(n)^2)./((2*pi*(L^2))))*sqrt((E*I)./(rho*A));
end

disp(['Longitudinal Freqs: ', num2str(round(fn_l))]);
disp(['Bending Freqs: ',num2str(round(fn_b))]); 

%% Part 3 Code signals
% I utilized an average Gxx function I built along with PSD fnc I built.
load('sample_calibration_voltage.mat')

t = (0:1:length(V)-1)./fs;

% Method 1: Time series method 
Vrms_1 = rms(V);
disp(['Vrms Time Series: ',num2str(Vrms_1)]);

% Method 2: Max Gxx method
[Gxx_avg,f] = MyAvgGxx(V.',fs,1,rectwin(length(V))); % Please look at fnc
df  = f(2)-f(1);
Vrms_2 = sqrt(max(Gxx_avg).*df);
disp(['Vrms Max Gxx: ',num2str(Vrms_2)]);

% Method 3: Flattop Average Method
avg = 5;
[Gxx_avg,f] = MyAvgGxx(V.',fs,avg,flattopwin(length(V)./avg));
val1 = 998; % Determined from looking at the Gxx flattop
val2 = 1005; % Determined from looking at the Gxx flattop
Vrms_3 = sqrt(trapz(Gxx_avg(val1:val2)));
disp(['Vrms Flattop Avg Gxx: ',num2str(Vrms_3)]);

%% Functions
function [Gxx_avg,f_Gxx] = MyAvgGxx(xn,fs,Nrecs,win)
% [Gxx_avg,f_Gxx] = MyAvgGxx(xn,fs,Nrecs,win)
% Inputs:
% xn         = Input Vector Time Array
% fs         = Sampling Rate
% Nrecs      = Number of records desired
% Outputs:
% Gxx_Avg    = Average Gxx from the operation
% f_Gxx      = Frequency of the Gxx average
% Info:
% By: Matthew Luu
% Last Edit: 9/20/2020
% Finds average Gxx of signal given number of records

% Begin Code:
N = length(xn);
N_new = N/Nrecs;
df = fs/N_new;
xn_array = zeros(Nrecs,N_new);
window = win.';
L_window = length(window);
ms = sum(window.*window)/L_window;
window = window/sqrt(ms);
for a = 1:Nrecs
    xn_array(a,:) = xn(floor(1+(N_new*(a-1))):floor(N/Nrecs+(N_new*(a-1)))).*window;
%     t = (0:1:length(xn_array)-1)/fs; % Verify the signal exists and is
%     good
%     plot(t,xn_array);
    [Gxx(a,:),~,~,f_Gxx] = MyPSDX(xn_array(a,:),fs);
end
Gxx_avg = sum(Gxx,1)./Nrecs;
% RMS = sqrt(sum(Gxx_avg).*df);
% disp(['The RMS of signal: ', num2str(RMS)]);
% 
% RMS = sqrt(max(Gxx_avg).*df);
% disp(['The RMS of sine wave single: ', num2str(RMS)]);

end

function [Gxx,Sxx,f_Sxx,f_Gxx] = MyPSDX(x,Fs)
% [Gxx,Sxx,f] = MyPSDX(x,Fs)
% Inputs:
% x  = signal
% Fs = Sampling Rate
% Outputs:
% Gxx   = Single Sided Power Spectral Density
% Sxx   = Double Sided Power Spectral Density (Parsevels)
% f_Sxx = Frequency Double Sided
% f_Gxx = Frequency Single Sided
% Info:
% By: Matthew Luu
% Last Edit: 10/22/2020

% Begin Code:
    dt = 1/Fs;
    Xm = fft(x)*dt;
    N  = length(Xm);
    df = Fs/N;
    if rem(N,2) == 0
        % even number of samples.
        f_Sxx = (0:1:N-1)*df;
        Sxx = (abs(Xm).^2) * df;
        length(Sxx);
        Gxx = [Sxx(1),2*Sxx(2:N/2),Sxx((N/2)+1)]; 
        Sxx = fftshift(Sxx);
        f_Gxx = f_Sxx(1:(N/2)+1);
        f_Sxx = Fs*(floor(N/-2):floor(-1+N/2))/N;
    else
        % odd number of samples.
        f_Sxx = (0:1:N-1)*df;
        Sxx = (abs(Xm).^2) * df;
        Gxx = [Sxx(1),2*Sxx(2:floor(N/2)),Sxx(floor(N/2)+1)]; 
        Sxx = fftshift(Sxx);
        f_Gxx = f_Sxx(1:floor(N/2)+1);
        f_Sxx = Fs*(floor((N-1)/-2):(floor(N-1)/2))/N;
    end    
end

