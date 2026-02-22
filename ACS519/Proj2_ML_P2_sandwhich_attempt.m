
clc
clear

%% Input
a = 0.5;
b = 0.4;
% Inputs:
% Panel
Efs = 68.9*10^9; % youngs
tfs = 0.508*10^-3; % thickness
vfs = 0.33; % poisson
mus = 2*2700 + 144.166; % density
mode_num = 5;

% Honeycomb
hc  = 12.7*10^-3;
Gr  = 7.584e+7;
Gw  = 1.2066e+8;
Gc  = sqrt(Gr*Gw);

%
f  = 0:1:5000;
w  = 2.*pi.*f;

D   = (Efs.*tfs.*(hc + tfs).^2)./(2.*(1-vfs.^2));
N   = Gc.*hc.*(1+tfs/hc)^2;

Cb = sqrt((2.*N)./(mus + sqrt((mus.^2) + ((4*mus*(N.^2))./((w.^2).*D)))));

plot(f,Cb)
xlim([0 1500]);
%%
% Thick Plate Theory Resonances
z = 1;
zz = 1;
for m = 1:1:mode_num
    %z = 1;
    for n = 1:1:mode_num
        kx(z) = (((2*m-1).*pi)./(2*a));
        ky(z) = (((2*n-1).*pi)./(2*b));
        kmn(z) = sqrt((kx(z).^2) + (ky(z).^2));
        z = z+1;
        modes{z} = [m,n];
    end
    zz = zz+1;
end

figure(2);
kb = w./Cb;
plot(f,kb,'Linewidth',1.4); hold on;

for i = 1:length(modes)-1
    plot(f,kmn(i).*ones(1,length(f)),'Linewidth',1.4); hold on;
    [val(i),loc(i)] = MyGen.find_val_difference(kb,kmn(i));
    plot(f(loc(i)),kb(loc(i)),'o','Linewidth',2);
end
    ylabel('Wavenumber');
    xlabel('Frequency (Hz)');

fmn_thick = f(loc);
for ii = 1:length(fmn_thick)
    fmn_thick_cell{1,ii} = ['m=',num2str(modes{ii+1}(1)),' n=',num2str(modes{ii+1}(2))];
    fmn_thick_cell{2,ii} = modes{ii+1};
    fmn_thick_cell{3,ii} = fmn_thick(ii);
end
disp(fmn_thick_cell)