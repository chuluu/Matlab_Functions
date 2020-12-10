function int_ans = Matrix_Integration(y,step)
% int_ans = Matrix_Integration(y,step)
% Inputs:
% y = input cell data with individual y cells already gone through an x
% array that has lower and upper bound and step calculated. 
% array of y data in cell 
% step = step size inbetween individual y components
% Outputs:
% int_ans = integration answer of matrix
% Info:
% By: Matthew Luu
% Last Edit: 10/25/2020
% Does integration on a matrix using a numerical trap method

% Begin Code
    [row,col] = size(y);
    for a = 1:row
        for b = 1:col
            int_ans(a,b) = MyGen.Numerical_Trapazoid_Integration(y{a,b},step);
        end
    end
end