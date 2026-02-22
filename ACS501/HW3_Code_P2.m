%% P1
clc
clear 

m = 0.5; %kg
s = 100; %N/m
R = 1.4; %kg/s

fs = 44100;
B = R/(2*m); %rad/s
Fo = 2;


wo = sqrt(s/m);
w  = 5;

x_A = (Fo./m)./sqrt(((wo.^2) - (w^2)).^2 + ((2.*B.*w).^2)); 
v_A = w*x_A;
P_A = (1/2)*R*v_A^2;

disp(['Displacement: ',num2str(x_A),' m']);
disp(['Velocity: ',num2str(v_A),' m/s']);
disp(['Power: ',num2str(P_A),' W']);


%% Plotting 
clc
w  = 0:0.001:28;
x_A = (Fo./m)./sqrt(((wo.^2) - (w.^2)).^2 + ((2.*B.*w).^2)); 
v_A = w.*x_A;
P_A = (1/2).*R.*v_A.^2;
[x_res,idx_wres] = max(x_A);
w_R = w(idx_wres);
idx_wo  = find(w == 14.14);

v_res = v_A(idx_wres); %
v_max = v_A(idx_wo);
P_res = P_A(idx_wres); %
P_max = P_A(idx_wo);

disp(['Resonant Frequency: ',num2str(w_R),' rad/s']);
disp(['Displacement Resonance: ',num2str(x_res),' m']);
disp(['Velocity Resonance: ',num2str(v_res),' m/s']);
disp(['Power Resonance: ',num2str(P_res),' W']);

disp(['Velocity Max: ',num2str(v_max),' m/s']);
disp(['Power Max: ',num2str(P_max),' W']);

[mainlobe,mainlobe_w] = mainlobe_detector(x_A,w);
[w1,w2] = find_halfpower_pts(mainlobe,mainlobe_w);

disp(['w1: ',num2str(w1),' rad/s']);
disp(['w2: ',num2str(w2),' rad/s']);

%% Find -3dB Using Displacement
[Val,idx] = max(x_A);
w_R = w(idx);
val_half_power = Val/sqrt(2);
del = 0.000014;
x_3dB_idx = find( x_A < val_half_power + del & val_half_power - del < x_A );
w_x_way = w(x_3dB_idx)

figure(1);
plot_function(w,x_A,'b',1.5); hold on;
plot(w_x_way(1), x_A(x_3dB_idx(1)),'ro','Linewidth',1.5);
plot(w_x_way(2), x_A(x_3dB_idx(2)),'ro','Linewidth',1.5);
title_plots('','Angular Freq (rad/s)','Amplitude (m)',14)
xlim([min(w) max(w)]);

%% Find -3dB Using Power

val_half_power = P_res/2;
del_2 = 0.00031;
P_3dB_idx = find( P_A < val_half_power + del_2 & val_half_power - del_2 < P_A );
w_P_way = w(P_3dB_idx)
figure(1);

plot_function(w,P_A,'b',1.5); hold on;
plot(w_P_way(1), P_A(P_3dB_idx(1)),'ro','Linewidth',1.5);
plot(w_P_way(2), P_A(P_3dB_idx(2)),'ro','Linewidth',1.5);
title_plots('','Angular Freq (rad/s)','Amplitude (W)',14)
xlim([min(w) max(w)]);




