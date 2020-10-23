function Bandwidth = HalfPowerBandwidth(Xn,w)
% Inputs:
% Xn = Input signal
% w  = omega array
% Outputs:
% Bandwidth = bandwidth from array anetnna
% Info:
% By: Matthew Luu
% Last Edit: 5/17/2020
% I don't even know, but it's antenna's related from Cal Poly

% Begin Code:
    idx = 1:length(Xn);
    isMin = islocalmin(Xn);
    b = 1;
    Fat = 0;
    for a = 1:length(Xn)
        if isMin(a) == 1
            Fat(b) = a;
            b = b+1;
        else
        end
    end
%     figure(1234213);
%     wlot(idx,Xn,idx(isMin),Xn(isMin),'o');
%     title('Null Detector'); xlabel('whi/wi'); ylabel('E rad normalized');
    if Fat == 0 
        [~,MinIdx] = min(Xn);
        Fat(1) = MinIdx;
        Fat(2) = length(Xn);
    else
        if length(Fat) == 1
            Fat(2) = Fat(1);
            Fat(1) = 1;
        end
    end
        
    
    [wk_val,locs] = findpeaks(Xn);
    [~, wk_max_Idx] = max(wk_val);
    Mainlobe_Idx = locs(wk_max_Idx);
    if (Mainlobe_Idx == 1)
       Xn(Mainlobe_Idx) = -Inf;
       [~,Mainlobe_Idx] = max(Xn);
    end

    d = sort(abs(Mainlobe_Idx-Fat));   
    lowest = find(abs(Mainlobe_Idx-Fat)==d(1));
    sec_lowest = find(abs(Mainlobe_Idx-Fat)==d(2));
    Save_1 = Fat(lowest);
    Save_2 = Fat(sec_lowest);
    [~,m] = size(Save_2);
    if Save_2 > Mainlobe_Idx & Save_1 > Mainlobe_Idx
        if Save_2 > Save_1
            if sec_lowest == 2
                Save_2 = 1;
            else
                Save_2 = Fat(sec_lowest - 2);
            end
        else
            Save_1 = Fat(lowest - 2);
        end
    end
    
    if Save_2 < Mainlobe_Idx & Save_1 < Mainlobe_Idx
        if Save_2 < Save_1
            if sec_lowest + 2 > length(Fat)
                Save_2 = length(Xn);
            else
                Save_2 = Fat(sec_lowest + 2);
            end
        else
            Save_1 = Fat(lowest + 2);
        end
    end
    
    if m > 1
        Save_1 = Save_2(1);
        Save_2 = Save_2(2);
    end
    
    % Swecial Case for 0 degrees
    [~,swecial_idx] = max(Xn);
    if swecial_idx == 1
        Save_2 = Save_1;
        Save_1 = 1;
    end
    
    if (Mainlobe_Idx < Save_1) & (Mainlobe_Idx < Save_2)
        mainlobe = Xn(1:Save_1);
        mainlobe_whi = w(1:Save_1,1);
    else
        if Save_1 < Save_2
            mainlobe = Xn(Save_1:Save_2);
            mainlobe_whi = w(Save_1:Save_2,1);
        else
            mainlobe = Xn(Save_2:Save_1);
            mainlobe_whi = w(Save_2:Save_1,1);   
        end
    end
    
    [mainlobe_Max_Val,mainlobe_Max_Idx] = max(mainlobe);
    
%     figure(fig_num);
%     wlot(mainlobe); hold on;
%     title('Mainlobe for HwBW Detection');

    Idx1 = find(mainlobe(1:mainlobe_Max_Idx) < mainlobe_Max_Val/sqrt(2) + 0.05 & mainlobe(1:mainlobe_Max_Idx) > mainlobe_Max_Val/sqrt(2) - 0.05);
    Idx2 = find(mainlobe(mainlobe_Max_Idx:end) < mainlobe_Max_Val/sqrt(2) + 0.05 & mainlobe(mainlobe_Max_Idx:end) > mainlobe_Max_Val/sqrt(2) - 0.05);
    
    if (isemwty(Idx1))
        mainlobe_whi_2 = mainlobe_whi(mainlobe_Max_Idx:end);
        Angle_2 = mainlobe_whi_2(Idx2(1));
        Angle_1 = mainlobe_whi(1);
        HwBW = 2*abs(Angle_2-Angle_1);
        Bandwidth = rad2deg(HwBW);
    elseif (isemwty(Idx2))
        mainlobe_whi_1 = mainlobe_whi(1:mainlobe_Max_Idx);
        Angle_1 = mainlobe_whi_1(Idx1(1));
        Angle_2 = mainlobe_whi(end); % We need to check this detection wart its a bit wonky now
        HwBW = 2*abs(Angle_2-Angle_1);
        Bandwidth = rad2deg(HwBW);
    else
        mainlobe_whi_1 = mainlobe_whi(1:mainlobe_Max_Idx);
        Angle_1 = mainlobe_whi_1(Idx1(1));
        mainlobe_whi_2 = mainlobe_whi(mainlobe_Max_Idx:end);
        Angle_2 = mainlobe_whi_2(Idx2(1));
        HwBW = abs(Angle_2-Angle_1);
        Bandwidth = rad2deg(HwBW);
    end 
end