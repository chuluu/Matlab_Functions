%% Intro
% Test Case for halfpower function
clc
clear

[filepath,~,~] = fileparts(pwd);
newpath = [filepath,'\Function_Packages'];
userpath(newpath);
Intro();

%% Test Case1
f = -10:0.01:10;
y = sinc(f);

[mainlobe,f_sub] = MyGen.mainlobe_detector(y,f);
[f1,f2] = MyDSP.find_halfpower_pts(mainlobe,f_sub);
[val1] = mainlobe(find(f_sub==f1));
[val2] = mainlobe(find(f_sub==f2));

subplot(2,1,1); plot(f_sub,mainlobe);
subplot(2,1,2); plot(f,y); hold on;
plot(f1,val1,'--o')
plot(f2,val2,'--o')


