%% Intro
clc
clear
[filepath,~,~] = fileparts(pwd);
newpath = [filepath,'\Function_Packages'];
addpath(newpath);
Intro();

%% Input
a = 0.5;
b = 0.4;
h = 6.35*10^-3;

% Material Properties
E = 68.9*10^9;
rho = 2700;
c = sqrt(E/rho);
v = 0.33;
K = 1;                         % Shear Correction Factor

%% Math Algorithm Stuff
fmn_thick_cell = thick_mode_resonances(a,b,h,E,rho,v,K,5); % Correct
ii = 25;
m  = fmn_thick_cell{2,ii}(1);
n  = fmn_thick_cell{2,ii}(2);
fo = fmn_thick_cell{3,ii};
co = 343;

f  = 0:1:4000;
w  = 2*pi.*f;
k  = w./co;

[TT,gamma] = low_freq_plate_prop(a,b,m,n,k);

loglog(gamma,TT);
disp(['Res Freq: ',num2str(fo)]);
%%
function fmn_thick_cell = thick_mode_resonances(a,b,h,E,rho,v,K,mode_num)
    %% Calculated Constants
    G = E./(2*(1+v));              % Shear Modulus
    D = (E*(h.^3))./(12*(1-v.^2)); % Flexural Rigitidy
    I = (h^3)/12;                  % Plate moment of intertia per unit width

    %% Speed of Plate Sound
    f  = 0:1:4*10^4;
    w  = 2*pi*f;

    T1 = D./(K*h*G);
    T2 = I./h;
    T3 = D./(rho*h);

    T1sq = sqrt(((T1 - T2).^2).*(w.^4) + 4.*T3.*(w.^2));
    T2sq = (w.^2)*(T1 + T2);
    Num  = T1sq - T2sq;
    Den  = 2.*(1-(w.^2).*((I.*rho)./(K.*h.*G)));
    Cb = sqrt(Num./Den); % Generate sound speed based on the equation in lec3

    X  = ((D./(rho.*h)).*(w.^2));
    Cblow = nthroot(X,4); % calculate low frequency speed limit
    Cbhigh = sqrt(K.*G./rho); % calculate high frequency speed limit

    %% Thick Plate Theory Resonances
    z = 1;
    zz = 1;
    for m = 1:1:mode_num
        %z = 1;
        for n = 1:1:mode_num
            kx(z) = ((m.*pi)./a);
            ky(z) = ((n.*pi)./b);
            kmn(z) = sqrt((kx(z).^2) + (ky(z).^2));
            z = z+1;
            modes{z} = [m,n];
        end
        zz = zz+1;
    end

    %figure(2);
    kb = w./Cb;
    %plot(f,kb,'Linewidth',1.4); hold on;
    for i = 1:length(modes)-1
        %plot(f,kmn(i).*ones(1,length(f)),'Linewidth',1.4); hold on;
        [val(i),loc(i)] = MyGen.find_val_difference(kb,kmn(i));
        %plot(f(loc(i)),kb(loc(i)),'o','Linewidth',2);
    end
%     ylabel('Wavenumber');
%     xlabel('Frequency (Hz)');

    fmn_thick = f(loc);
    for ii = 1:length(fmn_thick)
        fmn_thick_cell{1,ii} = ['m=',num2str(modes{ii+1}(1)),' n=',num2str(modes{ii+1}(2))];
        fmn_thick_cell{2,ii} = modes{ii+1};
        fmn_thick_cell{3,ii} = fmn_thick(ii);
    end
    %disp(fmn_thick_cell)
end


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
