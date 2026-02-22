%% Part C SHO:
clc
clear
f  = 10:1:1000;
R  = 6.28;
c  = 25.3*10^-6;
m  = 0.1;
w  = 2.*pi.*f;
Zt = R + (1./(1i.*w.*c)) + 1i.*w.*m;
Yt_easy = 1./Zt;
Yt_alg  = (R - 1i.*(w.*m - (1./(w.*c))))./((R^2) + (w.*m - (1./(w.*c))).^2);

figure(1);
subplot(2,1,1); semilogx(f,abs(Yt_easy),'Linewidth',1.4); hold on;
subplot(2,1,1); semilogx(f,abs(Yt_alg),'--','Linewidth',1.6);
grid on;
legend('Recipricol in MATLAB','Recipricol using algebra');
MyGen.title_plots('Admittance Magnitude','Frequency (Hz)','Magnitude (m/(Ns))',12);
subplot(2,1,2); semilogx(f,180*angle(Yt_easy)/pi,'Linewidth',1.4); hold on;
subplot(2,1,2); semilogx(f,180*angle(Yt_alg)/pi,'--','Linewidth',1.6);
grid on;
legend('Recipricol in MATLAB','Recipricol using algebra');
MyGen.title_plots('Admittance Phase','Frequency (Hz)','Phase (deg)',12);

%% PArt C Part 4
clc
clear
f  = 10:1:1000;
R  = 6.28;
c  = 25.3*10^-6;
m  = 0.1;
w  = 2.*pi.*f;
Zt = R + (1./(1i.*w.*c)) + 1i.*w.*m;
Yt_easy = (1./Zt).*R;
Yt_alg  = ((R - 1i.*(w.*m - (1./(w.*c))))./((R^2) + (w.*m - (1./(w.*c))).^2)).*R;

figure(1);
subplot(2,1,1); semilogx(f,abs(Yt_easy),'Linewidth',1.4); hold on;
subplot(2,1,1); semilogx(f,abs(Yt_alg),'--','Linewidth',1.6);
grid on;
legend('Recipricol in MATLAB','Recipricol using algebra');
MyGen.title_plots('Admittance Magnitude Normalized','Frequency (Hz)','Normalized Magnitude',12);
subplot(2,1,2); semilogx(f,180*angle(Yt_easy)/pi,'Linewidth',1.4); hold on;
subplot(2,1,2); semilogx(f,180*angle(Yt_alg)/pi,'--','Linewidth',1.6);
grid on;
legend('Recipricol in MATLAB','Recipricol using algebra');
MyGen.title_plots('Admittance Phase','Frequency (Hz)','Phase (deg)',12);

%% PArt C Part 6
clc
clear
f  = 10:1:1000;
R  = 6.28;
c  = 25.3*10^-6;
m  = 0.1;
w  = 2.*pi.*f;
wo = sqrt(1/(m*c));
Q  = [1,10];
omega = 0.1:0.01:10;
for a = 1:length(Q)
    RvF = (1i.*omega./Q(a))./(1-(omega.^2)+(1i.*omega./Q(a)));
    figure(1);
    subplot(2,1,1); semilogx(omega,abs(RvF),'Linewidth',1.4); hold on;
    grid on;
    legend('Q = 1','Q = 10');
    MyGen.title_plots('Normalized Admittance Magnitude','Omega','Magnitude (norm)',12);
    subplot(2,1,2); semilogx(omega,180*angle(RvF)/pi,'Linewidth',1.4); hold on;
    grid on;
    legend('Q = 1','Q = 10');
    MyGen.title_plots('Normalized Admittance Phase','Omega','Phase (deg)',12);
end


