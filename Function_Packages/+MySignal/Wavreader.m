function [y,Fs] = Wavereader(file)
    % [y,Fs] = Wavereader(file)
    % Inputs:
    % file = file name for wav file
    % Outputs:
    % y  = time series of wav file
    % Fs = sampling rate of wav file
    % Info:
    % By: Matthew Luu
    % Last Edit: 8/16/2021
    % wav file reader to display properties and data
    % Link: https://www.mathworks.com/help/matlab/ref/audioread.html
    
    [y,Fs] = audioread(file); % Import the time series and sampling rate
    clc
    disp(audioinfo(file)); % Display audio info 
end