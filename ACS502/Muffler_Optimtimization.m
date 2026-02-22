%% Optimize design
clc
clear

% Inputs
d1  = 0.0127;
r1  = d1/2;
S1  = pi*(r1^2);
f   = 75;
dB_down = 9;
c = 343; 
val = 54;

% Design params
S2 = val*S1;
k  = (2*pi*f)/c;

% Equation for optimization
dB_condition = (10^(-dB_down/10));
area_condition = ((S1/S2) - (S2/S1))^2;
param = sqrt((4-4*dB_condition)/(dB_condition*(area_condition)*(k^2)));

% Check Condition
if (k*param) < 1/10
    disp(['Design Good']);
    disp(['Param: ',num2str(param),' m']);
    disp(['S2: ',num2str(S2),' m^2']);
    a2 = sqrt(S2/pi);
    disp(['a2: ',num2str(a2),' m']);
else
    disp(['Nahhh']);
end

% Double Check
l = param;
Tw = 4/(4+(area_condition*(k*l)^2));
TL = -10*log10(Tw);

%% 
% Double Check
f = 0:1:4000;
w = 2*pi*f;
k = w/c;
l = param;
B = sin(k.*l).^2;
Tw = abs(4./(4*(cos(k.*l).^2)+(area_condition.*B)));
TL = -10.*log10(Tw);
plot(f,TL);
xlabel(['Freq (Hz)'],'Fontsize',12);
ylabel(['TL (dB)'],'Fontsize',12);
ylim([0 max(TL)]);
%%
lam = 2*l;
freq = round(c/lam)
k_new = (2*pi*freq/c);
B = sin(k_new*l)^2;
Tw_new = abs(4./(4*(cos(k_new.*l).^2)+(area_condition.*B)))








