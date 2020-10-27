function [x,y] = PlotCOMSOLXY(name)
% [x,y] = PlotCOMSOLXY(name)
% Inputs:
% Outputs:
% x = x array of data
% y = y array of data
% Info:
% By: Matthew Luu
% Last Edit: 10/27/2020
% Plots COMSOL Data for XY only, no parametrics

% Begin Code:
    M = readtable(name);
    A = table2array(M);
    Xlab = A{4,1};
    Ylab = A{4,2};
    Data = readmatrix(name);

    [m,n] = size(Data);
    
    if (m > 3)
        x = Data(:,1);
        y = Data(:,2);
    else
        x = Data(1,:);
        y = Data(2,:);        
    end
    
    plot(x,y,'Linewidth',1.4);
    grid on;
    xlim([min(x) max(x)]);
    xlabel(Xlab,'Fontsize',12);
    ylabel(Ylab,'Fontsize',12);
end