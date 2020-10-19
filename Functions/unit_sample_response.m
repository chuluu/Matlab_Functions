function [hn, n]=unit_sample_response(Bk, Ak, num_samples, figure_num)
% This function will take in Ak, Bk, sample number and figure numbers to
% output unit sample response and the index. This will also graph the
% functions with dots. 
[dn ,n] = unit_sample(num_samples);
hn = filter(Bk, Ak, dn);
figure(figure_num); stem(n,hn,'.','Linewidth',2);
title('Unit Sample Response'); xlabel('Index'); ylabel('Magnitude');
end