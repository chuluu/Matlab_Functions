function integration_answer = Numerical_Trapazoid_Integration(y,step)
% integration_answer = Numerical_Trapazoid_Integration(y)
% Inputs:
% y = input function already computed with bounds and step already
% step of x array
% Outputs:
% integration_answer = answer to integration using trapezoidal method
% Info:
% By: Matthew Luu 
% Last edit: 2/20/2020
% Trapezoidal integration

% Begin Code
    integration_answer = 0;
    N = length(y);
    for n = 1:1:N-1
        integration_answer = integration_answer + 0.5*(y(n) + y(n+1))*(step);
    end
    % disp(['Integration Answer: ',num2str(integration_answer)]);
end