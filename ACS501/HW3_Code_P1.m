%% P1
clc
clear all

m = 1; %kg
s = 1; %N/m
fs = 44100;
B = 0.05; %rad/s
fo = (1/(2*pi))*sqrt(s/m);
wo = 2.*pi.*fo;
w  = 0:0.01:2;
Fo = 1;


%% Part a
s_l  = s - 0.2*s;
s_h  = s + 0.2*s;
wo_s_l = sqrt(s_l/m);
wo_s_h = sqrt(s_h/m);

x_A = (Fo./m)./sqrt(((wo.^2) - (w.^2)).^2 + ((2.*B.*w).^2)); 
x_s_A_l = (Fo./m)./sqrt(((wo_s_l.^2) - (w.^2)).^2 + ((2.*B.*w).^2));
x_s_A_h = (Fo./m)./sqrt(((wo_s_h.^2) - (w.^2)).^2 + ((2.*B.*w).^2));

figure(1);
plot_function(w,x_s_A_l,'g',1.5); hold on;
plot_function(w,x_A,'b',1.5); 
plot_function(w,x_s_A_h,'r',1.5);
title_plots('','Angular Freq (rad/s)','Amplitude (m)',14)
legend('-20% stiffness','Nominal','+20% stiffness');

%% Part b
m_l  = m - 0.2*m;
m_h  = m + 0.2*m;
wo_m_l = sqrt(s/m_l);
wo_m_h = sqrt(s/m_h);

x_A = (Fo./m)./sqrt(((wo.^2) - (w.^2)).^2 + ((2.*B.*w).^2)); 
x_m_A_l = (Fo./m_l)./sqrt(((wo_m_l.^2) - (w.^2)).^2 + ((2.*B.*w).^2));
x_m_A_h = (Fo./m_h)./sqrt(((wo_m_h.^2) - (w.^2)).^2 + ((2.*B.*w).^2));

figure(2);
plot_function(w,x_m_A_l,'g',1.5); hold on;
plot_function(w,x_A,'b',1.5); 
plot_function(w,x_m_A_h,'r',1.5);
title_plots('','Angular Freq (rad/s)','Amplitude (m)',14)
legend('-20% mass','Nominal','+20% mass');

%% Part c
B_l  = B - 0.2*B;
B_h  = B + 0.2*B;

x_A = (Fo./m)./sqrt(((wo.^2) - (w.^2)).^2 + ((2.*B.*w).^2)); 
x_B_A_l = (Fo./m)./sqrt(((wo.^2) - (w.^2)).^2 + ((2.*B_l.*w).^2));
x_B_A_h = (Fo./m)./sqrt(((wo.^2) - (w.^2)).^2 + ((2.*B_h.*w).^2));

figure(3);
plot_function(w,x_B_A_l,'g',1.5); hold on;
plot_function(w,x_A,'b',1.5); 
plot_function(w,x_B_A_h,'r',1.5);
title_plots('','Angular Freq (rad/s)','Amplitude (m)',14)
legend('-20% Damping Ratio','Nominal','+20% Damping Ratio');




