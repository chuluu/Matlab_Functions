function sigma = Myvar(X)
% sigma = Myvar(X)
% Inputs:
% X: input array
% Outputs:
% sigma: sigma value for variation
% Info:
% By: Matthew Luu
% Last edit: 5/19/2020
% Takes the variation of the X array function

% Begin Code:
    [col, row] = size(X);
    for a = 1:row
        sigma(a) = ((sum(X(:,a).^2)) - (sum(X(:,a))^2)/col)/(col - 1);
    end
end




