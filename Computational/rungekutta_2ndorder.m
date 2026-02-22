%% 2nd order runge-kutta implementation
% Runge kutta requires 2 equations
% k1 = dt*f(t,y)
% k2 = dt*f(t+0.5,y+k1/2)
% where f = some function you are trying to take derivative of
% i.e. dy(t)/dt = f(t,y) = (t + y - 2) % for this example
% O(h^3) = truncation error
%%
step = 0.2;
y0 = 1;
x0 = 0;
xend = 2;
dydx = @(x,y)(x + y - 2);

y = rungekutta2nd(dydx,y0,x0,xend,step);

x  = x0:step:xend;
[t,y_check] = ode45(dydx,x,1);
plot(x,y); hold on
title('Eulers Method')
plot(x,y_check,'--');
title('ode45 Check')

%% 
function y = rungekutta2nd(dydx,y0,x0,xend,step)
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
    
    y(a+1) = y(a) + k2; % this is for truncation error  
end

end




