function [bb, aa] = Exponential_Avg_Filter(Tc, fs, fig_num, limiter, N)
% [bb, aa] = Exponential_Avg_Filter(Tc, fs, fig_num, limiter, N)
% Inputs:
% Tc = Time constant
% fs = Sampling rate
% fig_num = figure num for tested filter if needed
% limiter = xlim for plotting
% N = number of points for the system
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
    alpha = 1/(fs*Tc);
    bb = [0,alpha];
    aa = [1,alpha-1];
    if nargin > 2
        if nargin > 3
            MyDSP.plot_filter_simple_Ak_BK(aa,bb,N,fs,fig_num,limiter);
        else
            N = 10000;
            MyDSP.plot_filter_simple_Ak_BK(aa,bb,N,fs,fig_num);
        end
    end
end