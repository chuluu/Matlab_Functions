for n = 1:50
    R = (a/2)*((k*a/(n*pi) - (n*pi)/(k*a)));
    if R < 0
        R
        n
        break;
    end
end


clc
clear

theta = 0:1:360;
d   = 0.075;
f   = 10*10^3;
w   = 2*pi*f;
c   = 1500;
k   = w/c;
k*d/2
theta = deg2rad(theta);
phi = (k*d/2)*sin(theta);
D = 1-cos(phi);

polarplot(D);
title('f2 = 10kHz');
theta = 0:1:360;
d   = 0.075;
f   = 20*10^3;
w   = 2*pi*f;
c   = 1500;
k   = w/c;
k*d/2
theta = deg2rad(theta);
phi = (k*d/2)*sin(theta);
D2 = 1-cos(phi);

% polarplot(D2);
% title('f2 = 20kHz');