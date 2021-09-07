function [FRF_mag1,FRF_mag2,FRF_ang1,FRF_ang2,f_Gxx] = MyAvgFRF(xn,yn,fs,Nrecs,win)
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
yn_array = zeros(Nrecs,N_new);

window = win.';
L_window = length(window);
ms = sum(window.*window)/L_window;
window = window/sqrt(ms);

for a = 1:Nrecs
    xn_array(a,:) = xn(floor(1+(N_new*(a-1))):floor(N/Nrecs+(N_new*(a-1)))).*window;
    [Gxx(a,:),f_Gxx] = MyDSP.MyFFT(xn_array(a,:),fs,'n');
    
    yn_array(a,:) = yn(floor(1+(N_new*(a-1))):floor(N/Nrecs+(N_new*(a-1)))).*window;
    [Gyy(a,:),f_Gyy] = MyDSP.MyFFT(yn_array(a,:),fs,'n');

    mag1(a,:) = abs(Gyy(a,:))./abs(Gxx(a,:));
    mag2(a,:) = abs(Gxx(a,:))./abs(Gxx(a,:));
    ang1(a,:) = angle(Gyy(a,:)) - angle(Gxx(a,:));
    ang2(a,:) = angle(Gxx(a,:)) - angle(Gxx(a,:));
end

FRF_mag1 = sum(mag1,1)./Nrecs;
FRF_mag2 = sum(mag2,1)./Nrecs;
FRF_ang1 = sum(ang1,1)./Nrecs;
FRF_ang2 = sum(ang2,1)./Nrecs;

end


% plot(f(N_new/2:end),10*log10(Gxx_avg))
% xlim([0 max(f(N_new/2:end))]);