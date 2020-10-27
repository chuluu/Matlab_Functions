function processed_wav = equalize_and_reverb(inwavfilename, EQdBsettings, Dk_delays_msec, alphak_gains, outwavfilename)
% processed_wav = equalize_and_reverb(inwavfilename, EQdBsettings, Dk_delays_msec, alphak_gains, outwavfilename);
%Inputs: 
%inwavfilename = name of wavefile needed to be equalized and reverbed
%EQdBsettings = array of Decibal level for each frequency range in of [62.5, 125, 250, 500, 1e3, 2e3, 4e3, 8e3, 16e3]
%Dk_delays_msec = array of delay points in msec
%alphak_gains = gain at each delay point
%outwavfilename = name of new output wavefile after processesing
%Outputs:
%processed_wav = the impulse response of the echo 
% Info:
% By: Matthew Luu 
% Last edit: 3/17/2019
 
% Begin Code:
[y, fs] = audioread(inwavfilename);
freqs = [62.5, 125, 250, 500, 1e3, 2e3, 4e3, 8e3, 16e3] / fs;

% dB value of gain
eq = EQdBsettings;

eq = [eq, fliplr(eq)];
freqs = [freqs, fliplr(1 - freqs)];

M = 1 / (62.5 / fs);
Fd = 0:1/M:1-1/M;

f = fit(freqs', eq', 'linearinterp');
HF_mag = 10.^(f(Fd)' / 20);

[hn, ~, ~] = FIR_Filter_By_Freq_Sample(HF_mag, 2);
hn = hn .* tukeywin(length(hn))';
reverb_hn = echo_filter(Dk_delays_msec, alphak_gains, fs);

% convolve equailizer and echo impulse responses
composite_hn = fftconv(hn, reverb_hn)';

if size(y, 2) == 2
    y_filt1 = fftconv(composite_hn, y(:,1));
    y_filt2 = fftconv(composite_hn, y(:,2));
    
    m1 = max(abs(y_filt1));
    m2 = max(abs(y_filt2));
    m = max(m1, m2);
    
    y_filt1 = y_filt1 ./ m;
    y_filt2 = y_filt2 ./ m;
    
    y_filt = [y_filt1, y_filt2];
else
    y_filt = fftconv(composite_hn, y);
    
    m = max(abs(y_filt));
    
    y_filt = y_filt / m;
end

audiowrite(outwavfilename, y_filt, fs);

processed_wav = y_filt;

end

function [echo_filter_hn] = echo_filter(Dk_delays_msec,alphak_gains,fs)
%Inputs: 
%Dk_delays_msec = array of delay points in msec
%alphak_gains = gain at each delay point
%fs = sampling rate
%Outputs:
%echo_filter_hn = the impulse response of the echo 
 
D = round(Dk_delays_msec*10^-3.*fs);
hn = [zeros(1,D(1)),alphak_gains(1)];
 
for n = 1:1:length(D)
    if (1 < n)
        Delay = D(n) - D(n-1);
        intermediate = [zeros(1,Delay),alphak_gains(n)];
        hn = [hn,intermediate]; 
    end
end
 
echo_filter_hn = hn;
end

function yn = fftconv(xn, hn)
%FFTCONV Fast convolution using fft
% Inputs:
% xn - sequence to filter
% hn - filte rimpulse response

% Outpus:
% yn - result of fast convolution from xn and hn
Mx = length(xn);
Mh = length(hn);
M = Mx + Mh;
Mfft = 2.^nextpow2(M);

Xk = fft(xn, Mfft);
Hk = fft(hn, Mfft);

Yk = Xk .* Hk;
yn = real(ifft(Yk));
yn = yn(1:M-1);

Fd = 0:1/(length(Hk)-1):1;

figure
subplot(3,2,1)
stem(xn, 'Marker', '.', 'LineWidth', 2, 'MarkerSize', 20);
title("x[n] Sequence");
xlabel("Sample n");
ylabel("Amplitude");
grid on
subplot(3,2,2)
plot(Fd, abs(Xk));
title("X[k] Spectrum");
xlabel("Digital Frequency F [cycles/sample]");
ylabel("Magnitude");
grid on

subplot(3,2,3)
stem(hn, 'Marker', '.', 'LineWidth', 2, 'MarkerSize', 20);
title("h[n] Sequence");
xlabel("Sample n");
ylabel("Amplitude");
grid on
subplot(3,2,4)
plot(Fd, abs(Hk));
title("H[k] Spectrum");
xlabel("Digital Frequency F [cycles/sample]");
ylabel("Magnitude");
grid on

subplot(3,2,5)
stem(yn, 'Marker', '.', 'LineWidth', 2, 'MarkerSize', 20);
title("y[n] Sequence");
xlabel("Sample n");
ylabel("Amplitude");
grid on
subplot(3,2,6)
plot(Fd, abs(Yk));
title("Y[k] Spectrum");
xlabel("Digital Frequency F [cycles/sample]");
ylabel("Magnitude");
grid on

end

function [hn, HF, F] = FIR_Filter_By_Freq_Sample(HF_mag_samples, figurenum)
% hn - impulse response of filter (same length as HF_mag_samples)
% HF - complex frequency response of filter
% (estimated H(F) values found by FFT or freqz)
% F ? digital frequency values corresponding to the estimated H(F)values
% HF_mag_samples ? H[k] Magnitude response samples for desired filter
% figurenum - Figure # to plot frequency responses

    M  = length(HF_mag_samples);
    dF = 1/M;
    F  = 0:dF:(M-1)/M;
    
    if mod(M, 2) == 0
       disp('provide an odd number of samples')
       
       hn = [];
       HF = [];
       F  = [];
       
       return;
    end
    
    % compute phase at each sample
    phase = zeros(M, 0);
    
    for k = 0:M-1
        phase(k+1) = exp(-j*pi*k*(M-1)/M);
    end
    
    % combine magnitude and phase components of frequency response
    HF = HF_mag_samples .* phase;
    
    hn = real(ifft(HF));
    
    % higher resolution FFT for plot
    M_hr  = 512;
    HF_hr = fft(hn, M_hr);
    F_hr  = 0:1/M_hr:(M_hr-1)/M_hr;
    
 
    figure(figurenum);
    subplot(2, 1, 1);
    title('Frequency Response');
    ylabel('Magnitude');
    xlabel('Digital Frequency (cyc/s)');
    hold on;
    stem(F, abs(HF));
    plot(F_hr, abs(HF_hr));
    
    subplot(2, 1, 2);
    ylabel('Phase');
    xlabel('Digital Frequency (cyc/s)');
    hold on;
    stem(F, angle(HF)/pi);
    plot(F_hr, angle(HF_hr)/pi);
    
    mag_dB = 20*log10(abs(HF_hr));
    
    figure(figurenum+1);
    
    plot(F_hr, mag_dB);
    title('Magnitude Response');
    ylabel('Magnitude (dB)');
    xlabel('Digital Frequency (cyc/s)');
    
end





