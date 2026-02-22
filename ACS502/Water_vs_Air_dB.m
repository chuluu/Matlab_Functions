pref_air = 20*10^-6;
pref_wa = 1*10^-6;

dB_air = 20*log10(20/pref_air);
dB_wa  = 20*log10(20/pref_wa);

%%
pref_air = 20*10^-6;
pref_wa = 1*10^-6;

dB_val   = 85;
prms_air = pref_air*10^(dB_val/20)
prms_wa  = pref_wa*10^(dB_val/20)