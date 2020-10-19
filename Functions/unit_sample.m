function [dn, n] = unit_sample(number_of_samples)
%Inputs: Number of Samples for unit sample
%Outputs: dn = unit sample at 0, n = index for plotting
zero_dn = zeros(1,(number_of_samples-1));
dn = (1/number_of_samples)*[number_of_samples, zero_dn]; %Set unit sample to 1 amplitude
n = 0:1:(number_of_samples-1);
end
