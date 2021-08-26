function [X,F] = MyDTFT(x,n)
% [X,F] = MyDTFT(x,n)
% Inputs:
% x = input signal
% n = number of points or bins
% Outputs:
% X = linear spectrumed signal
% F = frequency array of bins
% Info: 
% By: Matthew Luu
% Last Edit: 11/19/2018

% Begin Code:
    F = linspace(-0.5,0.5,length(n));
    basis = exp(-1i*2*pi*(n)'*F); %' Transposes and it outer multiplies
    X = x*basis;
end
