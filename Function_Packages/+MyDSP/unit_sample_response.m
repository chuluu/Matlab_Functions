function [hn, n]= unit_sample_response(Bk, Ak, num_samples, figure_num)
% 
% Inputs:
% Bk: Denomenator coefficients of z tranform function
% AK: Numerator coefficients of z transform function
% Outputs:
% hn: unit sample response
% n:  samples discrete world
% Info:
% By: Matthew Luu
% Last Edit: 3/19/2019
% This function will take in Ak, Bk, sample number and figure numbers to
% output unit sample response and the index. This will also graph the
% functions with dots. 

% Begin Code:
[dn ,n] = unit_sample(num_samples);
hn = filter(Bk, Ak, dn);
figure(figure_num); stem(n,hn,'.','Linewidth',2);
title('Unit Sample Response'); xlabel('Index'); ylabel('Magnitude');
end