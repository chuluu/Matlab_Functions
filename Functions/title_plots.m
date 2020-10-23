function title_plots(head,x_lab,y_lab,FontSize)
% title_plots(head,x_lab,y_lab,FontSize)
% head = header of plot
% x_lab = x label for plot
% y_lab = y label for plot
% FontSize = font size of the plot labels
% Info:
% By: Matthew Luu
% Last edit: 10/18/20
% titling plots

% Begin Code:
    title(head,'Fontsize',FontSize);
    xlabel(x_lab,'Fontsize',FontSize);
    ylabel(y_lab,'Fontsize',FontSize);
end