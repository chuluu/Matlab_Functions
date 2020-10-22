function CW = CW_pulse(f0,T_duration,T_toal_pulse,fs)
% CW = CW_pulse(f0,T_duration,T_toal_pulse,fs)
% Inputs:
% f0 = frequency of pulse
% T_duration = total duration of pulse is on
% T_total_pulse = total time the pulse signal
% fs = sampling rate
% Outputs:
% CW = pulse created

% Begin Code:
    dt     = 1/fs;
    N_tot  = round(T_toal_pulse*fs);
    N_dur  = round(T_duration*fs);

    CW = zeros(1,N_tot);
    t = (0:1:N_dur-1).*dt;
    CW(1:N_dur) = sin(2.*pi.*f0.*t);
    t_tot = (0:1:N_tot-1).*dt;
end