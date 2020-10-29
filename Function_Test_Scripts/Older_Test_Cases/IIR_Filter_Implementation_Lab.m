%% Acheive Scale Factor correction

scale_factor = 512;
Ak_scaled_no_round =  Ak * scale_factor;
Bk_scaled_no_round =  Bk * scale_factor;
Akscaled = round(Ak * scale_factor)./scale_factor;
Bksclaed = round(Bk * scale_factor)./scale_factor;

%disp(['Ak_scaled coefficients are equal to ',num2str(Akscaled),'.']) %Print Ak to screen
%disp(['Bk_scaled coefficients are equal to ',num2str(Bksclaed),'.']) %Print Bk to screen

[poles,zeros,HF_2,Fd_2,hn_2,n_2] = show_filter_responses([Akscaled],[Bksclaed],48000,100000,40,1);

Error = ((Bk - Bksclaed)./Bk).*100;
disp(['Error_Bk coefficients are equal to ',num2str(Error),'.']) %Print Ak to screen

mag_pol = abs(zeros)
ang_pol = angle(zeros)

%% Lattice Struct
Fs = 48000;
scale_factor = 512;
Akscaled = round(Ak .* scale_factor)./scale_factor;
Bksclaed = round(Bk .* scale_factor)./scale_factor;

%Lattice With Ak and Bk floating pt
[dn ,n] = unit_sample(100000);
[m,C] = tf2latc(Bk,Ak);
C = C.*100000;
m;
y = latcfilt(m,C,dn);
%[X_exact,Fd_exact] = plot_DFT_mag(y,Fs,10);

%plot_freq_responses(Fd_exact(1:end/2), X_exact(1:end/2), Fs, 1);

%Lattice With scaled Ak and Bk 
m_scaled = round(m .* scale_factor)./scale_factor
C_scaled = round(C .* scale_factor)./scale_factor
y_scaled = latcfilt(m_scaled,C_scaled,dn);
%[Y_scaled,Fd] = plot_DFT_mag(y_scaled,Fs,11);

%plot_freq_responses(Fd(1:end/2), Y_scaled(1:end/2), Fs, 4);