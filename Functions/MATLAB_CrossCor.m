function [Fundamental_Frequency, xcorr_1, time_period] = MATLAB_CrossCor(x,fs)
% [mainlobe,mainlobe_ang_freq] = mainlobe_detector(Xn,w)
% Inputs:
% X    = cross corr function
% fs    = sampling rate
% Outputs:
% Fundamental_Frequency = the fundy freq of foiurier series
% xcorr_1 = xcorr result
% time_period = time shift 
% Info:
% By: Matthew Luu
% Last Edit: 1/17/2019
% find fundamentalf req of a signal

[xcorr_1,lag] = xcorr(x,x); %lag delay between two signals and maximums
time_period = lag.*(1/fs);

%Locates the maximum lobe and the second maxmium lobe
[M1, I1] = max(xcorr_1);
[A,first_min] = min(xcorr_1);
period_delete = I1 - first_min;
other_min = I1 + period_delete;

%Takes difference between the two lobes to find the fundamental frequency
if first_min < other_min
    seg = [xcorr_1(1:first_min-1).*1,xcorr_1(first_min:other_min).*0,xcorr_1(other_min+1:length(xcorr_1)).*1];
else
    seg = [xcorr_1(1:first_min-1).*1,xcorr_1(other_min:first_min).*0,xcorr_1(other_min+1:length(xcorr_1)).*1];
end

%Obtain Fundamental Frequency
xcorr_2 = xcorr_1 .* seg;
[M2, I2] = max(xcorr_2);
Fundamental_Period = abs(time_period(I2));
Fundamental_Frequency = 1/Fundamental_Period;

end
