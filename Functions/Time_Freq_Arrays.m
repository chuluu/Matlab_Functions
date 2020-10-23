function [dt,df,t,freq] = Time_Freq_Arrays(fs,N)
% [dt,df,t,freq] = Time_Freq_Arrays(fs,N)
% Inputs:
% fs   = sampling rate
% N    = number of samples
% Outputs:
% dt   = time difference
% df   = frequency difference
% t    = time array
% freq = frequency array
% Info:
% By: Matthew Luu
% Last edit: 10/18/20
% Time and frequency arrays by using fs and N pts

% Begin Code:
df = fs/N;
dt = 1/fs;

% Array Generation
t  = (0:N-1)*dt;
freq = (0:N-1)*df;
end