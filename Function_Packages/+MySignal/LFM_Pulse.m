function [xn,t] = LFM_Pulse(f1,f2,Tp,fs)
% Idx = find_val(fnc,val,del_start,iteration_val)
% Inputs:
% f1   = Initial Frequency starts at t = 0 
% f2   = End Frequency ends at t = Tp
% Tp   =  time f2 ends
% fs   = Sampling Rate
% Outputs:
% xn   = Index in the array of fnc that found val
% t    = time array accosiating with the pulse
% Info:
% By: Matthew Luu
% Last Edit: 10/25/2020
% Function to generate an LFM pulse using Gabrielson's derivation notes.
% Derive the A and B coefficients for the phase term within a sine term, in
% this case, it is for a linear pulse specifically

% Begin Code
    N   = fs*Tp;
    dt  = 1/fs;
    t   = (0:1:N-1)*dt;
    A   = f1;
    B   = (f2-f1)/(2*Tp);
    xn  = sin(2*pi*(A.*t + B.*(t.^2)));
end