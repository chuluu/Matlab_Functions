clc
clear

ppk     = 2.6; % MPa
alphadB = 0.3;  % dB/cm/MHz
freqMHz = 1.7;  % MHz
x       = 4;    % cm
rho     = 1060;
c       = 1540;
%
alpha   = alphadB*(1/8.686)*freqMHz; % Np/cm
pmeg    = ppk*exp(-alpha*x);

disp(['Soft Transmitted Pressure: ',num2str(pmeg),' MPa']);

p_reg = pmeg*10^6;
I_reg = (p_reg^2)/(2*rho*c);
disp(['Soft Average Intensity: ',num2str(I_reg*10^-6),' MW/m^2']);

%%
clc
clear
ppk     = 2.6; % MPa
freqMHz = 1.7;  % MHz
x       = 4;    % cm
alphadB = 8.7;  % dB/cm/MHz
rho     = 1908;
c       = 3515;

%
alpha   = alphadB*(1/8.686)*freqMHz; % Np/cm
pmeg    = ppk*exp(-alpha*x);

disp(['Bone Transmitted Pressure: ',num2str(pmeg),' MPa']);

p_reg = pmeg*10^6;
I_reg = (p_reg^2)/(2*rho*c);
disp(['Bone Average Intensity: ',num2str(I_reg*10^-6),' MW/m^2']);


