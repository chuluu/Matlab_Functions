function [touch_tone,High_Freq,Low_Freq] = tone_detector_func(Tone_FFT,f)
%This function Outputs the low and high frequencies for a touch tone pad
%Inputs
%Tone_FFT = Input the abs(FFT) for all frequencies from 0 - 0.5 Digital Freq
%f        = ANALOG Frequency from 0 to whatever frequency

%Outputs
%touch_tone = the actual pad number value in a str on num form 
%High_Freq  = the higher frequency value for one detection
%Low_Freq   = the lower frequency value for the second detection


% Lets Look For Low Frequencies!
% Final point of 650
data_650 = find((f < 650));
point_650 = data_650(end);


%first pint of 950
data_950 = find((f > 950));
point_950 = data_950(1);

% Data Manipulate 650-950 and Finds Low Frequency Tone
f_650_950 = f(point_650:point_950);
New_FFT_tone_650_950 = Tone_FFT(point_650:point_950);
[max_low_val, max_low_index] = max(New_FFT_tone_650_950);
Low_Freq = f_650_950(max_low_index);
%disp(['The Lower Frequency is ',num2str(Low_Freq)])


% Lets look for high frequencies!
% first pint of 1180
data_1180 = find((f > 1180));
point_1180 = data_1180(1);

% Final point of 1500
data_1500 = find((f < 1500));
point_1500 = data_1500(end);

% Data Manipulate 1180-1500 and Finds High Frequency Tone
f_1180_1500 = f(point_1180:point_1500);
New_FFT_tone_1180_1500 = Tone_FFT(point_1180:point_1500);
[max_high_val, max_high_index] = max(New_FFT_tone_1180_1500);
High_Freq = f_1180_1500(max_high_index);
%disp(['The Upper Frequency is ',num2str(High_Freq)])

% Detection based off of frequencies If Statements
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
if (687 < Low_Freq) && (Low_Freq< 707)
    if (1199 < High_Freq) && (High_Freq < 1219)
        %disp(['Touch Tone #1!']);
        touch_tone = 1;
    elseif (1326 < High_Freq) && (High_Freq < 1346)
        %disp(['Touch Tone #2!']);
        touch_tone = 2;
    elseif (1467 < High_Freq) && (High_Freq < 1487)
        %disp(['Touch Tone #3!']);
        touch_tone = 3;
    end

elseif (760 < Low_Freq) && (Low_Freq< 780)
    if (1199 < High_Freq) && (High_Freq < 1219)
        %disp(['Touch Tone #4!']);
        touch_tone = 4;
    elseif (1326 < High_Freq) && (High_Freq < 1346)
        %disp(['Touch Tone #5!']);
        touch_tone = 5;
    elseif (1467 < High_Freq) && (High_Freq < 1487)
        %disp(['Touch Tone #6!']);
        touch_tone = 6;
    end
   
elseif (842 < Low_Freq) && (Low_Freq< 862)
    if (1199 < High_Freq) && (High_Freq < 1219)
        %disp(['Touch Tone #7!']);
        touch_tone = 7;
    elseif (1326 < High_Freq) && (High_Freq < 1346)
        %disp(['Touch Tone #8!']);
        touch_tone = 8;
    elseif (1467 < High_Freq) && (High_Freq < 1487)
        %disp(['Touch Tone #9!']);
        touch_tone = 9;
    end
    
elseif (931 < Low_Freq) && (Low_Freq< 951)
    if (1199 < High_Freq) && (High_Freq < 1219)
        %disp(['Touch Tone Star!']);
        touch_tone = 10;
    elseif (1326 < High_Freq) && (High_Freq < 1346)
        %disp(['Touch Tone #0!']);
        touch_tone = 0;
    elseif (1467 < High_Freq) && (High_Freq < 1487)
        %disp(['Touch Tone Hash!']);
        touch_tone = 11;
    end
end
end


