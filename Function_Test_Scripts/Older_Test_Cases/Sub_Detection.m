%% Forward
clc 
clear
% This program is split into 5 parts, Data Set up, Variable set up,
% Plotting and peak data, Finding max correlation strength, and output.

% Data Set up: Input data and test to see if data is is working/found.

% Variable Set up: Cross correlate every direction with every ship signal
% to get a large array with all of the cross correlated data.

% Plotting and peak data: Find the peaks of each cross correlated data and
% co plot each echo with each direction.

% Find max correlation stength: Find the max of the peaks for each
% direction in order to determine the signals found in each direction.

% Output: Output each sub found and their locations. 

%% Set up Data

load('/Volumes/TarDisk/EE419/SubSonar.mat')
Fs = 50000;

[Cxy,t] = fftcorrnorm(AkulaSubEcho, StarboardQuarterEcho, Fs);

%% Signal Variable Set Up
Signals_Sent = [TxPulse; AkulaSubEcho; LosAngelesSubEcho; TyphoonSubEcho];
Signals_Echo = [DeadAheadEcho; StarboardBowEcho; StarboardBeamEcho; StarboardQuarterEcho; DeadAsternEcho; PortQuarterEcho; PortBeamEcho; PortBowEcho];
[a,b] = size(Signals_Echo);
[c,d] = size(Signals_Sent);

name_array_sig = ["TxPulse", "AkulaSubEcho", "LosAngelesSubEcho", "TyphoonSubEcho"];
name_array_dir = ["DeadAheadEcho", "StarboardBowEcho", "StarboardBeamEcho", "StarboardQuarterEcho", "DeadAsternEcho", "PortQuarterEcho", "PortBeamEcho", "PortBowEcho"];

%Pre-Allocate Memory
Cross_Cor_Data = zeros(32,131072);
Time_Data = zeros(32,131072);
p = 1;
count = 1;

% Cross correlate the two data sets and get a giant array with all the
% data. Data is broken into 4's so each direction has 4 pulses it looks at
% and 1-4 are the signals in each direction.
for outer = 1:a
    for index = 1:c
        [Cxy,t] = fftcorrnorm(Signals_Sent(index,:), Signals_Echo(outer,:), Fs);
        Cxy_peak = abs(hilbert(Cxy));
        Cross_Cor_Data(p,:) = Cxy_peak;
        Time_Data(p,:) = t;
        p = p+1;
    end
end

%% Plotting & Obtaining Peak Data

% Pre Allocate Memory
L = 0;
p = 1;
mag_loc_array_1st_peak = zeros(32,1);
time_loc_array_1st_peak = zeros(32,1);
mag_loc_array_2nd_peak = zeros(32,1);
time_loc_array_2nd_peak = zeros(32,1);

for O = 1:8
    for I = 1:4
        [A_real,peak_loc] = findpeaks(real(Cross_Cor_Data(L+I,:)),'MinPeakHeight',0.02);
        
        if isempty(A_real)
            Happy = 1; %Just to double check, dummy variable
        else
            %Decimate Akula Sub
            if (L+I == 2+L) 
                A_real = A_real(2:2:end);
                peak_loc = peak_loc(1:2:end);
            end

            % Populate location arrays
            if peak_loc(1) ~= 0
                time_loc = Time_Data(L+I,peak_loc(1));
                mag_loc_array_1st_peak(p,:) = A_real(1);
                time_loc_array_1st_peak(p,:) = time_loc;
            end

            if length(A_real) >= 2
                time_loc = Time_Data(L+I,peak_loc(end));
                mag_loc_array_2nd_peak(p,:) = A_real(end); 
                time_loc_array_2nd_peak(p,:) = time_loc;
            end
        end
        p = p + 1;
        
        % Plotting
        figure(O);
        title(name_array_dir(O));
        plot(Time_Data(L+I,:),Cross_Cor_Data(L+I,:)); xlabel('Time (s)'); ylabel('XCorr Magnitude'); hold on
        legend(name_array_sig(1),name_array_sig(2),name_array_sig(3),name_array_sig(4));
    end
    L = L+4;
end

%% Find the max of the peaks sections

% Pre-Allocate Memory
Dummy_array = zeros(4,1);
Dummy_array_2nd_peak = zeros(4,1);
Time_location = zeros(8,2);
Ship_Detected = zeros(8,2);
p = 0;
L = 0;

for O = 1:8
    for I = 1:4
        Dummy_array(I) = mag_loc_array_1st_peak(L+I,1);
        if (mag_loc_array_2nd_peak(L+I,1) > 0)
           Dummy_array_2nd_peak(I) = mag_loc_array_2nd_peak(L+I,1);
        end
    end
    
[Mag,Mag_Index] = max(Dummy_array);
Time_location(O,1) = time_loc_array_1st_peak(L+Mag_Index,1);

if Time_location(O,1) ~= 0
    Ship_Detected(O,1) = Mag_Index;
else
    Ship_Detected(O,1) = 0;
end

if (mag_loc_array_2nd_peak(L+I,1) > 0)
    [Mag_2,Mag_Index_2] = max(Dummy_array_2nd_peak);
    Time_location(O,2) = time_loc_array_2nd_peak(L+Mag_Index,1);
    if Time_location(O,2) ~= 0
        Ship_Detected(O,2) = Mag_Index_2;
    else
        Ship_Detected(O,2) = 0;
    end
end

L = L+4;
end
Meter_Location = (Time_location.*343)./(2);

%% Output
for O = 1:2
    for I = 1:8
        if Ship_Detected(I,O) == 0 
            disp(['No Subs at ',num2str(I)]);
        elseif Ship_Detected(I,O) == 2
            disp(['There is an Akula Russian Sub! at ',num2str(I)]);
        elseif Ship_Detected(I,O) == 3 
            disp(['There is a Los Angeles Sub! at ',num2str(I)]);
        elseif Ship_Detected(I,O) == 4
            disp(['There is a Typhoon Russian Sub! at ',num2str(I)]);
        elseif Ship_Detected(I,O) == 1
            disp(['ROCKS!!!! at ',num2str(I)]);
        end
    end
end

disp('DeadAhead = 1, StarboardBow = 2, StarboardBeam = 3, StarboardQuarter = 4'); 
disp('DeadAstern = 5, PortQuarter = 6, PortBeam = 7, PortBow = 8'); 