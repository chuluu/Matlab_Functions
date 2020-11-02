%% Intro
%{
Assignment #5: Spectrograms!!!
Description of Code
%{
Spectrograms baby
%}

Color Codes
%{
'red'	'r'	[1 0 0]
'green'	'g'	[0 1 0]
'blue'	'b'	[0 0 1]
'cyan'	'c'	[0 1 1]
'magenta'	'm'	[1 0 1]
'yellow'	'y'	[1 1 0]	
'black'	'k'	[0 0 0]
'white'	'w'	[1 1 1]
%}

Windows
%{
% rectwin( ) - Rectangular window.
% triang( ) - Triangular window.
% bartlett( ) - Bartlett window (Triangle Window with ?0?s at both ends)
% hann( ) - von Hann window (Hanning Window with ?0?s at both ends)
% hanning( ) - Hanning window (With non-zero end samples).
% hamming ( ) - Hamming window.
% blackman( ) - Blackman window.
% kaiser( ) - Kaiser window (with b parameter)
% tukeywin( ) - Tukey window.
% Barthannwin( ) - Modified Bartlett-Hanning window.
% bohmanwin( ) - Bohman window.
% chebwin( ) - Chebyshev window.
% flattopwin( ) - Flat Top window.
% gausswin( ) - Gaussian window.
% blackmanharris( ) - Minimum 4-term Blackman-Harris window
% nuttallwin( ) - Nuttall defined minimum 4-term Blackman-Harris window.
% parzenwin( ) - Parzen (de la Valle-Poussin) window. 
%}

Constants
%{
Atmospheric Pressure      =  2 * 10^-5 Pa
Boltzmann Constant        =  1.38 * 10^-23 J/molecule
Room Temperature          =  21 C
Specific Impedance of air =  420 Rayls
Speed of Sound            =  343 m/2
Permittivity (free space) =  8.85 * 10^-12 
Permeability (free space) =  4π * 10^-12 
%}

Typical Equations
%{
dB pressure         =  20*1og(P/P_ref) dB
dB Intensity        =  10*1og(P/P_ref) dB
dispertion equation =  c = λf m/s
Mechanical f_res    =  (1/2π) * sqrt(k/m) Hz
%}

%}

clear
clc

% Directory for Functions
newpath = 'C:\Users\mbluu\OneDrive\Desktop\MATLAB_Work\Functions';
userpath(newpath)

Intro()
%% Import Data
[xn,fs] = audioread('Test_shoot_A.wav');
xn1 = xn(:,1);
xn2 = xn(:,2); 
xn3 = xn(:,3);
xn4 = xn(:,4);

dt = 1/fs;
N = length(xn3);
t = (0:1:N-1).*dt;

N_pks = 5;
eta_N = 100;
[t_pks,Idx] = MyFindpks(xn3,N_pks,eta_N,t);
disp(['Time of Peaks: ',num2str(t_pks)]);
xlabel('Time (s)','Fontsize',12);
ylabel('Amplitude (WU)','Fontsize',12);
title('Peaks of Airburst','Fontsize',12);

grid on;

%% Part 2: Plotting 5 peak area channel bursts
figure(1);
plot_4_ch_burst_Part2(fs,Idx,xn,t_pks);

t_shift_class = total_time_delay_finder(fs,Idx,xn);

N_shifts      = round(t_shift_class{2,1}.*fs);

figure(2);
plotting_check_relative_time_delay_CH3(fs,Idx,N_shifts,t_pks,xn1,xn2,xn3,xn4);

%% t_pks = at chosen 
n   = 3; % Choosing which time part ([30,38,5,21,13]) 

tref1 = t_shift_class{2,1}(:,2);
t12 = t_shift_class{2,1}(n,2);
t13 = t_shift_class{2,1}(n,3);
t14 = t_shift_class{2,1}(n,4);
t23 = t_shift_class{2,2}(n,3);
t24 = t_shift_class{2,2}(n,4);
t34 = t_shift_class{2,3}(n,4);

