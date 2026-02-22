%% Intro
% Test Case for halfpower function
clc
clear

[filepath,~,~] = fileparts(pwd);
newpath = [filepath,'\Function_Packages'];
userpath(newpath);
Intro();

%% Part C
R1 = 1;
R2 = 2;
R3 = 3;
R4 = 4;
R5 = 5;
Fc = [1;0;0];

% part a)
Z  = [R1 + R2, -R2, 0;-R2, R2+R3+R4, R4;0,R4,R4+R5];
% part b)
Z_inv = inv(Z);
% part c)
TF = Z_inv*Fc

%% Part D
f = 100;
w = 2*pi*f;
s = 1i*w;

m1 = 0.01;
c2 = 0.01;
c3 = 0.01;
R1 = 0.01;
R2 = 0.01;
R3 = 0.01;
F1 = 1;
F3 = 0;
% part a)
Z = [s*m1 + R1, - R1, 0 ; -R1, (1/(s*c2)) + R1 + R2, -R2; 0, -R2, ((1/(s*c3)) + R2 + R3)];
% part b)
Z_inv = Z.';
% part c)
v_mat = Z_inv*[F1;0;F3];
Fc2 = c2*v_mat(2)

%% Part E
f = 0:1:100;
w = 2.*pi.*f;
R = 1.0;
c = 0.01; 
Z2_func = Impedance_two(f);
Z2_tf   = R + (1./(1i.*w.*2.*c));

figure(1);
subplot(2,1,1); loglog(f,abs(Z2_func),'Linewidth',1.4); hold on;
subplot(2,1,1); loglog(f,abs(Z2_tf),'--','Linewidth',1.6);
grid on;
legend('m file function','Given transfer function');
MyGen.title_plots('Magnitude','Frequency (Hz)','Impedance (mag)',12);
subplot(2,1,2); semilogx(f,180*angle(Z2_func)/pi,'Linewidth',1.4); hold on;
subplot(2,1,2); semilogx(f,180*angle(Z2_tf)/pi,'--','Linewidth',1.6);
grid on;
legend('m file function','Given transfer function','Location','best');
MyGen.title_plots('Phase','Frequency (Hz)','Impedance (deg)',12);

function Z2 = Impedance_two(freqs)
    w  = 2.*pi.*freqs;
    s  = 1i.*w;
    c  = 0.01;
    R  = 1.0;
    Za = R.*ones(1,length(freqs));
    Zb = 1./(s.*c);
    Zl = 1./(s.*c);
    
    for a = 1:length(freqs)
        T  = [(1+Za(a)/Zb(a)) , -Za(a);1/Zb(a) , -1]
        Two = T*[-Zl(a) ; 1]; % v1 will cancel out for Z2
        Z2(a)  = Two(1)/Two(2);
    end
end



