%% Part 1 Test Cases
% Run all test cases in lab #3 of EE459 from part 1 - 3


%% Quiz

x =  [2, 5];
fs = 10000;
[X,f] = plot_DFT_mag(x,fs,1)

%% Part 1 Test Case 1
Fs = 20;
n = (0:1:100-1)./Fs;
y = cos(2*pi*8*n);
plot(n,y)
[Y,f] = plot_DFT_mag(y,Fs,1)
%% Part 1 Test Case 2
Fs = 20;
n = (0:1:100-1)./Fs;
y = cos(2*pi*10*n);
plot(n,y)
[Y,f] = plot_DFT_mag(y,Fs,1);

%% Part 1 Test Case 3
Fs = 20;
n = (0:1:100-1)./Fs;
y = cos(2*pi*12*n);
plot(n,y)
[Y,f] = plot_DFT_mag(y,Fs,1);

%% Part 1 Test Case 4
Fs = 20;
n = (0:1:100-1)./Fs;
y = cos(2*pi*7.05*n);
plot(n,y)
[Y,f] = plot_DFT_mag(y,Fs,2);

%% Part 1 Test Case 5
Fs = 20;
n = (0:1:100-1)./Fs;
y = cos(2*pi*7.05*n) + 0.25.*cos(2*pi*8.17*n);
plot(n,y)
[Y,f] = plot_DFT_mag(y,Fs,1);

%% Part 1 Test Case 6
Fs = 20;
n = (0:1:100-1)./Fs;
xn = cos(2*pi*7.05.*n) + 0.25.*cos(2*pi*8.17.*n);
y = xn .* blackman(100)';
figure (2); plot(n,y)
[Y,f] = plot_DFT_mag(y,Fs,1);

%% Part 1 Test Case 7
Fs = 20;
n = (0:1:200-1)./Fs;
y = cos(2*pi*7.05*n) + 0.25.*cos(2*pi*8.17*n);
plot(n,y)
[Y,f] = plot_DFT_mag(y,Fs,1);

%% Part 1 Test Case 8
Fs = 20;
n = (0:1:200-1)./Fs;
xn = cos(2*pi*7.05.*n) + 0.25.*cos(2*pi*8.17.*n);
y = xn .* blackman(200)';
plot(n,y)
[Y,f] = plot_DFT_mag(y,Fs,1);

%% Part 1 Test Case 9
Fs = 20;
n = (0:1:200-1)./Fs;
y = cos(2*pi*7.05*n) + cos(2*pi*7.25*n);
plot(n,y)
[Y,f] = plot_DFT_mag(y,Fs,1);

%% Part 1 Test Case 10
Fs = 20;
n = (0:1:200-1)./Fs;
xn = cos(2*pi*7.05*n) + cos(2*pi*7.25*n);
y = xn .* blackman(200)';
plot(n,y)
[Y,f] = plot_DFT_mag(y,Fs,1);

%% Part 1 Test Case 11
Fs = 1000;
[dn, n] = unit_sample(40);
[Y,f] = plot_DFT_mag(dn,Fs,1);

%% Part 1 Test Case 12
Fs = 1000;
[hn, n]=unit_sample_response([0.2, 0.2, 0.2, 0.2, 0.2], [1], 40, 1);
[Y,f] = plot_DFT_mag(hn,Fs,1);

%% Part 2 Test Cases
% 9 point hanning window
n = 0:1:8;
w = hann(9);
hn = [0, 0, 1, 0, 0, 0, 0, 1, 0, 0];
hn_n = 0:1:length(hn)-1;
[y,n_c] = fftconv(w, hn, 1000,1);

%% Part 3 Notch Frequency Domain Filter
load('/Users/matthewluu/Downloads/corrupted_tones.mat')
[Ak,Bk,HF,Fd,hn,n] = show_filter_responses_pz([.475+.8227i,.475-.8227i,-.475+.8227i,-.475-.8227i,-.95],[0.5+0.866*1i, 0.5-0.866*1i, -0.5+0.866*1i, -0.5-0.866*1i,-1],0.883,360,10000,60,10); %[-0.5i,0.5i] 
[y_c,n_c] = fftconv(y, hn, 360,1);
[Y,f] = plot_DFT_mag(y,360,5);

% n_y = 0:1:length(y)-1;
% figure(1);
% subplot(2,1,1); plot(n_y,y);
% subplot(2,1,2); plot(n_c,y_c);
%[Y_c,f_c] = plot_DFT_mag(y_c,360,15);

%% Part 3 Notch Filter Time Domain
load('/Users/matthewluu/Downloads/corrupted_tones.mat')
[Y,f] = plot_DFT_mag(y,360,1);
yn = filter([0.894, 0.894, 0.89392, 0.89392, 0.89392, 0.89392], [1, 0.975, 0.90242, 0.87986, 0.81443, 0.79407], y);
[Y_c,f_c] = plot_DFT_mag(yn,360,2);

%% Test 
xn = [1,2,3];
hn = [0.5,0.5];
[y_c,n_c,Y] = fftconv(xn, hn, 1000,1);
