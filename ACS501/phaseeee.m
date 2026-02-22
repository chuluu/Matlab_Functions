fs = 44100; 
t  = 0:1/fs:1;
f = 1;
A = sin(2*pi*f*t); % Displacement
A2 = sin(2*pi*f*t + deg2rad(90)); % Velocity
A3 = cos(2*pi*f*t);
plot_function(t,A,'k',1.5); hold on;
plot_function(t,A2,'*b',1.5);
plot_function(t,A3,'r',1.5);
title_plots('','Time (s)','Amplitude',14)

legend('Displacement','+90','Cosine');

rad2deg(atan2(2*1.4*5,(14^2 - 5^2)))