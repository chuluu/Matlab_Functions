function [a_mat,k,x1,x2] = Perceptron_Algorithm(C1_F1,C1_F2,C2_F1,C2_F2,iteration_stop)
%{
Inputs:
C1_F1 = Class1 Feature1 vector, the class discreminiation and the feature ex:
number 0, eccentricity
C1_F2 = Class1 Feature2 vector, the class discreminiation and the feature ex:
number 0, Middle Row Diameter
C2_F1 = Class2 Feature1 vector, the class discreminiation and the feature ex:
number 1, eccentricity
C1_F1 = Class1 Feature1 vector, the class discreminiation and the feature ex:
number 1, Middle Row Diameter
iteration_stop = how many iterations until quitting the program due to
non-convergence

Outputs:
a_mat = the a weight vector
k     = number of iterations the program took to get a soln
x1    = x-axis vector for plotting the LDF
x2    = y-axis vector for plotting the LDF

%}
    Feature_0 = [ones(1,length(C1_F1));C1_F1;C1_F2];    % positive case1
    Feature_1 = [-ones(1,length(C2_F1));-C2_F1;-C2_F2]; % negative case2
    y = [Feature_0,Feature_1];
    [col,row] = size(Feature_0);
    a_mat = zeros(col,1);
    n = 1; 
    x = 2;
    c = 1;
    k = 1;
    eta = 1/k;

    a_mat(:) = a_mat(:) + y(:,1);
    perceptron_check = 1;
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
    k = k+1;
    disp(['a iteration count: ', num2str(k)])
    disp(['a values: ', num2str(a_mat')])
    fun = [C1_F1,C2_F1];
    x1 = linspace(min(fun),max(fun),30);
    x2 = (-a_mat(1) + -a_mat(2)*x1)/a_mat(3);
end