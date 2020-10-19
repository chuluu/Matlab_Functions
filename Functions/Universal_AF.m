function psi_AF = Universal_AF(N,psi)
    psi_AF_num = sin(N*psi/2);
    psi_AF_den = sin(psi/2);
    psi_AF = (1/N).*abs(psi_AF_num./psi_AF_den);
end