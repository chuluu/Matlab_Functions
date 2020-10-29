function Movie1D(x,y,z)
% Movie1D(x,y,z)
% Inputs:
% x = the x axis for the 1D plot (should be 1xn)
% y = the y axis for the 1D plot (should be mxn) this matrix is based on z
% variable and x variable 
% z = the title or the step (if you plot position vs amp, then time is this
% variable)
% Outputs:
% Figure movie
% Info:
% By: Matthew Luu
% Last Edit: 10/28/2020
% This is a program to help show movie for arbitrary data set.

% Begin Code:
    Nz = length(z);
    for j = 1:Nz              
      plot(x,y(:,j),'linewidth',2);
      grid on;
      xlim([min(x) max(x)]);
      ylim([min(min(y)) max(max(y))]);
      titlestring = ['STEP = ',num2str(j), ' variable = ',num2str(z(j)), 'unit'];
      title(titlestring ,'fontsize',14);                            
      h=gca; 
      get(h,'FontSize');
      set(h,'FontSize',14);
      fh = figure(5);
      set(fh, 'color', 'white'); 
      F=getframe;

    end
    movie(F,T,1);
end