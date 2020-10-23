function Idx = find_val(fnc,val,del_start,iteration_val)
% Idx = find_val(fnc,val,del_start,iteration_val)
% Inputs:
% fnc           = function needing to be swept through
% val           = value needing to be found
% del_start     = initial tolerance band guess
% iteration_val = tolerance band tightener after each iteration
% Outputs:
% Idx   = Index in the array of fnc that found val
% Info:
% By: Matthew Luu
% Quite slow solver, but works, finds the point within a tolerance band,
% tightens the tolerance band until a single/2 solutions are found

% Begin Code

% initialize variables
    del = del_start; 
    Idx = find(fnc < val + del & fnc > val - del);
    [~,Soln] = size(Idx);
    a = 1;
    del_change = 0;
    
    %disp(['start']);
    %tic
    flag = 1; % If flag = 0, then solution has been found
    while (flag == 1)
        % Finding solution
        while (Soln > 2)
            del = del_start - del_change; % Tolerance factor val +/- del
            Idx = find(fnc < val + del & fnc > val - del); 
            [~,Soln] = size(Idx);
            del_change = iteration_val*a; % Change the del
            a = a+1;
            if a >100000
                % Counter to abort if the solution is hung
                flag = 0;
                Soln = 0.000123123;
                break;
            end
        end
        
        % If the solution oversteps (i.e. finds 0 solutions because
        % iteration_val was too small, then restart process)
        if (Soln == 0)
            flag = 1;
            iteration_val = iteration_val/10;
            Soln = 20;
        else
            flag = 0;
        end
        
    end
    
    %disp(['end']);
    %toc
end