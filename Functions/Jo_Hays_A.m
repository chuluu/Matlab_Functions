function [Gxx_array,dB_vals,t_array_big,f_array_big] = ...
    Jo_Hays_A(wav_input,DSP_input,fs,choose)
% Inputs:
% wav_input      = class that contains {
%                  xn              = data set in WU
%                  bits            = # of bits recorded for (bits/WU)
%                  bit conversion  = given by DAQ (V/bits)
%                  sensitvity      = mic sensitivity (V/Pa)
%                  gain            = gain of system mic (dimensionless)}
% DSP_input      = class that contains {
%                  time_desire    = time to begin collecting data
%                  seconds_desire = window of time for data collection
%                  NSTFT          = # of samples
%                  overlap        = overlap %}
% fs             = sampling rate
% choose         = 1 = spectrogram, 2 = avgGxx
% Outputs:
% Gxx_array   = array of Gxx values in spectrogram
% dB_vals     = dB_vals of Gxx_array
% t_array_big = time array for spectrogram
% f_array_big = frequency array for spectrogram 

    xn_PA = WU_to_PA(wav_input);
    if choose == 1
        [Gxx_array,dB_vals,t_array_big,f_array_big] = ...
        Spectrogram_Section_Jo_Hays_PA(xn_PA,DSP_input,fs);
    else
        [Gxx_avg,f_Gxx] = AvgGxx_Section_Jo_Hays_PA(xn_PA,DSP_input,fs);
        Gxx_array   = Gxx_avg;
        f_array_big = f_Gxx;
        t_array_big = 0;
        dB_vals     = 0;
    end
        
end

function xn_PA = WU_to_PA(wav_input)
% Inputs:
% wav_input      = class that contains {xn, bits, bit conversion,
%                  sensitvity, gain}
% Outpus:
% xn_PA          = xn in pascals rather than waveform units

    xn            = wav_input{2,1};
    bits          = wav_input{2,2};
    bits_to_volts = wav_input{2,3};
    sensitivity   = wav_input{2,4};
    Gain          = wav_input{2,5};
    
    WU_to_bits    = 2^(bits-1);   % bits/WU
    xn_volts      = xn.*WU_to_bits.*bits_to_volts; % volts
    xn_PA         = (xn_volts/(sensitivity*Gain));
end

function [Gxx_array,dB_vals,t_array_big,f_array_big] = ...
    Spectrogram_Section_Jo_Hays_PA(xn_PA,DSP_input,fs)

    lat1_in = [40,43,1];
    lon1_in = [-77,-53,-38.5];
    lat2_in = [40,47,18];
    lon2_in = [-77,-52,-31];

    dist = distanceInKmBetweenEarthCoordinates(lat1_in, lon1_in,...
        lat2_in, lon2_in);

    time = (dist*10^3)/343.8443; % m , %m/s
    time_delay = round(time*10^3);
    
    time_desire    = DSP_input{2,1};
    seconds_desire = DSP_input{2,2};
    NSTFT          = DSP_input{2,3};
    overlap        = DSP_input{2,4};
    
    dt = 1/fs;    
    time_start     = {'2011-07-27',[16,47,38,441]};
    time_day_end   = [23,59,59,999];

    if time_desire{1,1} == '2011-07-27'
        for a = 1:length(time_desire{1,2})
            time_diff(a) = abs(time{1,2}(a) - time_start{1,2}(a));
        end

        t_start_ms = time_to_ms(time_diff(1), time_diff(2), ...
            time_diff(3), time_diff(4),dt);

    elseif time_desire{1,1} == '2011-07-28'
        for a = 1:length(time_desire{1,2})
            time_diff_d_e(a) = abs(time_start{1,2}(a) - time_day_end(a));
        end

        t_d_e_samples = time_to_ms(time_diff_d_e(1), time_diff_d_e(2), ...
            time_diff_d_e(3), time_diff_d_e(4),dt);

        t_samples = time_to_ms(time_desire{1,2}(1), time_desire{1,2}(2), ...
            time_desire{1,2}(3), time_desire{1,2}(4),dt);   

        t_start_ms = t_d_e_samples + t_samples+1 + time_delay + 1;
    end

    t_end_ms = t_start_ms + seconds_desire*fs;
    xn_PA_time = xn_PA(t_start_ms:t_end_ms);
    length(xn_PA_time);
    
