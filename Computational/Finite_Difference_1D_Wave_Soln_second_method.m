c = 1;
dx = 0.01; 
CFL = 1/2;
dt = CFL *(dx/c);
T = 2;
t = 0:dt:T;
x = 0:dx:1;
p = zeros(length(x),length(t));
f0 = 10;
% Initial condition pulse 
p(:,1) = zeros(1,length(x));%transpose(sin(2*pi*x));

for i = 2:length(x)-1
    % Boundary Conditions
    p([1 end],2) = 0; % Reflecting
    
    % Continous IC
    p(1,2) = 1*sin(2*pi*f0*t(1)); %continuouse initial condition
    
    % Finite Difference Equation 
    p(i,2) = (CFL^2)*(p(i+1,1)-2*p(i,1)+p(i-1,1)) + 2*p(i,1) - p(i,1);
end

for n = 2:length(t)-1
    for i = 2:length(x)-1
        % Boundary Conditions
        p([1 end],n+1) = 0; % Reflecting
        
%         % Murs absorption BC
%         p(1,n+1)   = p(2,n) + ((CFL-1)/(CFL+1))*(p(2,n+1) - p(1,n));
%         p(end,n+1) = p(end-1,n) + ((CFL-1)/(CFL+1))*(p(end-1,n+1) - p(end,n));
        
        % Continous IC
        p(1,n+1) = 1*sin(2*pi*f0*t(n)); %continuouse initial condition
        
        % Finite Difference Equation
        p(i,n+1) = (CFL^2)*(p(i+1,n)-2*p(i,n)+p(i-1,n)) + 2*p(i,n) - p(i,n-1);
    end
end

for j = 1:length(t)              
  plot(x,p(:,j),'linewidth',2);
  grid on;
  axis([min(x) max(x) -2 2]);
  xlabel('X axis','fontSize',14);
  ylabel('Wave Amplitude','fontSize',14);              
  titlestring = ['TIME STEP = ',num2str(j), ' TIME = ',num2str(t(j)), 'second'];
  title(titlestring ,'fontsize',14);                            
  h=gca; 
  get(h,'FontSize');
  set(h,'FontSize',14);
  fh = figure(5);
  set(fh, 'color', 'white'); 
  F=getframe;
            
end
movie(F,T,1);