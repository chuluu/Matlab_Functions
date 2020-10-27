function [a_mat,x1,x2] = MSE(C1,C2)
    %[a_mat,k,x1,x2] = Perceptron_Algorithm_Multi_Feature(C1,C2,iteration_stop)
    %Inputs:
    %C1 = Class 1 Matrix - columns being the features, rows being each sample
    %C2 = Class 2 Matrix - columns being the features, rows being each sample

    %Outputs:
    %a_mat = the a weight vector
    %x1    = x-axis vector for plotting the LDF
    %x2    = y-axis vector for plotting the LDF
    
    
    Class1 = [ones(1,length(C1));C1];    % positive case1
    Class2 = [-ones(1,length(C2));-C2]; % negative case2
    y = [Class1,Class2]';
    b = ones(length(y),1);
    y_T = y';

    a_mat = inv(y_T*y)*y_T*b;
    disp(['MSE Results: '])
    disp(['a values: ', num2str(a_mat')])
    fun = [C1(1,:),C2(1,:)];
    
    if a_mat(2) == 0
        x1 = inf;
    else
        x1 = linspace(min(fun),max(fun),30);
    end
    
    if a_mat(3) == 0
        x2 = linspace(min(fun),max(fun),length(x1));
        x1 = -(a_mat(1)/a_mat(2))*ones(1,length(x2));
    else
        x2 = (-a_mat(1) + -a_mat(2)*x1)/a_mat(3);
    end

end