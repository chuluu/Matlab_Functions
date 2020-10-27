function [x,y] = Read_CSV_Files(name)
% [x,y] = Read_CSV_Files(name)
% Inputs:
% Name = Name of Excel file
% Outputs:
% x    = x axis data
% y    = y axis data
% Info:
% By: Matthew Luu
% Last Edit: 10/27/2020
% Reads a CSV file and properly distinguishes x and y axes

    Data = readmatrix(name);
    [m,n] = size(Data);
    
    if (m > 3)
        x = Data(:,1);
        y = Data(:,2);
    else
        x = Data(1,:);
        y = Data(2,:);        
    end
end