clc
clear all

%Incorrect Sampling
fs = [200, 60, 20, 20, 12];
phase = [pi/3, pi/3, pi/3, pi/2, pi/3];
c = 1;

while (c < 6)
    t = 0:(1/fs(c)):0.5; %n = linspace(0,fo(c),1000);
    x = cos((2*pi*10.*t) + phase(c));
    figure(1);
    if c == 1
        plot(t,x,'b','LineWidth',4); hold on
    elseif c == 2
        plot(t,x,'r','LineWidth',3); hold on
    elseif c == 3
        plot(t,x,'g','LineWidth',2); hold on
    elseif c == 4
        plot(t,x,'--g','LineWidth',5); hold on
    else
        plot(t,x,'k','LineWidth',6); hold on
    end
    
    title('Sinusoids with different sampling rates');
    xlabel('time (s)');
    ylabel('Amplitude');
    c = c+1;
end