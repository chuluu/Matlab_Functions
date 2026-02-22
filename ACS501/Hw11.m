%% Intro
% Test Case for halfpower function
clc
clear

[filepath,~,~] = fileparts(pwd);
newpath = [filepath,'\Function_Packages'];
userpath(newpath);
Intro();
%%

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

S_solid  = w*h;
S_hallow = w*h - w_in*h_in;

I_hallow = (w*(h^3) - w_in*(h_in^3))/12;

k_solid  = h/sqrt(12);
k_hallow = sqrt(I_hallow/S_hallow);

n = [3.011^2,5^2,7^2,9^2];
fn_solid  = ((pi.*k_solid)./(8*L^2)).*sqrt(E_wood/rho_wood).*n;
fn_hallow = ((pi.*k_hallow)./(8*L^2)).*sqrt(E_Al/rho_Al).*n;

disp(['Flexural Frequency Solid Oak: ',num2str(fn_solid),' Hz']);
disp(['Flexural Frequency Hollow Aluminum: ',num2str(fn_hallow),' Hz']);

%%

wLv = 0:0.05:15;
num = tan(wLv);
den = tanh(wLv);

y = den-num;
n = [1,2,3,4];
spacing = (3*n + 1);

plot(wLv/(pi/4),num,'Linewidth',1.4); hold on;
plot(wLv/(pi/4),den,'Linewidth',1.4); 
ylim([-2 2]);
grid on;
xlabel('wL/v/(\pi/4) term');
ylabel('Amplitude');

%% P3
clear
clc

E = 195*10^9;
rho = 7700;
v = 0.30;
M = 0.193;
L = 1.15;
a = 7.5*10^-3; % Outer radius
b = 5.5*10^-3; % Inner radius

mbeam = rho*L*pi*(a^2-b^2);
I = (pi/4)*((a^4) - (b^4));
s = (3*E*I)/(L^3);
m = M + 0.24*mbeam;

f = sqrt(s/m)/(2*pi)

%%
clc
clear

% Part C:
wLv = 0:0.01:12;
L  = 1.15;
rho = 7700;
E  = 195*10^9;
a  = 7.5*10^-3;
b  = 5.5*10^-3;
S  = pi*(a^2-b^2);
I = (pi/4)*((a^4) - (b^4));

k  = sqrt(I/S);
mv = rho*S*L;
cl = sqrt(E/rho);
m  = 0.193;

poisson = 0.30;

y = ((1./(wLv)) .* (1+cos(wLv).*cosh(wLv))./(-sinh(wLv).*cos(wLv) + sin(wLv).*cosh(wLv))) - m/mv;
wLv_root = MyGen.MyTranscendental_Solver(wLv,y,100);%,initial_del,del_step)

w = (wLv_root.*sqrt(k*cl)./L).^2;
f = (w/(2*pi));
w = (wLv.*sqrt(k*cl)./L).^2;
den = m/mv;
num = ((1./(wLv)) .* (1+cos(wLv).*cosh(wLv))./(-sinh(wLv).*cos(wLv) + sin(wLv).*cosh(wLv)));
f_real = [f(1), f(3), f(6), f(9)];
figure(123);
plot(w/(2*pi),den.*ones(1,length(wLv)),'Linewidth',1.4);hold on;
plot(w/(2*pi),num,'Linewidth',1.4);
ylim([-2 2]);
xlim([0 max(w/(2*pi))]);
xlabel('Frequency (Hz)');
ylabel('Magnitude');
grid on;

for a = 1:length(f_real)
    plot(f_real(a),m/mv,'o','Linewidth',1.4);
end

%
figure(321);
x = 0:0.01:L;
for a = 1:length(f_real)
    v = sqrt(cl*k*2*pi*f_real(a));
    de = 2*pi*f_real(a).*x/v;
    deL = 2*pi*f_real(a)*L/v;
    const = ((cosh(deL) + cos(deL))/(sinh(deL) + sin(deL)));
    y_x = 1.*(cosh(de) - cos(de)) - const.*(sinh(de) - sin(de));

    subplot(4,1,a); plot(x,y_x,'Linewidth',1.4); grid on;
    xlim([0 L]);
    MyGen.title_plots(['f_n = ',num2str(f_real(a)),' Hz'],'Position (m)','Amplitude',10);
end