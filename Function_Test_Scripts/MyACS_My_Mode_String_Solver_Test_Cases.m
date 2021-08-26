%% Intro
% Test Case for MyModeStringSolver

clc
clear
[filepath,~,~] = fileparts(pwd);
newpath = [filepath,'\Function_Packages'];
addpath(newpath);
Intro();

%%
T    = 100;
rho1 = 20;
rho2 = 20;
L    = 2.0;
w = 0:0.001:20;

w_real = MyACS.My_Mode_String_Solver(T,rho1,rho2,L,w,2);

%%
L = 1;
n = 3;
m = 5;
x = 0:0.01:L;
k = n*pi/L;
k = m*pi/(2*L);
y = -1i.*2*1.*sin(k.*x);
plot(x,imag(y),'Linewidth',1.6);
title(['n = ',num2str(n)],'Fontsize',12);
xlabel('distance (m)','Fontsize',12);
ylabel('imag(y) (m)','Fontsize',12);
grid on;

