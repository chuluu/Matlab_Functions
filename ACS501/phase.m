%% Part A
% Inputs
dt = 0.01;
xn = [1, 0, 2, 5, -1, 4, -2, 2]; %V
% xn = [1 ,-1, 1, -1, 1, -1, 1, -1];

% Constants Calculated
fs = 1/dt;
N = length(xn);
df = 1/(dt*N);
f = (0:N-1)*df
t = (0:N-1)*dt;
Xm = fft(xn).*dt;
N = length(Xm);      % Normalize by sample length.
%[RAND_Y,freq] = MyFFT(rand_y,Fs,'n',0);


plot_function(f,abs(Xm),'r',1.5);
[Gxx,Sxx,f_Sxx,f_Gxx] = MyPSDX(xn,fs);
plot(f_Gxx,Gxx); hold on;
plot_function(f,abs(Xm),'r',1.5);
