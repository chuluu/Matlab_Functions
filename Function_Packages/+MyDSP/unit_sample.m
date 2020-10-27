function [dn, n] = unit_sample(number_of_samples)
% [dn, n] = unit_sample(number_of_samples)
% Inputs: 
% number_of_samples =  Samples for unit sample
% Outputs: 
% dn = unit sample at 0, n = index for plotting
% Info:
% By: Matthew Luu
% Last edit: 3/18/19
% obtains a unit sample function

zero_dn = zeros(1,(number_of_samples-1));
dn = (1/number_of_samples)*[number_of_samples, zero_dn]; %Set unit sample to 1 amplitude
n = 0:1:(number_of_samples-1);
end
