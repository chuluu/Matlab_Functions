c = 1;
dx = 0.01; dy = dx;
CFL_x = 1/sqrt(2); CFL_y = 1/sqrt(2);

Nx = 1-dx;
Ny = 1-dy;
dt = CFL_x *(dx/c);
T = 2-dt;
t = 0:dt:T; x = 0:dx:Nx; y = 0:dy:Ny;

p = zeros(length(x),length(y),length(t));
f0 = 10;
% Initial condition pulse 
p(length(x)/2,(length(y)/2)-1:(length(y)/2)+1,1) = [0.1,0.2,0.1]; %transpose(sin(2*pi*x));
p((length(x)/2)-1:(length(x)/2)+1,length(y)/2,1) = [0.1,0.2,0.1];
% p(:,:,1) = transpose(sin(2.*pi.*x))*sin(2.*pi.*y);

for i = 2:length(x)-1
    for j = 2:length(y)-1
        % Boundary Conditions
        p([1 end],[1, end],2) = 0; % Reflecting

        % Continous IC
        % p(1,1,2) = 1*sin(2*pi*f0*t(1)); %continuouse initial condition

        % Finite Difference Equation 
        p(i,j,2) = (CFL_x^2)*(p(i+1,j,1)-2*p(i,j,1)+p(i-1,j,1)) ...
           + (CFL_y^2)*(p(i,j+1,1)-2*p(i,j,1)+p(i,j-1,1))...
           + 2*p(i,j,1) - p(i,j,1);
    end
end

for n = 2:length(t)-1
    for i = 2:length(x)-1
        for j = 2:length(y)-1
            % Boundary Conditions
            p([1 end],[1 end], n+1) = 0; % Reflecting

    %         % Murs absorption BC
    %         p(1,n+1)   = p(2,n) + ((CFL-1)/(CFL+1))*(p(2,n+1) - p(1,n));
    %         p(end,n+1) = p(end-1,n) + ((CFL-1)/(CFL+1))*(p(end-1,n+1) - p(end,n));

            % Continous IC
            % p(1,1,n+1) = 1*sin(2*pi*f0*t(n)); %continuouse initial condition

            % Finite Difference Equation
            p(i,j,n+1) = (CFL_x^2)*(p(i+1,j,n)-2*p(i,j,n)+p(i-1,j,n)) ...
               + (CFL_y^2)*(p(i,j+1,n)-2*p(i,j,n)+p(i,j-1,n)) ...
               + 2*p(i,j,n) - p(i,j,n-1);
    
        end
    end
end

[X,Y] = meshgrid(x,y);
for j = 1:length(t)              
    h = surf(X,Y,p(:,:,j),'linewidth',2);
    colormap(jet);
    axis xy; axis tight; view(0,90);
%     hcb = colorbar;
%     ylabel(hcb, 'Pressure (Pa)', 'fontsize', 14) % Optional label for colorbar
    xlabel('x position' , 'fontsize', 14)
    ylabel('y position' , 'fontsize', 14) 
    axis([min(x) max(x) min(y) max(y) -max(max(max(p))) max(max(max(p)))]);
    titlestring = ['TIME STEP = ',num2str(j), ' TIME = ',num2str(t(j)), 'second'];
    title(titlestring ,'fontsize',14);    
    lb = -max(max(max(p))) - (-max(max(max(p)))*0.85);
    hb = max(max(max(p))) - (max(max(max(p)))*0.85);
    caxis([lb hb])

    set(h,'LineStyle','none')
    fh = figure(5);
    set(fh, 'color', 'white'); 
    F=getframe;
end

movie(F,T,1);