%%
clc
clear

[filepath,~,~] = fileparts(pwd);
newpath = [filepath,'\Function_Packages'];
userpath(newpath);
Intro();

%%
kL   = 0:0.001:3;

% Set everything equal to 1 to focus on spring const changes
S    = 1;
E    = 1;    % Pa
rho  = 1;    % kg/m3
L    = 1.0;  % m
c    = sqrt(E/rho);

% We can vary and change this
a    = 1;
s    = [0.02,0.06,0.5,1]; % Spring constant
rt_side = -tan(kL);
plot(kL,rt_side,'Linewidth',1.6); hold on;

for b = 1:length(s)
    lt_side = ((E.*S)./(s(b).*L)).*kL;
    sol = lt_side - rt_side;
    plot(kL,lt_side,'Linewidth',1.6); hold on;
    ylim([-100 100]);
    xlabel('kL','Fontsize',14);
    ylabel('Amplitude','Fontsize',14);
    grid on;
end
legend('rt hand side','s = 0.01','s = 0.06','s = 0.5','s = 1.0');

% As stiffness increases, fundamental frequency increases, and kL term
% becomes more like a straight line at 0. which the eqation then becomes
% tan(kL) = 0! which is sin(kL)/cos(kL) which is sin(kL) = 0! so this is a
% fixed-fixed bar