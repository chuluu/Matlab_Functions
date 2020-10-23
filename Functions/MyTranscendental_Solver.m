function x_root = MyTranscendental_Solver(x,y,range,initial_del,del_step)
% x_root = MyTranscendental_Solver(x,y,range,N)
% Inputs:
% x     = x array of data the roots
% y     = y array of data the function to be set == 0 
% range = range of values to ignore once solution found
% initial_del = initial tolerance band 
% del_step    = tolerance band step change
% Outputs:
% x_root = array of roots from solver
% Info:
% This function is kinda slow, but still pretty gold, it requires the
% find_val function
% By: Matthew Luu
% Last edit: 10/23/2020

% Begin Code
if nargin < 4
    initial_del = (x(5)-x(4))*100;

end

if nargin < 5
    del_step   = (x(5)-x(4))*10;
end

N = 100;
x_root = [];
% Loop to find all solutions
    for a = 1:N
        % Find when function hits 0 using iterative finding close to 0
        Idx = find_val(y,0,initial_del,del_step);
        
        % Check when done with all solutions
        [m,n] = size(Idx);
        if n == 0
            flag = isempty(x_root);
            if flag == 1
                x_root = 0;
                disp(['No Solutions Found']);
                break;

            else
                break;
            end
        else
            % If solution found put in an array
            x_root(a,:) = x(Idx);
        end

        % break the old values
        if Idx(1)<range
            y(1:Idx+range) = 9999;
        else
            y(Idx-range:Idx+range) = 9999;
        end
        disp(['Soln',num2str(a),' found'])
    end
 
% Output the right roots
    x_root = x_root(:,1);
    x_root = sort(x_root); %--> These line up with wolfram perfectly!!!
end
