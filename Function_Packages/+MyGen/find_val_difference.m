function [val,loc] = find_val_difference(fnc,val)
% [val,loc] = find_val_difference(fnc,val)
% Inputs:
% fnc = function data array to find value in
% val = The value desired
% Outputs:
% val = value of the found value
% loc = sample point of value location
% Last Edit: 4/6/2021
% By: Matthew Luu

    for a = 1:length(fnc)
        diff(a) = abs(fnc(a) - val);
    end
    [val,loc] = min(diff);
end