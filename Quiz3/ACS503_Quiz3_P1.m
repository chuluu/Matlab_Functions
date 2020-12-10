%%
clc
clear
[filepath,~,~] = fileparts(pwd);
newpath = ['C:\Users\tonel\Desktop\MATLAB_Work\','\Function_Packages'];
userpath(newpath);
Intro();

%%
elem1_loc = [0,0];
elem2_loc = [2,0];
elem3_loc = [0,1];
elem4_loc = [2,1];

Sx = 0.475*10^-3;
Sy = 0.475*10^-3;
S  = [Sx,Sy];

%% Part b
c_slowness = round((1/sqrt(S(1)^2 + S(2)^2)));
disp(['Speed of Sound: ', num2str(c_slowness),' m/s']);
% Oh thats ocean baby

%% Part c
x = 1;
y = 2;
r11 = [0,0];
r12 = [elem2_loc(1) - elem1_loc(1),elem2_loc(2) - elem1_loc(2)];
r13 = [elem3_loc(1) - elem1_loc(1),elem3_loc(2) - elem1_loc(2)];
r14 = [elem4_loc(1) - elem1_loc(1),elem4_loc(2) - elem1_loc(2)];

r = [r11;r12;r13;r14];

td = r*(S.')

%% Part d
t1 = 0;
t2 = 0.598*10^-3;
t3 = -0.635*10^-3;
t4 = -0.003*10^-3;
T  = [t1,t2,t3,t4].';
S_new = r\T

c_slowness = round((1/sqrt(S_new(1)^2 + S_new(2)^2)));
disp(['Speed of Sound: ', num2str(c_slowness),' m/s']);


