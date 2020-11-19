function [dn, n] = unit_sample(number_of_samples,scale)
% [dn, n] = unit_sample(number_of_samples)
% Inputs: 
% number_of_samples =  Samples for unit sample
% scale = if 'y' then scale it, 'n' then don't
% Outputs: 
% dn = unit sample at 0, n = index for plotting
% Info:
% By: Matthew Luu
% Last edit: 11/1/2020
% obtains a unit sample function

    % begin code

    % defaults
    if nargin < 2
        scale = 'y'; 
    end

    zero_dn = zeros(1,(number_of_samples-1));
    if scale == 'y'
        dn = (1/number_of_samples)*[number_of_samples, zero_dn]; %Set unit sample to 1 amplitude
    else
        dn = [number_of_samples, zero_dn]; %Set unit sample to 1 amplitude
    end
    n = 0:1:(number_of_samples-1);

end
