function Idx = find_val(fnc,val,del_start,iteration_val)
    del = del_start; 
    Idx = find(fnc < val + del & fnc > val - del);
    [~,Soln] = size(Idx);
    a = 1;
    del_change = 0;
    %disp(['start']);
    %tic
    flag = 1;
    while (flag == 1)
        while (Soln > 2)
            del = del_start - del_change; 
            Idx = find(fnc < val + del & fnc > val - del);
            [~,Soln] = size(Idx);
            del_change = iteration_val*a;
            a = a+1;
        end
        
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