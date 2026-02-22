%%
clc
clear

[filepath,~,~] = fileparts(pwd);
newpath = [filepath,'\Function_Packages'];
userpath(newpath);
Intro();

%%
kL   = 0:0.00001:2;
S    = 1.0*10^-5;
rho  = 7700;       % kg/m3
E    = 19.5*10^10; % Pa
m    = 2.0;
c    = sqrt(E/rho);
L    = 1.0;        % m
mbar = S*rho*L;    % kg

rt_side = tan(kL);
lt_side = (mbar/m).*(1./kL);
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
clc
k_root = kL_root./L;
w_root = k_root.*c;
f_root = w_root/(2*pi);
disp(['The Fundamental Frequency: ', num2str(f_root(1)), ' Hz']);


%%
% syms kL
% m = 1;
% mbar = 2;
% rt_side = tan(kL);
% lt_side = (1./kL) - (m/mbar).*kL;
% s = lt_side - rt_side;
% 
% x0 = fzero(@(kL) (1./kL) - (m/mbar).*kL - tan(kL), 4)
