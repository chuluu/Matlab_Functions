function x_root = MyTranscendental_Solver(x,y,range,N)
% x_root = MyTranscendental_Solver(x,y,range,N)
% Inputs:
% x     = x array of data the roots
% y     = y array of data the function to be set == 0 
% range = range of values to ignore once solution found
% N     = How many solutions you wanna try and find
% Outputs:
% x_root = array of roots from solver
% Info:
% This function is kinda slow, but still pretty gold
% Begin Code

% Loop to find all solutions
    for a = 1:N
        % Find when function hits 0
        Idx = find_val(y,0,0.001,0.000001);
        x_root(a,:) = x(Idx);
        
        % Kill the old values
        if Idx(1)<range
            y(1:Idx+range) = 9999;
        else
            y(Idx-range:Idx+range) = 9999;
        end
    end
    
% Output the right roots
    x_root = x_root(:,1);
    x_root = sort(x_root); %--> These line up with wolfram perfectly!!!
end
