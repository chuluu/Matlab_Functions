clc
clear

Lx = 1;
Ly = 1;
c  = 1;
m  = 1;
n  = 1;
fnish = (((2*n)-1)/(2*Lx))^2;
fmish = (m/Ly)^2;
fmn = (c/2)*sqrt(fnish + fmish);

%% First lowest mode
n  = 1;
m  = 1;
kx = (((2*n)- 1)/2)*(pi/Lx);
ky = (m*pi/Ly);
x  = 0:0.01:Lx;
y  = (0:0.01:Ly).';
ms11 = sin(kx.*x).*sin(ky.*y);
[X,Y] = meshgrid(x,y);
surf(X,Y,ms11); hold on;
plot(zeros(1,length(x)),y,'r','Linewidth',5);
plot(x,zeros(1,length(y)),'r','Linewidth',5);
plot(x,Ly*ones(1,length(y)),'r','Linewidth',5);
plot(Lx*ones(1,length(x)),y,'--r','Linewidth',5);
view(0,90)  % XY
xlabel('x-axis (m)','Fontsize',12);
ylabel('y-axis (m)','Fontsize',12);
title('1st Lowest Mode','Fontsize',12);
caxis([-1 1]);

%% Second lowest mode
n  = 2;
m  = 1;
kx = (((2*n)- 1)/2)*(pi/Lx);
ky = (m*pi/Ly);
x  = 0:0.01:Lx;
y  = (0:0.01:Ly).';
ms11 = sin(kx.*x).*sin(ky.*y);
[X,Y] = meshgrid(x,y);
surf(X,Y,ms11); hold on;
plot(zeros(1,length(x)),y,'r','Linewidth',5);
plot(x,zeros(1,length(y)),'r','Linewidth',5);
plot(x,Ly*ones(1,length(y)),'r','Linewidth',5);
plot(Lx*ones(1,length(x)),y,'--r','Linewidth',5);
view(0,90)  % XY
xlabel('x-axis (m)','Fontsize',12);
ylabel('y-axis (m)','Fontsize',12);
title('2nd Lowest Mode','Fontsize',12);
caxis([-1 1]);

%% 3rd Lowest mode
n  = 1;
m  = 2;
kx = (((2*n)- 1)/2)*(pi/Lx);
ky = (m*pi/Ly);
x  = 0:0.01:Lx;
y  = (0:0.01:Ly).';
ms11 = sin(kx.*x).*sin(ky.*y);
[X,Y] = meshgrid(x,y);
surf(X,Y,ms11); hold on;
plot(zeros(1,length(x)),y,'r','Linewidth',5);
plot(x,zeros(1,length(y)),'r','Linewidth',5);
plot(x,Ly*ones(1,length(y)),'r','Linewidth',5);
plot(Lx*ones(1,length(x)),y,'--r','Linewidth',5);
view(0,90)  % XY
xlabel('x-axis (m)','Fontsize',12);
caxis([-1 1]);

ylabel('y-axis (m)','Fontsize',12);
title('3rd Lowest Mode','Fontsize',12);
zlim([-1 1]);

%%
Lx = 6;
Ly = 4;
n  = 4;
m  = 2;
kx = (n*pi/Lx);
ky = (m*pi/Ly);
x  = 0:0.01:Lx;
y  = (0:0.01:Ly).';
ms11 = sin(kx.*x).*sin(ky.*y);
[X,Y] = meshgrid(x,y);
surf(X,Y,ms11); hold on;
% plot(zeros(1,length(x)),y,'r','Linewidth',5);
% plot(x,zeros(1,length(y)),'r','Linewidth',5);
% plot(x,Ly*ones(1,length(y)),'r','Linewidth',5);
% plot(Lx*ones(1,length(x)),y,'--r','Linewidth',5);
view(0,90)  % XY
xlabel('x-axis (m)','Fontsize',12);
caxis([-0.5 0.5]);

ylabel('y-axis (m)','Fontsize',12);
title('3rd Lowest Mode','Fontsize',12);
zlim([-0.5 0.5]);