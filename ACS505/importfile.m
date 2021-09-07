function Lab1TestAssignment = importfile(filename, dataLines)
%IMPORTFILE Import data from a text file
%  LAB1TESTASSIGNMENT = IMPORTFILE(FILENAME) reads data from text file
%  FILENAME for the default selection.  Returns the data as a table.
%
%  LAB1TESTASSIGNMENT = IMPORTFILE(FILE, DATALINES) reads data for the
%  specified row interval(s) of text file FILENAME. Specify DATALINES as
%  a positive scalar integer or a N-by-2 array of positive scalar
%  integers for dis-contiguous row intervals.
%
%  Example:
%  Lab1TestAssignment = importfile("C:\Users\mbluu\Desktop\MATLAB_Work\ACS505\Lab1_Test_Assignment.csv", [1, Inf]);
%
%  See also READTABLE.
%
% Auto-generated by MATLAB on 05-Sep-2021 15:57:27

%% Input handling

% If dataLines is not specified, define defaults
if nargin < 2
    dataLines = [1, Inf];
end

%% Set up the Import Options and import the data
opts = delimitedTextImportOptions("NumVariables", 5);

% Specify range and delimiter
opts.DataLines = dataLines;
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["Blocksize", "SamplingRate", "NumberOfAvg", "NumberOfChannels", "Coh"];
opts.VariableTypes = ["string", "double", "double", "string", "string"];

% Specify file level properties
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
opts.ConsecutiveDelimitersRule = "join";

% Specify variable properties
opts = setvaropts(opts, ["NumberOfChannels", "Coh"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["NumberOfChannels", "Coh"], "EmptyFieldRule", "auto");
%opts = setvaropts(opts, "Blocksize", "InputFormat", "MM/dd/yyyy HH:mm:ss.SSS");

% Import the data
Lab1TestAssignment = readtable(filename, opts);

end