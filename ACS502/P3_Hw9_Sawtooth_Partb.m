%% P3
clc
clear

x = 0:0.001:4000;
f1 = 10000;
u = 0.96;
rho = 950;
v = u/rho;
c = 1540;
alpha = ((4/3)*v)/(2*(c^3));
alpha1 = alpha*(2*pi*f1)^2
for a = 1:length(x)
    SPL2 = 80.*log10(exp(-alpha1*x(a)))-6;
    SPL1 = 20.*log10(exp(-alpha1*x(a)));
    if SPL2 < SPL1 - 20
        break;
    end
end

disp(['Answer: ',num2str(x(a)),' m']);