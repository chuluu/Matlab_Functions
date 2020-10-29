%% Intro
% Test Case for MyModeStringSolver

clc
clear
[filepath,~,~] = fileparts(pwd);
newpath = [filepath,'\Function_Packages'];
userpath(newpath);
Intro();
%%
T    = 100;
rho1 = 20;
rho2 = 10;
L    = 2.0;
w = 0:0.001:15;

%%
w_real = MyACS.My_Mode_String_Solver(T,rho1,rho2,L,w,5);
