function y_rms = MyRMS(y,N)
% y_rms = My_RMS(y)
% Inputs:
% y = any signal periodic
% N = length of signal
% Outputs:
% y_rms = root mean square value of y time signal
% Info: 
% By: Matthew Luu
% Last Edit: 9/18/20
% finds rms of signal


% Begin Code:
    y_Sqr  = y.^2;
    y_rm   = sum(y_Sqr)/N;
    y_rms  = sqrt(y_rm);
end