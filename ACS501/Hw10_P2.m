clc
clear

% Aluminum blackstock
E_Al   = 71*10^9;
v_Al   = 0.33;
rho_Al = 2700;


% Wood
E_wood = 12.3*10^9;
v_wood = 0.35;
rho_wood = 720;

w = 3*10^-2;
h = 2*10^-2;
t = 1.5*10^-3;

a = w;
b = h;

w_in = w-(2*t);
h_in = h-(2*t);

L = 130.6*10^-2;

Ip_solid = polar_mom_rect(w,h);
Ip_hallow_inner = polar_mom_rect(w_in,h_in);
Ip_hallow_outer = polar_mom_rect(w,h);
Ip_hallow = Ip_hallow_outer-Ip_hallow_inner;

k_solid = ((w*h^3)/16) * ((16/3) - 3.36*(h/w)*(1 - ((h^4)/(12*w^4))));
k_hallow = (2*t*t*((a-t)^2)*((b-t)^2))/((a*t) + (b*t) - (t^2) - (t^2));

G_solid   = E_wood/(2*(1+v_wood));
G_hallow  = E_Al/(2*(1+v_Al));

cT_solid  = sqrt(k_solid/Ip_solid)*sqrt(G_solid/rho_wood);
cT_hallow = sqrt(k_hallow/Ip_hallow)*sqrt(G_hallow/rho_Al);

n = [1,2,3,4];
fn_solid  = (n.*cT_solid./(2.*L));
fn_hallow = (n.*cT_hallow./(2.*L));

disp(['Frequency Solid Oak: ',num2str(fn_solid),' Hz']);
disp(['Frequency Hollow Aluminum: ',num2str(fn_hallow),' Hz']);

function Ip = polar_mom_rect(w,h)
    Ip = (1/12)*w*h*((w^2) + (h^2));
end