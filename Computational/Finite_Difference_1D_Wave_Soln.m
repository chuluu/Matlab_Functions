%% 
clc
clear
newpath = 'C:\Users\mbluu\OneDrive\Desktop\MATLAB_Work\Function_Packages';
userpath(newpath);

%% Setup Spatial Array
Lx = 10;
dx = 0.1;
Nx = fix(Lx/dx);
x(:,1)  = (0:Nx-1)*dx; % Space Array

%% Setup Time Arrays
c   = 1;
T   = 40;
CFL =  1; 
dt  = CFL*(dx/c);

%% Setup field Variables
p  = zeros(Nx,1);
pm1 = p; % w at time n - 1
pp1 = p; % w at time n + 1

p(49:51) = [0.1, 0.2, 0.1];
pp1(:)=p(:);

%% Time Stepping
t  =  0;
a  =  1;
t_array = 0:dt:T-dt;
p_total = zeros(Nx,length(t_array));

while (t<T)
    % Setup boundary conditions
    % Reflecting
    %p([1 end]) = 0; % Reflecting
    %p(end) = p(end-1);
    % Mur's Absorbing
%     pp1(1)   = p(2) + ((CFL-1)/(CFL+1))*(pp1(2) - p(1));
%     pp1(end) = p(end-1) + ((CFL-1)/(CFL+1))*(pp1(end-1) - p(end));
    
    % Solution
    t = t+dt;
    pm1 = p;      % Previous value
    p   = pp1;    % Next value
    
    % Continuous Source
    p(1) = 1*sin(20*pi*t/T); % Continously producing a signal (sine)
    p(end) = 1*sin(20*pi*t/T); % Continously producing a signal (sine)
    % Solution
    for jj = 2:Nx-1 % Index 2 because we want to start a bit ahead
        pp1(jj) = (2*p(jj)) - pm1(jj) + ...
            (CFL^2)*(p(jj+1) - 2*p(jj) + p(jj-1));
    end
    
    p_total(:,a) = p;
    a = a+1;
end

Nt = length(t_array);


%% Movie for the travelling wave
MyGen.Movie1D(x,p_total,t_array);
xlabel('X axis','fontSize',14);
ylabel('Wave Amplitude','fontSize',14);   
% for j = 1:Nt              
%   plot(x,p_total(:,j),'linewidth',2);
%   grid on;
%   axis([min(x) max(x) -2 2]);
%   xlabel('X axis','fontSize',14);
%   ylabel('Wave Amplitude','fontSize',14);              
%   titlestring = ['TIME STEP = ',num2str(j), ' TIME = ',num2str(t_array(j)), 'second'];
%   title(titlestring ,'fontsize',14);                            
%   h=gca; 
%   get(h,'FontSize');
%   set(h,'FontSize',14);
%   fh = figure(5);
%   set(fh, 'color', 'white'); 
%   F=getframe;
%             
% end
% movie(F,T,1);