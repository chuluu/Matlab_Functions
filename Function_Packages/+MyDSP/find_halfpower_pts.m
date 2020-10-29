function [w1,w2] = find_halfpower_pts(mainlobe,w)
% [w1,w2] = find_halfpower_pts(mainlobe,w)
% Inputs: 
% mainlobe = function needing to be found
% w        = frequency array (or angular)
% Outputs: 
% w1       = point lower frequency (or angular)
% w2       = point higher frequency (or angular)
% Info:
% By: Matthew Luu 
% Last edit: 10/20/2020
% find half power points of a transfer function

    [mainlobe_Max_Val,mainlobe_Max_Idx] = max(mainlobe);
    mainlobe_w_1 = w(1:mainlobe_Max_Idx);
    mainlobe_w_2 = w(mainlobe_Max_Idx:end);
    
    mainlobe_1   = mainlobe(1:mainlobe_Max_Idx);
    mainlobe_2   = mainlobe(mainlobe_Max_Idx:end);
    halfpower_pt = mainlobe_Max_Val/sqrt(2);
    
   
    iteration_val = 0.001;
    Idx1 = MyGen.find_val(mainlobe_1,halfpower_pt,0.01,iteration_val);
    iteration_val = 0.001;
    Idx2 = MyGen.find_val(mainlobe_2,halfpower_pt,0.01,iteration_val);

    if (isempty(Idx1))
        w2 = mainlobe_w_2(Idx2(1));
        w1 = mainlobe_w(1);
    elseif (isempty(Idx2))
        w1 = mainlobe_w_1(Idx1(1));
        w2 = mainlobe_w(end); % We need to check this detection wart its a bit wonky now
    else
        w1 = mainlobe_w_1(Idx1(1));
        w2 = mainlobe_w_2(Idx2(1));
    end 
end