T = [t12,t13,t14,t23,t24,t34].'

%% Position dealing
XY_rel_3 = [-29.0, 51.7, 0.0;... % Microphone 1
 28.7, 51.7, 0.0;... % Microphone 2
 0.0, 0.0, 0.0;... % Microphone 3
 0.0, 35.0, 20.0]; % Microphone 4 
x = 1;
y = 2;
z = 3;

r12 = [(XY_rel_3(2,x) - XY_rel_3(1,x)),(XY_rel_3(2,y) - XY_rel_3(1,y)),...
    (XY_rel_3(2,z) - XY_rel_3(1,z))];
r13 = [(XY_rel_3(3,x) - XY_rel_3(1,x)),(XY_rel_3(3,y) - XY_rel_3(1,y)),...
    (XY_rel_3(3,z) - XY_rel_3(1,z))];
r14 = [(XY_rel_3(4,x) - XY_rel_3(1,x)),(XY_rel_3(4,y) - XY_rel_3(1,y)),...
    (XY_rel_3(4,z) - XY_rel_3(1,z))];
r23 = [(XY_rel_3(3,x) - XY_rel_3(2,x)),(XY_rel_3(3,y) - XY_rel_3(2,y)),...
    (XY_rel_3(3,z) - XY_rel_3(2,z))];
r24 = [(XY_rel_3(4,x) - XY_rel_3(2,x)),(XY_rel_3(4,y) - XY_rel_3(2,y)),...
    (XY_rel_3(4,z) - XY_rel_3(2,z))];
r34 = [(XY_rel_3(4,x) - XY_rel_3(3,x)),(XY_rel_3(4,y) - XY_rel_3(3,y)),...
    (XY_rel_3(4,z) - XY_rel_3(3,z))];
r   = [r12;r13;r14;r23;r24;r34];
r   = r.*0.3048;

%% Solve for slowness vector
S = r\T;

%% Check speed of sound temp
Temp       = 299.261;
    
c_slowness = (1/sqrt(S(1,1)^2 + S(2,1)^2 + S(3,1)^2))
c_temp     = sqrt(1.4*8.314*Temp/0.029)

%% plotting and doing slowness vector things
figure(23)
plot3(S(1,1),S(2,1),S(3,1),'--o'); hold on;
plot3(0,0,0,'--o');
grid on;
xlabel('x');
ylabel('y');
zlabel('z');
v = [5 -5 5];
[caz,cel] = view(v);
x = S(1,1);
y = S(2,1);
z = S(3,1);

azimuth_rad = atan2(y,x);
elevation_rad = atan2(z,sqrt(x.^2 + y.^2));

Az_deg = rad2deg(azimuth_rad)
El_deg = rad2deg(elevation_rad)

% r = sqrt(x.^2 + y.^2 + z.^2)

%% Functions to reduce variable workspace
function [t_pks,Idx] = MyFindpks(xn,Npks,eta_N,t)
    plot(t,xn,'Linewidth',1.5); hold on;
    for a = 1:Npks
        [val,Idx(a)] = max(xn);
        xn(Idx(a)-eta_N:Idx(a)+eta_N) = 0;
        t_pks(a) = t(Idx(a));
        plot(t_pks(a),val,'-o'); hold on;
    end
end

function plot_4_ch_burst_Part2(fs,Idx,xn,t_pks)
    T_before = 0.05;
    T_after  = 0.1;
    N_before = T_before*fs;
    N_after  = T_after*fs;
    dt = 1/fs;
    a = 3;
    for a = 1:length(Idx)
        Range_before = Idx(a) - N_before;
        Range_after  = Idx(a) + N_after - 1;
        t_plt        = (Range_before:1:Range_after).*dt;
        for b = 1:4
            xn_plt = xn(Range_before:Range_after,b);
            %subplot(length(Idx),1,a); 
            plot(t_plt, xn_plt); hold on;
            title(['Time Shot: ', num2str(t_pks(a)),' s'],'Fontsize',12);
            xlabel('Time (s)','Fontsize',12);
            ylabel('Amplitude (WU)','Fontsize',12);
            xlim([min(t_plt), max(t_plt)]);
            grid on;
        end
        legend('Ch1','Ch2','Ch3','Ch4','Location','bestoutside');
    end
