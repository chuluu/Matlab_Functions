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