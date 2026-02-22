%% Problem 3
syms kl
l1 = 0.022;
S1 = 0.0005;%5.4*10^-4;
S2 = 0.003;
l2 = 0.136;
zo = 415.02;
Z1 = zo/S1;
Z2 = zo/S2;

% Solving
% num = (zo/S1)*(kl) - ((zo*l2)/(S2*l1))*cot(kl);
% soln = solve(num == 0,kl);
syms kl;
s = (kl) - ((S1*l2)/(S2*l1))*1/taylor(tan(kl),kl)

soln = vpasolve(s==0,kl)
%v = double(solve(s));
%soln = real( v( abs( imag(v) < eps(norm(v)) ) ) );
f = round(((soln/l2)*343)/(2*pi))

%%
k_tl  = 0:0.001:1;
eqn1 = k_tl;
eqn2 = ((S1.*l2)./(S2.*l1)).*cot(k_tl);

plot(k_tl, eqn1); hold on;
plot(k_tl, eqn2);

%%
l2 = 0.123
kas = (2*pi*400)/(343);
cot(kas*l2)
