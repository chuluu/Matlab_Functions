function [a_mat,k,x1,x2] = Single_Perceptron(C1,C2,iteration_stop,eta_yes)
%[a_mat,k,x1,x2] = Perceptron_Algorithm_Multi_Feature(C1,C2,iteration_stop)
%Inputs:
%C1 = Class 1 Matrix - columns being the features, rows being each sample
%C2 = Class 2 Matrix - columns being the features, rows being each sample
%iteration_stop = how many iterations until quitting the program due to
%non-convergence
%eta_yes = determine if learning factor is wanted (1) or not (0)
%Outputs:
%a_mat = the a weight vector
%k     = number of iterations the program took to get a soln
%x1    = x-axis vector for plotting the LDF
%x2    = y-axis vector for plotting the LDF
if nargin > 3
  eta_yes = eta_yes;
else
  eta_yes = 1;
end

    Class1 = [ones(1,length(C1));C1];    % positive case1
    Class2 = [-ones(1,length(C2));-C2]; % negative case2
    y = [Class1,Class2];
    [col,row] = size(Class1);
    a_mat = zeros(col,1);
    n = 1; 
    x = 2;
    c = 1;
    k = 1;
    eta = 1/k;

    a_mat(:) = a_mat(:) + y(:,1);
    perceptron_check = 1;
    if eta_yes == 1
        while n < length(y)
            n = n + 1;
            if perceptron_check <= 0
                if x == 1
                    alpha = length(y);
                else
                    alpha = x - 1;
                end
                k = k + 1;
                eta = 1/k;
                a_mat(:) = a_mat(:) + eta*y(:,alpha);
                n = 1;
                c = c+1;
            end

            perceptron_check = a_mat'*y(:,x);

            x = x + 1;
            if x == length(y)+1
                x = 1;
            end

            if k == iteration_stop
                break;
            end
        end
    
    else
        while n < length(y)
            n = n + 1;
            if perceptron_check <= 0
                if x == 1
                    alpha = length(y);
                else
                    alpha = x - 1;
                end
                k = k + 1;
                a_mat(:) = a_mat(:) + eta*y(:,alpha);
                n = 1;
                c = c+1;
            end

            perceptron_check = a_mat'*y(:,x);

            x = x + 1;
            if x == length(y)+1
                x = 1;
            end

            if k == iteration_stop
                break;
            end
        end
    end
                
                
                
    disp(['Single Perceptron Results: '])
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
        x1 = -(a_mat(1)/a_mat(2))*ones(1,length(x2));
    else
        x2 = (-a_mat(1) + -a_mat(2)*x1)/a_mat(3);
    end
    
end