clc
clear

% Low frequency approximation code for plate output theory test cases work
% compared to lecture and Wallace notes, think Im good here with number 1
 
% Inputs
a = 1;
b = 1;
m = 1;
n = 1;
k = 0.1:0.1:1000;

% Function
[TT,gamma] = low_freq_plate_prop(a,b,m,n,k);

% Plotting
loglog(gamma,TT);
grid on;
xlim([0.03 3]);
ylim([10^-5 4]);

%% 
function [TT,gamma] = low_freq_plate_prop(a,b,m,n,k)
% TT = low_freq_plate_prop(a,b,m,n,k)
% Inputs:
% a = input dimension in meter x-axis (m)
% b = input dimension in meter y-axis (n)
% m = modal number m
% n = modal number n
% k = wavenumber (w/c)
% Outputs:
% TT    = solution for low frequency approximation radiation efficiency
% gamma = k/kmn
% By: Matthew Luu
% Last Edit: 10/14/2021
% Info: Computes low frequency radiation efficiency approximation using
% Wallace's equation 17 - 19 based on m an n even or odd

    % Get kmn
    kmn = ((m*pi/a)^2 + (n*pi/b)^2);
    gamma = k./kmn;
    
    for ii = 1:length(gamma)
        if rem(m,2) == 0 && rem(n,2) == 0 % check even or odd
            choice = 19;% eqn 19
            T1  = (2*m*n*pi./15);
            T2  = (((a*n)./(m*b)) + ((m*b)./(a*n)));
            TT1 = T1.*(T2.^3).*gamma(ii).^6;

            T3  = (((1 - 24/((m*pi)^2))*(a/b)) + (1-(24./(n*pi)^2))*(b/a));
            T4  = T2*(5*m*n*pi/64);
            TT2  = 1 - T3.*T4.*gamma(ii).^2;

            TT(ii) = TT1 .*(a/b).* TT2; 
        elseif (rem(m,1) == 0 && rem(n,2) == 0)
            choice = 18; % eqn 18
            T1  = (8./(3*pi^3));
            T2  = (((a*n)./(m*b)) + ((m*b)./(a*n)));
            TT1 = T1.*(T2.^2).*gamma(ii).^4;

            T3  = (((1 - 8/((m*pi)^2))*(a/b)) + (1-(24./(n*pi)^2))*(b/a));
            T4  = T2*(m*n*pi/20);
            TT2  = 1 - T3.*T4.*gamma(ii).^2;

            TT(ii) = TT1 .*(a/b).* TT2;
            
        elseif (rem(m,2) == 0 && rem(n,1) ==0)
            choice = 18; % eqn 18
            T1  = (8./(3*pi^3));
            T2  = (((b*m)./(n*a)) + ((n*a)./(b*m)));
            TT1 = T1.*(T2.^2).*gamma(ii).^4;

            T3  = (((1 - 8/((n*pi)^2))*(b/a)) + (1-(24./(m*pi)^2))*(a/b));
            T4  = T2*(m*n*pi/20);
            TT2  = 1 - T3.*T4.*gamma(ii).^2;

            TT(ii) = TT1 .*(b/a).* TT2;

        else
            choice = 17; % eqn 17
            T1  = (32./(m*n*pi^3));
            T2  = (((a*n)./(m*b)) + ((m*b)./(a*n)));
            TT1 = T1.*T2.*gamma(ii).^2;

            T3  = (((1 - 8/((m*pi)^2))*(a/b)) + (1-(8./(n*pi)^2))*(b/a));
            T4  = T2*(m*n*pi/12);
            TT2  = 1 - T3.*T4.*gamma(ii).^2;

            TT(ii) = TT1 .* TT2;

        end
    end
    disp(['Equation: ',num2str(choice), ' m = ',num2str(m), ' n = ',num2str(n)]);
end