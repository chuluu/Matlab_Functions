function plot_filter_simple_Ak_BK(aa,bb,N,fs,fig_num,limiter)
% Inputs:
% aa = poles, denomenator coefficients
% bb = zeros, numerator coefficients
% N  = Number of unit sample points
% fs = Sampling rate
% fig_num = figure num for tested filter if needed
% limiter = [x1 x2] xlim limiter in this form
% Output:
% figure for the plot display
% Info:
% By: Matthew Luu
% Last Edit: 11/1/2020
% Plots the unit sample response of a filter in simple way

    % Begin Code
    if nargin < 6
        limiter = [0 fs/2];
    end
    
    figure(fig_num);
    [dn, ~] = MyDSP.unit_sample(N,'n');
    h = filter(bb,aa,dn);
    [H,f] = MyDSP.MyFFT(h,fs,'n',0);
    subplot(2,1,1); plot(f(1:end/2),abs(H(1:end/2)),'Linewidth',1.4); hold on;
    title('Filter Magnitude Response','Fontsize',12);
    xlabel('Frequency (Hz)','Fontsize',12);
    ylabel('Magnitude (WU)','Fontsize',12);
    xlim(limiter);
    grid on;
    figure(fig_num);
    subplot(2,1,2); plot(f(1:end/2),angle(H(1:end/2)),'Linewidth',1.4);
    title('Filter Phase Response','Fontsize',12);
    xlabel('Frequency (Hz)','Fontsize',12);
    ylabel('Phase (rad)','Fontsize',12);
    xlim(limiter);
    grid on;
    
    figure(fig_num+2);
    t = (0:1:N-1)/fs;
    plot(t,h,'Linewidth',1.4);
    title('Filter Unit Sample Response','Fontsize',12);
    xlabel('Time (s)','Fontsize',12);
    ylabel('Magnitude (WU)','Fontsize',12);
    grid on;
end