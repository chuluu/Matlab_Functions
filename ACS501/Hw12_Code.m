clc
clear
%% P1
clc
% Steel: from blackstock
E   = 195*10^9;
v   = 0.28;
rho = 7700;

% Dimensions:
Lx = 15*10^-2;
Ly = 12*10^-2;
h  = 3.0*10^-3;

% Part a:
D  = ((h^3)*E)/(12*(1-v^2));
m  = 2;
n  = 2; 
const = sqrt(D/(rho*h));
modes = [1,2,3,4];
fmn = (1/(2*pi)) * const * (((m*pi/Lx)^2) + ((n*pi/Ly)^2));
disp(['Frequency: ',num2str(fmn)]);
% Part b:
m  = m+1;
n  = n+1;

a  = Lx;
b  = Ly;

Gx = m-1;
Hx = (m-1)^2;
Jx = (m-1)^2;

Gy = n-1;
Hy = (n-1)^2;
Jy = (n-1)^2;

term1 = ((pi^4)/(a^4));
term2 = (E*h^2)/(12*rho*(1-v^2));
term3 = Gx^4 + (Gy^4)*(a/b)^4 + (2*(a/b)^2)*(v*Hx*Hy + (1-v)*Jx*Jy);

w     = sqrt(term1*term2*term3);
disp(['Frequency: ',num2str(w/(2*pi))]);

%% P2
% Steel: from blackstock
E   = 195*10^9;
v   = 0.28;
rho = 7700;

% Dimensions:
Lx = 6.5*10^-2;
Ly = 4.5*10^-2;
h  = 2.0*10^-3;

% Part a:
D  = ((h^3)*E)/(12*(1-v^2));
m  = 1;
n  = 1;
const = sqrt(D/(rho*h));
fmn = (1/(2*pi)) * const * (((m*pi/Lx)^2) + ((n*pi/Ly)^2));

% Part b:
Area = Lx*Ly;
a    = sqrt(Area/pi);
h    = 2.0*10^-3;
J01  = 3.2;
kp   = J01/a;
w    = sqrt((D*kp^4)/(rho*h));
f    = w/(2*pi);
T    = 1/f;

tdwell = 0.75*T;

disp(['f rect: ',num2str(fmn), ' Hz']);
disp(['f circular: ',num2str(f), ' Hz']);
disp(['tdwell: ',num2str(tdwell*10^3), ' ms']);


