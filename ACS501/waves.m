% matlab script adapted from 
clc
clear
%     Roger Knobel "An Introduction fo the Mathematical Theory of Wave Motion" 
%            (American Mathematical Society, 2000) pages 11-12.

% the following script shows ways to visualize a wave pulse.  The specific
% wave pulse is a Gaussian function u(x,t)= A e^(-((x-ct)/a)^2)

% the next three lines create the x and t values for your resulting plots.
% You may need to modify them.  The format of the vector is: 
% startvalue:stepsize:endvalue
x = -10:0.1:10;     % make a vector for the spatial location
t = -6:0.3:6;        % make a vector for time steps
[X,T] = meshgrid(x,t);  % transform vectors x and t to make 3-D plots

% The next several lines define the wave function.  This is what you need to change.
A1=5;    % this controls the amplitude
A2=-3;
c=1;  % this is the wave speed
a1=5;
a2=1;    % this controls the width of the pulse
u1 = A1*exp(-((X-c*T)/a1).^2); % define the wave function to be a Gaussian pulse
u2 = A2*exp(-((X+c*T)/a2).^2); % define the wave function to be a Gaussian pulse
u  = u1+u2;


% the rest of the commands below simply allow you various ways to look at
% or to visualize the wave motion.
figure(1)           % put the next plot in its own figure window
waterfall(x,t,u);  hold on;  % make a waterfall plot of the wave.  You may need to
                    % rotate the plot for it to look correct.
figure(2)           % put the next plot in its own figure window
surf(x,t,u)    % make a surface plot (filled-in waterfall plot)

figure(3)           % put the next plot in its own figure window
pcolor(x,t,u)  % make a contour density plot of the wave 

% The following script will make an animation of the wave pulse
figure(4)           
M = moviein(length(t));
for j=1:length(t),
    plot(x,u(j,:)), M(:,j)=getframe;
end;
movie(M)

%%
figure(123);
plot(x,u(21,:)); hold on;
xlabel('position');
ylabel('Amplitude');
