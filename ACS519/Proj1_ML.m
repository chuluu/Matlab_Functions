clc
clear

%% Inputs
% Dimensions
a = 22.5*10^-2;
b = 12.4*10^-2;
h = 6.35*10^-3;

% Material Properties
E = 68*10^9;
rho = 2700;
v = 0.33;
K = 1;                         % Shear Correction Factor

%% Calculated Constants
G = E./(2*(1+v));              % Shear Modulus
D = (E*(h.^3))./(12*(1-v.^2)); % Flexural Rigitidy
I = (h^3)/12;                  % Plate moment of intertia per unit width

%% Speed of Plate Sound
f  = 0:1:7*10^4;
w  = 2*pi*f;

T1 = D./(K*h*G);
T2 = I./h;
T3 = D./(rho*h);

T1sq = sqrt(((T1 - T2).^2).*(w.^4) + 4.*T3.*(w.^2));
T2sq = (w.^2)*(T1 + T2);
Num  = T1sq - T2sq;
Den  = 2.*(1-(w.^2).*((I.*rho)./(K.*h.*G)));
Cb = sqrt(Num./Den); % Generate sound speed based on the equation in lec3

X  = ((D./(rho.*h)).*(w.^2));
Cblow = nthroot(X,4); % calculate low frequency speed limit
Cbhigh = sqrt(K.*G./rho); % calculate high frequency speed limit

plot(f,Cb); hold on;
plot(f,Cblow);
plot(f,Cbhigh.*ones(1,length(f)));

%% Thin Plate Theory
z = 1;
zz = 1;

c = sqrt(D./(rho.*h));
for m = 1:1:10
    %z = 1;
    for n = 1:1:10
        kx(z) = ((m.*pi)./a);
        ky(z) = ((n.*pi)./b);
        wmn(z) = c.*((kx(z).^2) + (ky(z).^2));
        fmn{2,z} = wmn(z)./(2*pi);
        fmn{1,z} = ['m = ',num2str(m),' n = ',num2str(n)];
        z = z+1;
    end
    zz = zz+1;
end

fmn_dum = [fmn{2,:}];
for i = 1:10
    [val(i), num(i)] = min(fmn_dum);
    fmn_dum(num(i)) = 10000000000000;
end

for i = 1:10
    subplot(3,4,i);
    x  = 0:0.01:a;
    y  = (0:0.01:b).';
    ms = sin(kx(num(i)).*x).*sin(ky(num(i)).*y);
    [X,Y] = meshgrid(x,y);
    surf(X,Y,ms);
    xlim([0 a]);
    ylim([0 b]);
    title(['f = ',num2str(round(val(i))), ' Hz ',fmn(1,num(i))]);
    kmn(i) = sqrt((kx(i).^2) + (ky(i).^2)); % Save kmn values
    fmn_thin(i) = fmn{2,num(i)};            % get fmn values
end

%% Thick Plate Theory Resonances
figure(2);
kb = w./Cb;
plot(f,kb,'Linewidth',1.4); hold on;
for i = 1:10
    plot(f,kmn(i).*ones(1,length(f)),'Linewidth',1.4); hold on;
    [val(i),loc(i)] = MyGen.find_val_difference(kb,kmn(i));
    plot(f(loc(i)),kb(loc(i)),'o','Linewidth',2);
end
ylabel('Wavenumber');
xlabel('Frequency (Hz)');

fmn_thick = f(loc);

%% Printing
disp(['Thin Plate: ',num2str(round(fmn_thin))]);
disp(['Thick Plate: ',num2str(fmn_thick)]);

%% mode coverage in range of 0 - 10kHz
modes_idx = find([fmn{2,:}] < 10000);

%% Drive mobility
f = 1:1:10000;
w = 2.*pi.*f;
eta = 0.004;
c = (1+1i.*(eta/2)).*sqrt(D./(rho.*h));
xr = 8*10^-2;
yr = 8*10^-2;
xf = xr;
yf = yr;
mass = rho*a*b*h;
val = [];
for ii = 1:length(f)
    for m = 1:5
        for n = 1:5
            % Calculate Denomenator and kmn things
            km  = (m.*pi)./a;
            kn  = (n.*pi)./b;
            kmn = sqrt( (km.^2) + (kn.^2) );
            wmn = (kmn.^2).*c;
            den = (wmn.^2) - (w(ii).^2);        
            
            % Calculate numerator for sin amplitudes
            num_r = sin(km.*xr).*sin(kn.*yr);
            num_g = sin(km.*xf).*sin(kn.*yf);
            num = num_r.*num_g;
            
            % Calculate mobility for 1 value
            val(n) = num./den;
        end
        % Sum the value
        val_sum = sum(val);
        val_2(m) = val_sum;
        
        % Reset the inner loop
        val = [];
    end
    
    % Calculate the total summation for Drive mobility
    Dr_Mob(ii) = ((1i.*4.*w(ii))./mass).*sum(val_2);
end

subplot(3,1,1); semilogy(f,abs(Dr_Mob)); hold on;
subplot(3,1,2); semilogy(f,imag(Dr_Mob));
subplot(3,1,3); semilogy(f,real(Dr_Mob));
