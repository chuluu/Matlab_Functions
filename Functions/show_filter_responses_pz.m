function [Ak,Bk,HF,Fd,hn,n,max_val] = show_filter_responses_pz(poles,zeros,K,fsample,num_of_f_points, num_of_n_points,figure_num)
% This code will take poles, zeros, sampling rate, number of frequency points,
% number of unit sample response points and figure number 
% to output the Ak, Bk coefficients, Transfer function, Frequency, unit sample response, unit and sample index
% The code will also display 3dB Frequencies, peak and min
% values/frequencies attenuation, and bandwidth

%% Preliminary Pz Data
Ak = poly(poles);
Bk = K*poly(zeros);
H = tf(Bk,Ak,1/fsample) %Prints Transfer function
disp(['Ak coefficients are equal to ',num2str(Ak),'.']) %Print Ak to screen
disp(['Bk coefficients are equal to ',num2str(Bk),'.']) %Print Bk to screen

%% Pzmap
figure(figure_num);
zplane(Bk,Ak);
title('PZ Map'); xlabel('Real'); ylabel('Imag');

%% Frequency Response
[HF, W] = freqz(Bk, Ak, num_of_f_points);
Fd = W./(2.*pi);
plot_freq_responses(Fd, HF, fsample, figure_num+1)

%% hn
[hn, n] = unit_sample_response(Bk, Ak, num_of_n_points, figure_num+3);

%% Peak Response
HF_mag = abs(HF);
[max_val, max_index] = max(abs(HF));
max_freq = Fd(max_index);
max_val_dB = 20*log10(max_val);
[max_val_dB_val,max_dB_index]  = max(20*log10(HF_mag));
max_val_dB_Freq = Fd(max_dB_index);

%% min response
[min_val, min_index] = min(abs(HF));
min_freq = Fd(min_index);
[min_val_dB_val,min_dB_index]  = min(20*log10(HF_mag));
min_val_dB_Freq = Fd(min_dB_index);

%% Attenuation

attenuation = max_val_dB_val-min_val_dB_val;

%% 3 dB down point
dB3_Val = max_val*0.707;
db3 = max_val_dB - 3;
dB3idx = find( 20*log10(abs(HF)) < db3 ); % find the array indices for values in A that are >1
Fd_ALL_3dB = Fd(dB3idx); % get all the actual values of A that are >1
First_3dB_old = Fd(dB3idx(1)); % get just the 1st value of A that is >1
Last_3dB = Fd(dB3idx(length(dB3idx)));

if (First_3dB_old == 0)
    dB3idx = find( 20*log10(abs(HF)) > db3 ); % find the array indices for values in A that are >1
    Fd_ALL_3dB = Fd(dB3idx); % get all the actual values of A that are >1
    First_3dB = Fd(dB3idx(1)); % get just the 1st value of A that is >1
    Last_3dB = Fd(dB3idx(length(dB3idx)));
end

if (First_3dB_old == 0)
    First_3dB;
else 
    First_3dB = First_3dB_old;
end

%% Display Window
disp(['The 3dB Value is equal to ',num2str(dB3_Val),'.']) %Prints Last_3dB Point

disp(['The First_3dB Digital Frequency is equal to ',num2str(First_3dB),'cyc/sample.']) %Prints First_3dB Point

disp(['The Last_3dB Digital Frequency is equal to ',num2str(Last_3dB),'cyc/sample.']) %Prints Last_3dB Point

%-------
disp(['The peak Response Value is equal to ',num2str(max_val),'.']) %Prints max val

disp(['The peak Digital Frequency is equal to ',num2str(max_val_dB_Freq),'cyc/sample.']) %Prints max freq

%-------
disp(['The minimum Response Value is equal to ',num2str(min_val),'.']) %Prints min val

disp(['The minimum value Digital Frequency is equal to ',num2str(min_val_dB_Freq),'cyc/sample.']) %Prints min freq

%-------
disp(['The attenuation is equal to ',num2str(attenuation),'dB.']) %Prints attenuation

%% Figure out the filter (low-pass, high-pass, band-pass or band-stop (notch) filter)
if (First_3dB_old == 0)
    if (min_freq == 0) && (Last_3dB == Fd(end))
        disp('This filter is a high-pass!')
        dB3_BW = Fd(end) - First_3dB;
        BW_analog = dB3_BW*fsample;
        
    elseif (min_val_dB_Freq == 0 || min_val_dB_Freq == Fd(end))
        disp('This filter is a bandpass-filter!')
        dB3_BW = Last_3dB - First_3dB;
        BW_analog = dB3_BW*fsample;
    end
end

if (max_val_dB_Freq == 0) & (Last_3dB == Fd(end))
    disp('This filter is a low-pass!')
    dB3_BW = First_3dB - 0;
    BW_analog = dB3_BW*fsample;
    
elseif (max_val_dB_Freq == 0 || max_val_dB_Freq == Fd(end)) && (Last_3dB <0.4999) && (min_val_dB_val<-30)
    disp('This filter is a notch-filter!')
    dB3_BW = Last_3dB - First_3dB;
    BW_analog = dB3_BW*fsample;
end

disp(['The Digital BandWidth is equal to ',num2str(dB3_BW),'cyc/sample.']) %Prints Digital Bandwidth

disp(['The Analog BandWidth is equal to ',num2str(BW_analog),'Hz.']) %Prints Analog Bandwidth

end
