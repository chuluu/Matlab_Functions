function P = SPL_to_Pressure(SPL)
% P = SPL_to_Pressure(SPL)
% Inputs:
% SPL = SPL dB value
% Outputs:
% P = pressure rms
% Info:
% By: Matthew Luu
% Last edit: 10/1/2020
% For ACS502 
    SPL = 20*log10(P/2*10^5);
    P = (10^(SPL/20))/(2*10^5);
end
