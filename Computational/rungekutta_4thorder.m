%% 4th order runge-kutta implementation
% For a 1st order ode, solve the derivative using a 4h order runge-kutta
% approach

%%
step = 0.2;
y0 = 1;
x0 = 0;
xend = 2;
dydx = @(x,y)(x -y^2);

y = rungekutta4th(dydx,y0,x0,xend,step);
x  = x0:step:xend;

[t,y_check] = ode45(dydx,x,1);
plot(x,y); hold on
title('Eulers Method')
plot(x,y_check,'--')
title('ode45 Check')

%% 
function y = rungekutta4th(dydx,y0,x0,xend,step)
% Inputs:
% y0   = function initial condition
% x0   = beginning of step
% xend = last value
% step = difference step (like time step)
    x  = x0:step:xend;
    y = zeros(1,length(x));
    y(1)  = y0;
    
    for a = 1:length(x)-1
        k1 = step*dydx(x(a),y(a));
        k2 = step*dydx(x(a)+(step/2),y(a)+(k1/2));
        k3 = step*dydx(x(a)+(step/2),y(a)+(k2/2));
        k4 = step*dydx(x(a)+(step),y(a)+k3);
        y(a+1) = y(a)+((k1+2*k2+2*k3+k4)/6); % this is for truncation error  

    end

end


