function [x_playback,Gxx] = recording_background(fs,quantize,time_rec)
% [x_playback,Gxx] = recording_background(fs,quantize,time_rec)
% Inputs:
% fs = sampling rate
% quantize = quantization rate for signal
% time_rec = how long the time needs to be recorded
% Outputs: 
% x_playback = recorded signal
% Gxx = Gxx signal for x playback
% Info:
% By: Matthew Luu
% Last Edit: 10/1/2020
% records the background noise or signal through computer audio system

    recObj = audiorecorder(fs,quantize,1);
    disp('Recording Begins');
    recordblocking(recObj,time_rec);
    disp('Recording Ends');
    x_playback = getaudiodata(recObj)';
    dt = 1/fs;
    N = length(x_playback);
    t  = (0:1:N-1).*dt;
    subplot(2,1,1);
    plot(t,x_playback);
    title_plots('Recording Playback','Time (s)','Amplitude (Pa)',14)

    [Gxx,Sxx,f_Sxx,f_Gxx] = MyPSDX(x_playback,fs);
    
    subplot(2,1,2); 
    semilogy(f_Gxx,Gxx,'b','Linewidth',1.5);
    title_plots('Recording Playback Gxx','Freq (Hz)','Intensity (Pa^2/Hz)',14)
    xlim([0 max(f_Gxx)]);
end