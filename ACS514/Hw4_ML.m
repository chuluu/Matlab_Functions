
% Define frequencies and such
f = 1:1:100000;

% Define Za,Zb,Zc,Zd,Ze
% Given thiele-small parameters
Rarad = 19*10^6; % Ns/m5
Marad = 73;      % kg/m4
Md_Ad = 0;%960;     % kg/m4
Cd_Ad = 4.85*10^-14; % m5/N
Ra1   = 19*10^7;  % Ns/m5
Ca2   = 9*10^-13; % m5/N
Ra2   = 36*10^9;  % Ns/m5
Ceo_Ad_phi = 5.66*10^-13; % m5/N
Ad    = 31*10^-6;  % m2
phi   = 1.7*10^-4; % C/m

% Matrix Multiply
w = 2.*pi.*f;
for ii = 1:length(w)
    Marad_i = 1i.*w(ii).*Marad;
    Md_Ad_i = 1i.*w(ii).*Md_Ad;
    Cd_Ad_i = 1./(1i.*w(ii).*Cd_Ad);
    Ca2_i   = 1./(1i.*w(ii).*Ca2);
    Ceo_Ad_phi_i = 1./(1i.*w(ii).*Ceo_Ad_phi);

% Now we can do circuit analysis
    Za = (Rarad.*Marad_i./(Rarad + Marad_i)) + Md_Ad_i + Cd_Ad_i; % Parallel + series + series
    Zb = Ceo_Ad_phi_i; % All alone
    Zc = -Ceo_Ad_phi_i + Ra1; % Series
    Zd = Ca2_i; % All alone
    Ze = Ra2;   % All alone

% Now we can do the impedance matrix
    Z    = [Za - Zb + Zc + Zd, Zd ; Zd, Ze + Zd];
    soln = inv(Z)*[1;1];
    U1_p(ii)  = soln(1);
    eoc_p(ii) = (Ad/phi)*U1_p(ii)*Zb;
end

subplot(2,1,1); semilogx(f,abs(eoc_p))
MyGen.title_plots('Magnitude','Frequency (Hz)','Voltage Sensitvity eoc (V/Pa)',12);
grid on;
subplot(2,1,2); semilogx(f,angle(eoc_p))
MyGen.title_plots('Phase','Frequency (Hz)','Phase (rad)',12);
grid on;
