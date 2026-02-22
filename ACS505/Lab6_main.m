clc
clear

N=50;       % number of hit points
M=3;        % number of reference accels
F=4400;     % number of frequency bins
addpath('Lab6_Data');

file = 'point1.csv';
acc_frf=zeros(N,M,F);
mob=zeros(M,N,F);
[~,~,~,~,~,FRF_MAG,~,~,~,freqs] = readLabVIEWCSV(file);

