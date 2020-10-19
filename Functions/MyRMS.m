function y_rms = MyRMS(y,N)
    % y_rms = My_RMS(y)
    % Inputs:
    % y = any signal periodic
    % N = length of signal
    % Outputs:
    % y_rms = root mean square value of y time signal
    y_Sqr  = y.^2;
    y_rm   = sum(y_Sqr)/N;
    y_rms  = sqrt(y_rm);
end