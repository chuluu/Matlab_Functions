%% Intro
% Test Case for halfpower function
clc
clear

[filepath,~,~] = fileparts(pwd);
newpath = [filepath,'\Function_Packages'];
userpath(newpath);
Intro();

%% Part 1
L = 69*10^-2; % m
rhol = 7.4*10^-3; % kg/m
h = 5*10^-3; % m
T = 140; % N
d = L/2; % In this case, midpoint

c = sqrt(T/rhol);

for n = 1:1:18
    fn(n) = (n*c)/(2*L);
    wn(n) = 2.*pi.*fn(n);
    den = (n.^2).*(pi.^2).*d.*(L-d);
    num = 2.*h.*(L.^2).*sin(n.*pi.*d./L);
    An(n) = (num/den)*10^3;
end
clc

disp(['Fr: ',num2str(fn(1:2:end)),' Hz']);
disp(['An: ',num2str(An(1:2:end)),' mm']);

%% Part 2
f1 = fn(1);
T  = 1/f1;
t  = [0,T/8,T/4,(3*T)/8,T/2];

x = (0:0.01:L);
for b = 1:length(t)
    for n = 1:length(fn)
        temporal = cos(wn(n).*t(b));
        for a = 1:length(x)
            y(n,a) = An(n).*temporal.*sin((n*pi/L)*x(a));
        end
    end
    y_tot = sum(y);
    subplot(length(t),1,b); plot(x*10^2,y_tot,'Linewidth',1.4);
    MyGen.title_plots(['t = ', num2str(t(b)/T), 'T (s)'],'Position (cm)','Displacement (mm)',10);
    ylim([-5.1 5.1]);
    xlim([0 L*10^2]);
    grid on;
end

