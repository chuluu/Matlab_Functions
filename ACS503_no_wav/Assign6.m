clc
clear 

wav_name  = {'data','bits','bits conversion','sensitivity','gain'};
DSP_name  = {'time start','time window','NSTFT','overlap %'};
INFO    = audioinfo('AACD_208_20_47_38.wav');
[xn,fs] = audioread('AACD_208_20_47_38.wav');

%% Part 1: Unit Check
xn_test       = 0.0275;
bits          = 24;
WU_to_bits    = 2^(bits-1);   % bits/WU
bits_to_volts = 1.5850*10^-6; % V/bits
sensitivity   = 0.05;         % V/Pa
xn_volts      = xn_test.*WU_to_bits.*bits_to_volts; % volts
Gain          = 200;
xn_PA_test    = (xn_volts/(sensitivity*Gain))

%% Part: Total
% Data starts at 27 July:        16:47:38.441 EDT
% Starting this section 28 July: 05:20:00.000 EDT
% Difference:                    12:32:22.559 EDt
bits          = 24;
bits_to_volts = 1.5850*10^-6; % V/bits
sensitivity   = 0.05;         % V/Pa
Gain          = 200;

wav_data      = {xn,bits,bits_to_volts,sensitivity,Gain};

time_start    = {'2011-07-28',[5,20,00,000]};
time_window   = 600;
NSTFT         = 2^11;
overlap       = 0.5;

DSP_data      = {time_start,time_window,NSTFT,overlap};

wav_input     = [wav_name;wav_data];
DSP_inputs    = [DSP_name;DSP_data];

[Gxx_array,dB_vals,t,f] = Jo_Hays_A(wav_input,DSP_inputs,fs,1);
%ylim([155 265])

% 
% lat1_in = [40,43,1];
% lon1_in = [-77,-53,-38.5];
% lat2_in = [40,47,18];
% lon2_in = [-77,-52,-31];
% 
% dist = distanceInKmBetweenEarthCoordinates(lat1_in, lon1_in,...
%     lat2_in, lon2_in);
% 
% time = (dist*10^3)/343; % m , %m/s
% time_samples = round(time*10^3);
%% Part 4



%% Part 3: time Gxx Average
clc
clear 

wav_name  = {'data','bits','bits conversion','sensitivity','gain'};
INFO    = audioinfo('AACD_208_20_47_38.wav');
[xn,fs] = audioread('AACD_208_20_47_38.wav');
N       = length(xn);
T       = fs*N; %s

% Data starts at 27 July:        16:47:38.441 EDT
% Starting this section 28 July: 05:20:00.000 EDT
% Difference:                    12:32:21.559 EDT
% Converting WU to Pa
bits          = 24;
WU_to_bits    = 2^(bits-1);   % bits/WU
bits_to_volts = 1.5850*10^-6; % V/bits
sensitivity   = 0.05;         % V/Pa
xn_volts      = xn.*WU_to_bits.*bits_to_volts; % volts
Gain          = 200;
xn_PA         = (xn_volts/(sensitivity*Gain));
dt = 1/fs;

hour_time = 12;
min_time  = 32;
sec_time  = 21;
ms_time   = 559;
t_start_ms = time_to_ms(hour_time, min_time, sec_time, ms_time,dt);
t_start_ms = t_start_ms+1;
rec_s = 10;
N = rec_s*60*fs;
rec_length = rec_s*1000;
t_end_ms   = t_start_ms+N;

