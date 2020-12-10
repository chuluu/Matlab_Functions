[y,fs] = audioread('ZaraExcerpt.wav');
[echo_filter_hn]= echo_filter([250 400 520 660 750 1220 ],[ 0.7 0.6 0.5 0.33 0.2 0.8],fs);

% dt = 1/fs;
% t = 0:dt:(length(hn)*dt)-dt;
% stem(t,echo_filter_hn);
% 
% y_echo_1 = fftconv(y(:,1),echo_filter_hn,fs,5);
% y_echo_2 = fftconv(y(:,2),echo_filter_hn,fs,5);
% y_echo = horzcat(y_echo_1,y_echo_2);

%%
processed_wav = equalize_and_reverb('Zarathustra.wav', [1,2,3,4,5,6,7,8,9], 2, 2, 'out.wav');

%%
[y,fs] = audioread('out.wav');