%% Program will detect the tones

% this program is made into 4 sections, load data, set up FFT, parse data
% into low and high frequency sets, and locate/detect tones based on
% frequency.

%Load Data: Enter in data set
%FFT: Take FFT of array to understand spectrum
%Parse Data: split data into low and high frequency ranges of where the
%tones could be.
%Low Freq: 650 - 950
%High Freq: 1180-1500 
%Detect tones: If statements based on maximums of parsed data. 
clc
clear all

%% Setup Data
load('/Volumes/TarDisk/EE419/touchtones.mat')
Fs = 8000;

%% FFT Data

% Set up FFT
[Tone_FFT,f] = MyFFT(tone_1,Fs);

% Getting rid of negative frequencies
point_0 = find((f == 0));
New_FFT_tone = [abs(Tone_FFT(2:point_0))];
f_NEW = f(point_0+1:end);

%% Parse data into low and high frequency sets
% Lets Look For Low Frequencies!
% Final point of 650
data_650 = find((f_NEW < 650));
point_650 = data_650(end);


%first pint of 950
data_950 = find((f_NEW > 950));
point_950 = data_950(1);

% Data Manipulate 650-950 and Finds Low Frequency Tone
f_650_950 = f_NEW(point_650:point_950);
New_FFT_tone_650_950 = New_FFT_tone(point_650:point_950);
[max_low_val, max_low_index] = max(New_FFT_tone_650_950);
Low_Freq = f_650_950(max_low_index);
disp(['The Lower Frequency is ',num2str(Low_Freq)])


% Lets look for high frequencies!
% first pint of 1180
data_1180 = find((f_NEW > 1180));
point_1180 = data_1180(1);

% Final point of 1500
data_1500 = find((f_NEW < 1500));
point_1500 = data_1500(end);

% Data Manipulate 1180-1500 and Finds High Frequency Tone
f_1180_1500 = f_NEW(point_1180:point_1500);
New_FFT_tone_1180_1500 = New_FFT_tone(point_1180:point_1500);
[max_high_val, max_high_index] = max(New_FFT_tone_1180_1500);
High_Freq = f_1180_1500(max_high_index);
disp(['The Upper Frequency is ',num2str(High_Freq)])

%% Detection based off of frequencies and IF Statements 
%1: 697, 1209 
%2: 697, 1336
%3: 697, 1477
%4: 770, 1209
%5: 770, 1336
%6: 770, 1477
%7: 852, 1209
%8: 852, 1336
%9: 852, 1477
%star: 941, 1209
%0: 941, 1336
%Hash: 941, 1477

plot(f,abs(Tone_FFT)); title('Test Tone DFT'); xlabel('Analog Frequency (Hz)');
ylabel('Normalized Magnitude');
if (695.5 < Low_Freq) && (Low_Freq< 698.5)
    if (1207.5 < High_Freq) && (High_Freq < 1210.5)
        disp(['Touch Tone #1!']);
        text(-500, 0.2, 'Key 1', 'FontSize',24);
        
    elseif (1334.5 < High_Freq) && (High_Freq < 1337.5)
        disp(['Touch Tone #2!']);
        text(-500, 0.2, 'Key 2', 'FontSize',24);
    elseif (1475.5 < High_Freq) && (High_Freq < 1478.5)
        disp(['Touch Tone #3!']);
        text(-500, 0.2, 'Key 3', 'FontSize',24);
    end

elseif (768.5 < Low_Freq) && (Low_Freq< 771.5)
    if (1207.5 < High_Freq) && (High_Freq < 1210.5)
        disp(['Touch Tone #4!']);
        text(-500, 0.2, 'Key 4', 'FontSize',24);
    elseif (1334.5 < High_Freq) && (High_Freq < 1337.5)
        disp(['Touch Tone #5!']);
        text(-500, 0.2, 'Key 5', 'FontSize',24);
    elseif (1475.5 < High_Freq) && (High_Freq < 1478.5)
        disp(['Touch Tone #6!']);
        text(-500, 0.2, 'Key 6', 'FontSize',24);
    end
   
elseif (850.5 < Low_Freq) && (Low_Freq< 853.5)
    if (1207.5 < High_Freq) && (High_Freq < 1210.5)
        disp(['Touch Tone #7!']);
        text(-500, 0.2, 'Key 7', 'FontSize',24);
    elseif (1334.5 < High_Freq) && (High_Freq < 1337.5)
        disp(['Touch Tone #8!']);
        text(-500, 0.2, 'Key 8', 'FontSize',24);
    elseif (1475.5 < High_Freq) && (High_Freq < 1478.5)
        disp(['Touch Tone #9!']);
        text(-500, 0.2, 'Key 9', 'FontSize',24);
    end
    
elseif (939.5 < Low_Freq) && (Low_Freq< 942.5)
    if (1207.5 < High_Freq) && (High_Freq < 1210.5)
        disp(['Touch Tone Star (*)!']);
        text(-500, 0.2, 'Key *', 'FontSize',24);
    elseif (1334.5 < High_Freq) && (High_Freq < 1337.5)
        disp(['Touch Tone #0!']);
        text(-500, 0.2, 'Key 0', 'FontSize',24);
    elseif (1475.5 < High_Freq) && (High_Freq < 1478.5)
        disp(['Touch Tone Hash(#)!']);
        text(-500, 0.2, 'Key #', 'FontSize',24);
    end
end


