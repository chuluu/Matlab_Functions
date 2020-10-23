function value_interp = webplot_digitizer_interpolater(data, new_x)
% value_interp = webplot_digitizer_interpolater(data, new_x)
% Inputs:
% data: data to be interpolated 
% new_x: The desired x array the data needs to fit
% Outputs:
% value_interp: interpolated results for new_x
% Info:
% By: Matthew Luu
% Last Edit: 11/19/2019
% using webplot digitizer, given a new x value, the data can be
% interpolated to a new data value, this uses a linear interpolator

    old_x = data(:,1);
    phase = data(:,2);
    value_interp = interp1(old_x,phase,new_x);
end