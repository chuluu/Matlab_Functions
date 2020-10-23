function [Gxx_avg,f_Gxx] = MyAvgGxx(xn,fs,Nrecs)
% [Gxx_avg,f_Gxx] = MyAvgGxx(xn,fs,Nrecs)
% Inputs:
% xn         = Input Vector Time Array
% fs         = Sampling Rate
% Nrecs      = Number of records desired
% Outputs:
% Gxx_Avg    = Average Gxx from the operation
% f_Gxx      = Frequency of the Gxx average
% Info:
% By: Matthew Luu
% Last Edit: 9/20/2020
% Finds average Gxx of signal given number of records

% Begin Code:
N = length(xn);
N_new = N/Nrecs;
df = fs/N_new;
xn_array = zeros(Nrecs,N_new);
for a = 1:Nrecs
    xn_array(a,:) = xn(floor(1+(N_new*(a-1))):floor(N/Nrecs+(N_new*(a-1))));
    [Gxx(a,:),Sxx,f,f_Gxx] = MyPSDX(xn_array(a,:),fs);
end
Gxx_avg = sum(Gxx,1)./Nrecs;
RMS = sqrt(sum(Gxx_avg).*df);
disp(['The RMS of signal: ', num2str(RMS)]);

RMS = sqrt(max(Gxx_avg).*df);
disp(['The RMS of sine wave single: ', num2str(RMS)]);

end


% plot(f(N_new/2:end),10*log10(Gxx_avg))
% xlim([0 max(f(N_new/2:end))]);