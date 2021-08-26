%% EE459 Lab11
% Turn in
fs = 44.1e3;
EQdBsettings = [12, -6, -12, -12, -6, 12, -6, 12, -6];
Dk_delays_msec =  [250 400 520 660 750 1220]; 
alphak_gains = [0.7 0.6 0.5 0.33 0.2 0.8];

y = equalize_and_reverb('Zarathustra.wav', EQdBsettings, Dk_delays_msec, alphak_gains, 'Zarathustra_"bad"_processed.wav');

soundsc(y, fs)

%% 
% Best sound
fs = 44.1e3;
EQdBsettings =  [8, 3, 0, 0, 0, 0, 2, 4, 6]; %[5, 3, 1, 1, 0, 0, 2, 4, 6];
Dk_delays_msec =  [50 120 200 330 410]; %[50 120 200 250 300 450]; 
alphak_gains =  [0.6 0.4 0.3 0.2 0.1]; %[0.2 0.16 0.13 0.1 0.07, 0.05];

y = equalize_and_reverb('Zarathustra.wav', EQdBsettings, Dk_delays_msec, alphak_gains, 'Zarathustra_"fixed"_processed.wav');

%soundsc(y, fs)
