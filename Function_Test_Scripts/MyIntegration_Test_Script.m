%% Intro
% Test Case for Numerical Integration using trapezoids

clc
clear
[filepath,~,~] = fileparts(pwd);
newpath = [filepath,'\Function_Packages'];
addpath(newpath);
Intro();

%% Inputs:
x = 0:pi/128:pi;
y = sin(2.*pi.*x);
del = pi/128;

%% Integration:
integration_answer = MyGen.Numerical_Trapazoid_Integration(y,del)