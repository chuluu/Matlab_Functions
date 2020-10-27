function [a_mat,k,x1,x2] = Ho_Kashyap(C1,C2,iteration_stop)
%[a_mat,k,x1,x2] = Ho_Kashyap(C1,C2,iteration_stop)
%Inputs:
%C1 = Class 1 Matrix - columns being the features, rows being each sample
%C2 = Class 2 Matrix - columns being the features, rows being each sample
%iteration_stop = how many iterations until quitting the program due to
%non-convergence
%Outputs:
%a_mat = the a weight vector
%k     = number of iterations the program took to get a soln
%x1    = x-axis vector for plotting the LDF
%x2    = y-axis vector for plotting the LDF
    
% step 0: arbitrary initialization
    Class1 = [ones(1,length(C1));C1];    % positive case1
    Class2 = [-ones(1,length(C2));-C2]; % negative case2
    y = [Class1,Class2];
    y_T = y';
    [col,row] = size(y_T);
    a_mat = ones(row,1);
    b_mat = ones(col,1);
    eta = 1;
    k = 1;

    while k < iteration_stop
        % step 1: error
        e = y_T*a_mat - b_mat;

        % step 2: b parameter use eqn
        b_mat = b_mat + eta.*(e + abs(e));

        % step 3: a parameter use eqn
        a_mat= inv(y_T'*y_T)*y_T'*b_mat;

        % step 4: k = k+1
        k = k+1;

        % stopping condition k > kmax or |e(k)| < bmin [we choose]
        abs(sum(e)); % ? for quit condition?
    end
    disp(['Ho-Kashyap Results: ']);
    disp(['a iteration count: ', num2str(k)])
    disp(['a values: ', num2str(a_mat')])
    fun = [C1(1,:),C2(1,:)];
    
    if a_mat(2) == 0
        x1 = inf;
    else
        x1 = linspace(min(fun),max(fun),30);
    end
    
    if a_mat(3) == 0
        x2 = linspace(min(fun),max(fun),length(x1));
    else
        x2 = (-a_mat(1) + -a_mat(2)*x1)/a_mat(3);
    end
end