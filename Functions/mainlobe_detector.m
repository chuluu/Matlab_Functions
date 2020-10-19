function [mainlobe,mainlobe_ang_freq] = mainlobe_detector(Xn,w)
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
        MinIdx = 1;
        Fat(1) = MinIdx;
        Fat(2) = length(Xn);
    else
        if length(Fat) == 1
            Fat(2) = Fat(1);
            Fat(1) = 1;
        end
    end
        
    
    [pk_val,locs] = findpeaks(Xn);
    [~, pk_max_Idx] = max(pk_val);
    Mainlobe_Idx = locs(pk_max_Idx);
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
        mainlobe_ang_freq = w(1:Save_1);
    else
        if Save_1 < Save_2
            mainlobe = Xn(Save_1:Save_2);
            mainlobe_ang_freq = w(Save_1:Save_2);
        else
            mainlobe = Xn(Save_2:Save_1);
            mainlobe_ang_freq = w(Save_2:Save_1);   
        end
    end
end
