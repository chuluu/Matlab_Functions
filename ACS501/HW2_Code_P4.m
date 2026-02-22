%% Inputs 
clc
clear

n = 45;
d = 0.0015; % m
D = 0.005;  % m
v = [0.28, 0.37]; % Steel, Brass (Poisson)
E = [195 * 10^9, 104 * 10^9]; % Steel, Brass (Pa)
rho_ball = 2300; % kg/m3
rho_f    = 1000; % kg/m3
r        = 0.03; % m
S        = pi*(r^2);
Cd       = 1.5;
X        = 0.02; % Max displacement
eta(1)   = 0.0003;
eta(2)   = 0.001;
c        = 1500;

%% Effective Total Spring (a)
for a = 1:length(E)
    G(a)  = E(a)/(2*(1+v(a)));
    s(a) = (G(a)*(d^4))/(8*(D^3)*n); % N/m
end

% Series Spring
s_eff = s(1) + s(2);   % N/m

disp(['Spring 1 (Steel): ', num2str(s(1))]);
disp(['Spring 2 (Brass): ', num2str(s(2))]);
disp(['Spring eff (effective): ', num2str(s_eff)]);

%% Effective Total Mass (b)
V        = (4/3)*pi*r^3;
M_ball   = V*rho_ball;
M_sp1    = 10.6*10^-3; % kg
M_sp2    = 9.6*10^-3;  % kg
Mrad     = 0.5*rho_f*((4/3)*pi*(r^3));  % Oscillating mass spher
m_eff = M_ball + 1/3*(M_sp1 + M_sp2) + Mrad;
disp(['Effective Mass: ', num2str(m_eff),' kg']);

%% Natural Frequency (C)
f_o = (1/(2*pi))*sqrt(s_eff/m_eff);
disp(['Natural Frequency: ', num2str(f_o),' Hz']);
w_o = 2*pi*f_o;

%% Damping Ratio (D)
% Aerodynamic drag
% Structural damping
% Radiation damping
k = 2*pi*f_o/c;
Req_Aero = (4/(3*pi))*Cd*rho_f*S*w_o*X;
Req_Stru = (eta(2) - eta(1))/w_o;
Req_Radi = rho_f*c*((4*pi*(r^2))/3)*((k*r)^4)/(4+((k*r)^4));

Req = Req_Aero + Req_Stru + Req_Radi;
B   = Req/(2*m_eff);

%% Determine Damped Frequency (e)
wd = sqrt((w_o^2) - (B^2));
fd = wd/(2*pi);
disp(['Damped Frequency: ', num2str(fd),' Hz']);
disp(['Damping Rate: ', num2str(B),' Hz']);
