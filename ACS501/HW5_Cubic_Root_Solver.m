syms wo w wc x
A = [(-wo^2) + (w^2) , (wo^2), 0;
     (wc^2), (-2*wc^2) + (w^2), (wc^2);
     (0), (wo^2), (-wo^2) + (w^2)];
B = det(A,'Algorithm','minor-expansion');

my_soln = solve((w^6) + ((-2*(wo^2)-2*(wc^2))*(w^4)) ...
    + (2*(wo^2)*(wc^2) + (wo^4))*(w^2) == 0,w)

matlab_soln = solve(B,w)

%% Problem 3
syms wo x Fo m 
% note: x = w^2

% Numerator for a1
num = -(Fo/m) * (x^2 - 4*(wo^2)*(x) + 3*(wo^4));
anti_res = solve(num == 0,x)


% Denomenator for a1
den = (x^3) - 6*(wo^2)*(x^2) + 10*(wo^4)*(x) - 4*(wo^6);
res = solve(den == 0,x)