xn_PA_520EDT = xn_PA(t_start_ms:t_end_ms);
xn_asdasdf   =xn(t_start_ms:t_end_ms);
[Gxx_avg,f_Gxx] = MyAvgGxx_Overlap(xn_PA_520EDT',rec_length,0.5,fs);
semilogy(f_Gxx,Gxx_avg);
xlim([0 400]);
title('Avg Gxx - Start time: 5:20:00.000 EDT','Fontsize',14);
xlabel('Freq (Hz)','Fontsize',14);
ylabel('Log Scale [Pa^2/Hz]','Fontsize',14);

grid on;
%% Converting units
% Converting WU to Pa
sensitivity   = 0.05;         % V/Pa
Gain          = 200;
bits_to_volts = 1.5850*10^-6; % V/bits
bits          = 24;
WU_to_bits    = 2^(bits-1);   % bits/WU

xn_PA         = 1;       % Pa
xn_volts      = xn_PA*(sensitivity);  % V
xn_amp        = xn_volts*Gain; % V
xn_bit        = xn_amp/(bits_to_volts); % bits
xn_WU         = xn_bit/WU_to_bits % WU

%%
% function xn_PA = WU_to_PA(xn,bits,bits_to_volts,sensitivity,Gain)
%     %bits          = 24;
%     WU_to_bits    = 2^(bits-1);   % bits/WU
%     %bits_to_volts = 1.5850*10^-6; % V/bits
%     %sensitivity   = 0.05;         % V/Pa
%     xn_volts      = xn.*WU_to_bits.*bits_to_volts; % volts
%     %Gain          = 200;
%     xn_PA         = (xn_volts/(sensitivity*Gain));
% end
% 
% function [Gxx_array,dB_vals,t_array_big,f_array_big] = ...
%     Spectrogram_Section_Jo_Hays(xn_PA,time_desire,seconds_desire,fs)
% 
%     dt = 1/fs;    
%     time_start     = {'2011-07-27',[16,47,38,441]};
%     time_day_end = [24,60,60,1000];
% 
%     if time_desire{1,1} == '2011-07-27'
%         for a = 1:length(time_desire{1,2})
%             time_diff(a) = abs(time{1,2}(a) - time_start{1,2}(a));
%         end
% 
%         t_start_ms = time_to_ms(time_diff(1), time_diff(2), ...
%             time_diff(3), time_diff(4),dt);
% 
%     elseif time_desire{1,1} == '2011-07-28'
%         for a = 1:length(time_desire{1,2})
%             time_diff_d_e(a) = abs(time_start{1,2}(a) - time_day_end(a));
%         end
% 
%         t_d_e_samples = time_to_ms(time_diff_d_e(1), time_diff_d_e(2), ...
%             time_diff_d_e(3), time_diff_d_e(4),dt);
% 
%         t_samples = time_to_ms(time_desire{1,2}(1), time_desire{1,2}(2), ...
%             time_desire{1,2}(3), time_desire{1,2}(4),dt);   
% 
%         t_start_ms = t_d_e_samples + t_samples; 
%     end
% 
%     t_end_ms = t_start_ms + seconds_desire*fs;
%     xn_PA_time = xn_PA(t_start_ms:t_end_ms);
%     NSTFT = 256;
% 
%     [Gxx_array,dB_vals,t_array_big,f_array_big] = MYSpectrogram(...
%         xn_PA_time',round(NSTFT),0.5,fs);
% 
% end
% 
function time_ms = time_to_ms(hour_time, min_time, sec_time, ms_time,dt)
    hr_sec   = 3600;
    min_sec  = 60;
    hr_s     = hour_time*hr_sec;
    min_s    = min_time*min_sec;
    s        = sec_time;
    time_s   = hr_s+min_s+s;
    time_ms  = time_s/dt;
    time_ms  = ms_time+time_ms;
end
% 
% %%
% % time_desire    = {'2011-07-28',[5,20,00,000]};
% % seconds_desire = 10*60;
% % dt = 1/fs;
% % time_start     = {'2011-07-27',[16,47,38,441]};
% % time_day_end = [24,60,60,1000];
% % 
% % if time_desire{1,1} == '2011-07-27'
% %     for a = 1:length(time_desire{1,2})
% %         time_diff(a) = abs(time{1,2}(a) - time_start{1,2}(a));
% %     end
% %     
% %     t_start_ms = time_to_ms(time_diff(1), time_diff(2), ...
% %         time_diff(3), time_diff(4),dt);
% %     
% % elseif time_desire{1,1} == '2011-07-28'
% %     for a = 1:length(time_desire{1,2})
% %         time_diff_d_e(a) = abs(time_start{1,2}(a) - time_day_end(a));
% %     end
% %     
% %     t_d_e_samples = time_to_ms(time_diff_d_e(1), time_diff_d_e(2), ...
% %         time_diff_d_e(3), time_diff_d_e(4),dt);
% %     
% %     t_samples = time_to_ms(time_desire{1,2}(1), time_desire{1,2}(2), ...
% %         time_desire{1,2}(3), time_desire{1,2}(4),dt);   
% %     
% %     t_start_ms = t_d_e_samples + t_samples; 
% % end
% % 
% % t_end_ms = t_start_ms + seconds_desire*fs;
% % xn_PA_time = xn_PA(t_start_ms:t_end_ms);
% % NSTFT = (rec_s/60)*1000;
% % 
% % [Gxx_array,dB_vals,t_array_big,f_array_big] = MYSpectrogram(...
% %     xn_PA_time',round(NSTFT),0.5,fs);
% 
% % Day ends
% % hour_time = 24;
% % min_time  = 0;
% % sec_time  = 0;
% % ms_time   = 0;
% % time_ms_day_end = time_to_ms(hour_time, min_time, sec_time, ms_time,dt);
% % 
% % % Starting time
% % hour_time = 20-4;
% % min_time  = 47;
% % sec_time  = 38;
% % ms_time   = 441;
% % time_ms_start = time_to_ms(hour_time, min_time, sec_time, ms_time,dt);
% % 
% % % time starting at this thing
% % hour_time = 5;
% % min_time  = 26;
% % sec_time  = 0;
% % ms_time   = 0;
% % time_ms_desire = time_to_ms(hour_time, min_time, sec_time, ms_time,dt);
% % 
% % % Length of period to sample
% % T = 100;
% % N = 10*fs;
% % 
% % % Figure out time difference in samples
% % time_ms_rest_of_day = time_ms_day_end-time_ms_start;
% % time_diff = time_ms_rest_of_day+time_ms_desire;