end

function t_shift_class = total_time_delay_finder(fs,Idx,xn)
    T_before = 0.5;
    T_after  = 0.5;
    N_before = T_before*fs;
    N_after  = T_after*fs;
    dt       = 1/fs;

    for num = 1:4
        for a = 1:length(Idx)
            Range_before = Idx(a) - N_before;
            Range_after  = Idx(a) + N_after - 1;
            t_plt        = (Range_before:1:Range_after).*dt;
            xn_ref       = xn(Range_before:Range_after,num);

            for b = 1:4
                xn_plt = xn(Range_before:Range_after,b);
                Cxy = MyCrossCorCirc(xn_ref, xn_plt);
                [Cxy_order{a,b},t_shift] = DC_time_shift(Cxy,fs);
                if b == 4
                    [PKS,LOCS,W] = findpeaks(Cxy_order{a,b}); % Find all pks
                    [y,maxpks] = max(PKS(PKS<max(PKS)));      % Find second max
                    Idxshift   = LOCS(maxpks);                % Get index
                    [val,Idxshift] = max(Cxy_order{a,b});
                    t_shifts(a,b) = t_shift(Idxshift);
                    N_shifts(a,b) = t_shifts(a,b).*fs;     
                else
                    [val,Idxshift] = max(Cxy_order{a,b});
                    t_shifts(a,b) = t_shift(Idxshift);
                    N_shifts(a,b) = t_shifts(a,b).*fs;
                end
            end
        end

        t_shift_class{1,num} = ['x',num2str(num),' ref'];
        t_shift_class{2,num} = t_shifts;

    end
end

function plotting_check_relative_time_delay_CH3(fs,Idx,N_shifts,t_pks,xn1,xn2,xn3,xn4)
    T_before = 0.05;
    T_after  = 0.1;

    N_before = T_before*fs;
    N_after  = T_after*fs;
    dt       = 1/fs;
    a = 3;
    %for a = 1:length(Idx)
        Range_before = Idx(a) - N_before;
        Range_after  = Idx(a) + N_after - 1;
        t_change1    = (Range_before+N_shifts(a,1):1:Range_after+N_shifts(a,1)).*dt;
        t_change2    = (Range_before+N_shifts(a,2):1:Range_after+N_shifts(a,2)).*dt;
        t_change3    = (Range_before+N_shifts(a,3):1:Range_after+N_shifts(a,3)).*dt;
        t_change4    = (Range_before+N_shifts(a,4):1:Range_after+N_shifts(a,4)).*dt;

        xn_plt1 = xn1(Range_before:Range_after);
        xn_plt2 = xn2(Range_before:Range_after);
        xn_plt3 = xn3(Range_before:Range_after);
        xn_plt4 = xn4(Range_before:Range_after);
        
        %subplot(length(Idx),1,a);
        plot(t_change1, xn_plt1); hold on;
        %subplot(length(Idx),1,a); 
        plot(t_change2, xn_plt2); 
        %subplot(length(Idx),1,a); 
        plot(t_change3, xn_plt3); 
        %subplot(length(Idx),1,a); 
        plot(t_change4, xn_plt4); 

        title(['Time Shot: ', num2str(t_pks(a)),' s'],'Fontsize',12);
        xlabel('Time (s)','Fontsize',12);
        ylabel('Amplitude (WU)','Fontsize',12);
        %xlim([min(t_plt), max(t_plt)]);
        legend('Ch1','Ch2','Ch3','Ch4','Location','bestoutside');
        xlim([min(t_change1), max(t_change1)]);
        grid on;

    %end
end