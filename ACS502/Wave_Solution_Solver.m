syms x t
c= 1;
w = 21;
k = w/c;
c = 4/6;
% F  = (7+1i*14)*exp(1i*((3*x) - (w/k)*t));
% F  = x^((k*x)-(c*t));
% F  = 1i*cos((x/c)+t) - sin((x/c)+t);
% F  = sinh((8*x) - (c*t));
% F  = (c/((c*x) + (17*t)));
% F = log((x)+(c*t));
%F = tanh((7*x) - (7*c*t));
%F = ((c*x) + (t));
%F = sin(4*t)*cos(6*x);

X1 = diff(F,x);
t1 = diff(F,t);

X2 = diff(X1,x)
t2 = diff(t1,t)

if (t2 == (c^2)*X2)
    disp(['yes']);
else
    disp(['no']);
end

% F  = sin((x^2)+(c*t));
% F  = sqrt((c*t)+x);
% F  = 1/((3*x) -15 + (8*c*t));
% F  = 1/(3*x+(c*t));
% F  = sin((x)-(c*t));