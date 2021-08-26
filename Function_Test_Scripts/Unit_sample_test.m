%%
clc
clear

set(0,'DefaultFigureWindowStyle','docked');
[filepath,~,~] = fileparts(pwd);
newpath = [filepath,'\Function_Packages'];
addpath(newpath);
Intro();

%%
[dn, n] = MyDSP.unit_sample(16);
%plot n
figure(1);
stem(n,dn,'.','Linewidth',3);
title('unit sample index');
xlabel('index');
ylabel('Amplitude');
