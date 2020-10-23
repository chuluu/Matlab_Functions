function psi_AF = Universal_AF(N,psi)
% psi_AF = Universal_AF(N,psi)
% N: Number of arrays
% psi: angle
% Outputs:
% psi_AF: Array factor with respect to angle
% Info:
% By: Matthew Luu
% Last Edit: 5/19/2020
% Soms antenna stuff for array function

    psi_AF_num = sin(N*psi/2);
    psi_AF_den = sin(psi/2);
    psi_AF = (1/N).*abs(psi_AF_num./psi_AF_den);
end