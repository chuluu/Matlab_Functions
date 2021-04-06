function [H,P,Z,Hw] = Analog_TF_Analyzer(num,den,f,fig_num)
% [H,P,Z,Hw] = Analog_TF_Analyzer(num,den,f,fig_num)
    w   = 2*pi*f;
    H = tf(num,den);
    P = pole(H);
    Z = zero(H);
    poles_old = 0;
    zeros_old = 0;

    for a = 0:length(num)-1
        sub = num(a+1).*((1i.*w).^a);
        zeros_fnc = zeros_old + sub;
        zeros_old = zeros_fnc;
    end

    for a = 0:length(den)-1
        sub = den(a+1).*((1i.*w).^a);
        poles_fnc = poles_old + sub;
        poles_old = poles_fnc;
    end
    Hw  = zeros_fnc./poles_fnc;
    if nargin < 4
        
    else
        figure(fig_num);
        bode(H);
    end

end