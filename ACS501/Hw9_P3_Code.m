%%
clc
clear

[filepath,~,~] = fileparts(pwd);
newpath = [filepath,'\Function_Packages'];
userpath(newpath);
Intro();

%%
kL   = 0:0.001:15;
E    = 19.5*10^10; % Pa Youngs
s    = 8.34*10^8;  % N/m spring stiffness
L    = 0.75;     % m bar length
d    = 0.01;     % m diameter
a    = d/2;      % m radius
rho  = 7700;     % kg/m3 density
S    = pi*(a^2); % Area cross sectional
m    = 0.5;      % kg
c = sqrt(E/rho);
mbar = S*rho*L; % kg

rt_side = tan(kL);
lt_side = ((s*L)/(E*S)).*(1./kL) - (m/mbar).*kL;
sol = lt_side - rt_side;
plot(kL,rt_side,'Linewidth',1.6); hold on;
plot(kL,lt_side,'Linewidth',1.6); hold on;

kL_root = MyGen.MyTranscendental_Solver(kL,sol,100)
[val,Idx] = find(kL == kL_root);
for a = 1:length(Idx)
    rt_root  = rt_side(Idx(a));
    plot(kL_root(a),rt_root,'--o','Linewidth',1.6);
end
ylim([-100 100]);
xlabel('kL','Fontsize',14);
ylabel('Amplitude','Fontsize',14);
grid on;

%% Part D/E:
clc
wo = sqrt(s/m);
fo = wo/(2*pi);
disp(['Frequency of mass-spring alone: ',num2str(fo),' Hz']);

k_root = kL_root./L;
w_root = k_root.*c;
f_root = w_root/(2*pi);
round(f_root)


%%
% syms kL
% m = 1;
% mbar = 2;
% rt_side = tan(kL);
% lt_side = (1./kL) - (m/mbar).*kL;
% s = lt_side - rt_side;
% 
% x0 = fzero(@(kL) (1./kL) - (m/mbar).*kL - tan(kL), 4)
