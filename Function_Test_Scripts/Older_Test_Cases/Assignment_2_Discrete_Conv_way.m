%% Intro:
%{

Inputs: 
Fs:  Sampling Rate
f:   Input Frequency
tau: Time Constant


Output: 
Convolved Signals: Solution to bounded integral

Algorithm:
Utilize Discrete Convolution Lattice Shift Method
Remember to multiply by del when doing fft and convolution
magnitude, this will yield the correct results

%}

clear variables
close all
spy 
title('He is fetching data','Fontsize', 16);
xlabel('Bark! Bark!','Fontsize', 16);
why
pause(3)

%% Input Data here
Fs = 100000;
f = 159;
t = 0:1/Fs:0.01; % 0 -> 10ms
tau = 0.001;     % tau = 1ms

%% Signals
x_sine   = sin(2.*pi.*f.*t);
x_square = ones(1,length(x_sine));%square(2.*pi.*f.*t);
x_saw    = t.*x_square; %sawtooth(2.*pi.*f.*t);
h        = (1/tau)*exp(-(1/tau).*t);

%% Convolution
% Convolution function created by me

[y_sine,t1] = Discrete_Convolution(x_sine,h,Fs);
[y_square,t2] = Discrete_Convolution(x_square,h,Fs);
[y_saw,t3] = Discrete_Convolution(x_saw,h,Fs);

%% Analytical Equations
% These equations were derived by hand

Step_Analytical = (1-exp(-t/tau));
Ramp_Analytical = (t+ (tau*exp(-t/tau)) -tau);
A_coeff = (2*pi*f/tau)/((-1i*4*pi*f)*((1/tau)-(1i*2*pi*f)));
A_coeff_real = real(A_coeff);
A_coeff_imag = imag(A_coeff);
B_coeff = (2*pi*f/tau)/(((1/tau)^2) + ((2*pi*f)^2));
Sine_Analytical = 2*(A_coeff_real*cos(2*pi*f.*t) + A_coeff_imag*sin(2*pi*f.*t)) + B_coeff.*exp(-t./tau);

%% Plotting
figure(1); % Input vs. Output
subplot(3,1,1); 
plot(t1,y_sine,'Linewidth',3); hold on
plot(t,x_sine,'Linewidth',3);
xlim([0 0.01]);
title('Sine LP Convolution');
xlabel('Time (s)');
ylabel('Magnitude');
legend('Output', 'Input', 'Location', 'NorthEastOutside');

subplot(3,1,2); 
plot(t2,y_square,'Linewidth',3); hold on
plot(t,x_square,'Linewidth',3);
xlim([0 0.01]);
title('Square LP Convolution');
xlabel('Time (s)');
ylabel('Magnitude');
legend('Output', 'Input', 'Location', 'NorthEastOutside');

subplot(3,1,3); 
plot(t3,y_saw,'Linewidth',3); hold on
plot(t,x_saw,'Linewidth',3);
xlim([0 0.01]);
title('Ramp LP Convolution');
xlabel('Time (s)');
ylabel('Magnitude');

legend('Output', 'Intput', 'Location', 'NorthEastOutside');

figure(2); % Analytical vs. Discrete
subplot(3,1,1); 
plot(t2,y_sine,'Linewidth',3); hold on
plot(t,Sine_Analytical,'Linewidth',3);
xlim([0 0.01]);
title('Sine LP Convolution');
xlabel('Time (s)');
ylabel('Magnitude');
legend('Discrete', 'Analytical', 'Location', 'NorthEastOutside');

subplot(3,1,2); 
plot(t2,y_square,'Linewidth',3); hold on
plot(t,Step_Analytical,'Linewidth',3);
xlim([0 0.01]);
title('Square LP Convolution');
xlabel('Time (s)');
ylabel('Magnitude');
legend('Discrete', 'Analytical', 'Location', 'NorthEastOutside');

subplot(3,1,3); 
plot(t2,y_saw,'Linewidth',3); hold on
plot(t,Ramp_Analytical,'Linewidth',3);
xlim([0 0.01]);
title('Ramp LP Convolution');
xlabel('Time (s)');
ylabel('Magnitude');
legend('Discrete', 'Analytical', 'Location', 'NorthEastOutside');

%% Convolution Discrete
function [y,t] = Discrete_Convolution(x,h,Fs)
%{
Inputs: 
x: input signal
h: impulse response
Fs: Sampling Rate

Outputs:
y: Convolved signal
t: time array

Algorithm:
Implement discrete convolution equation outlined in screenshot

%}

N = length(x);
M = length(h);
Ny = N + M - 1;  % Zero Pad for linear convolution
y = zeros(1,Ny); % This zero pads the signal for linear
for n = 1:N
    for m = 1:M
        y(n+m-1) = y(n+m-1) + h(m)*x(n); % Lattice method
    end
end

y = y*(1/Fs); % Multiply output by timestep for correct magnitude
t = (0:1:length(y)-1)/Fs; %Time step

end

