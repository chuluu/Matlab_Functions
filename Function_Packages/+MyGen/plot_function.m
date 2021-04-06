function plot_function(x,y,Line_Color,Line_Width)
% plot_function(x,y,Line_Color,Line_Width)
% Inputs:
% x = x axis data
% y = y axis data
% head = header title text
% x_lab = x label text
% y_lab = y label text
% Line_Color = Color of the line
% Fontsize = Fontsize value
% Line_Width = width of line
% Outputs:
% Graphed data the way I like it
% Info:
% By: Matthew Luu
% Last Edit: 9/1/2020
% Plots in the way 

if nargin < 4
  Line_Width = 2.5;
  disp('yes');
end

plot(x,y,Line_Color,'Linewidth',Line_Width);
grid on;

end