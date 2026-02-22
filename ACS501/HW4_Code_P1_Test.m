t = linspace(0,2000,10000);
B = 0.0015;

wo = 1;
w  = 1;
B  = 0.0015;
F  = 1;
m  = 1;
wd = sqrt((wo^2) - (B^2));

sqrt_term = sqrt((wo^2 - w^2)^2 + ((2*B*w)^2)*(w/wd)^2);
C_term    = (F/m) / ((wo^2 - w^2)^2 + ((2*B*w)^2));
C  = C_term*sqrt_term;
A  = 1/sqrt(((wo^2 - w^2)^2 + ((2*B*w)^2)));


phase = atan((w*2*B*w)/(wd*((wo^2)-(w^2))));
theta = atan((2*B*w)/((wo^2) - (w^2)));

x = C.*exp(-B.*t).*cos(wd.*t + phase) + A.*cos((w.*t) - theta);
plot(t,x);