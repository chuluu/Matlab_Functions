function [bb, aa] = Constant_Q_Filter(Q, f0, fs, fig_num, limiter, N)
% Inputs:
% Q  = Quality factor of Q = f0/HPBW
% f0 = Center Frequency
% fs = Sampling rate
% fig_num = figure num for tested filter if needed
% Output
% bb = zeros, numerator coefficients
% aa = poles, denomenator coefficients
% if fig_num, then plots the response of the filter
% Info:
% By: Matthew Luu
% Supplemental: Dr. Gabrielsons bilinear function
% Last Edit: 11/1/2020
% This functionc creates a constant Q filter based on the continuous filter
% and the bilinear transform. Frequency warping is applied to achieve the
% correct filter

    % Begin Code:
    f0w = tan((pi*f0)/fs)/(pi/fs); 

    w0 = 2*pi*f0w;
    num_s_coefficients = [w0/Q, 0];
    den_s_coefficients = [1, w0/Q, w0^2]; 
    [bb, aa] = MyDSP.bilinear_xform(num_s_coefficients, den_s_coefficients, fs);
    if nargin > 3
        if nargin > 4
            MyDSP.plot_filter_simple_Ak_BK(aa,bb,N,fs,fig_num,limiter);
        else
            MyDSP.plot_filter_simple_Ak_BK(aa,bb,N,fs,fig_num);
        end
    end
end