%     hn_lp = FIR_Filter_By_Window(length(xn_PA_time),0.4,hann(length(xn_PA_time)));
%     [xn_PA_time,t] = fftconv(xn_PA_time,hn_lp,fs,5);
    
    [Gxx_array,dB_vals,t_array_big,f_array_big] = MYSpectrogram(...
        xn_PA_time',round(NSTFT),overlap,fs);
    title(['Time: ',time_desire{1,1},' ',num2str(time_desire{1,2}(1)),':',...
    num2str(time_desire{1,2}(2)),':',num2str(time_desire{1,2}(3)),':',...
    num2str(time_desire{1,2}(4)),' EDT, For: ',num2str(seconds_desire),...
    's, Overlap: ', num2str(overlap*100), '%, NFFT: ',num2str(NSTFT)],...
    'Fontsize',14);
end

function [Gxx_avg,f_Gxx] = ...
    AvgGxx_Section_Jo_Hays_PA(xn_PA,DSP_input,fs)

    time_desire    = DSP_input{2,1};
    seconds_desire = DSP_input{2,2};
    NSTFT          = DSP_input{2,3};
    overlap        = DSP_input{2,4};

    dt = 1/fs;    
    time_start     = {'2011-07-27',[16,47,38,441]};
    time_day_end   = [23,59,59,999];
   
    lat1_in = [40,43,1];
    lon1_in = [-77,-53,-38.5];
    lat2_in = [40,47,18];
    lon2_in = [-77,-52,-31];

    dist = distanceInKmBetweenEarthCoordinates(lat1_in, lon1_in,...
        lat2_in, lon2_in);

    time = (dist*10^3)/343.8443; % m , %m/s
    time_delay = round(time*10^3);
    
    if time_desire{1,1} == '2011-07-27'
        for a = 1:length(time_desire{1,2})
            time_diff(a) = abs(time{1,2}(a) - time_start{1,2}(a));
        end

        t_start_ms = time_to_ms(time_diff(1), time_diff(2), ...
            time_diff(3), time_diff(4),dt) + time_delay;

    elseif time_desire{1,1} == '2011-07-28'
        for a = 1:length(time_desire{1,2})
            time_diff_d_e(a) = abs(time_start{1,2}(a) - time_day_end(a));
        end

        t_d_e_samples = time_to_ms(time_diff_d_e(1), time_diff_d_e(2), ...
            time_diff_d_e(3), time_diff_d_e(4),dt);

        t_samples = time_to_ms(time_desire{1,2}(1), time_desire{1,2}(2), ...
            time_desire{1,2}(3), time_desire{1,2}(4),dt);   

        t_start_ms = t_d_e_samples + t_samples + time_delay + 1;
    end

    t_end_ms = t_start_ms + seconds_desire*fs;
    xn_PA_time = xn_PA(t_start_ms:t_end_ms);
    length(xn_PA_time);
    
%     hn_lp = FIR_Filter_By_Window(length(xn_PA_time),0.7,hann(length(xn_PA_time))); 
%     [xn_PA_time,t] = MyFFTConv(xn_PA_time,hn_lp,fs);

    [Gxx_avg,f_Gxx] = MyAvgGxx_Overlap(xn_PA_time',NSTFT,overlap,fs);
    semilogy(f_Gxx,Gxx_avg);
    titled = ['Time: ',time_desire{1,1},' ',num2str(time_desire{1,2}(1)),':',...
        num2str(time_desire{1,2}(2)),':',num2str(time_desire{1,2}(3)),':',...
        num2str(time_desire{1,2}(4)),' EDT, For: ',num2str(seconds_desire), 's'];
    
    title_plots(titled ,'Freq (Hz)','Intensity (WU^2/Hz)',14);

end

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
