N=6;
A = 1;
T_M = eye(N);
T_M_ghost = [1,zeros(1,N-1)];
T_M = [T_M_ghost;T_M;flip(T_M_ghost)];
le = 1;
Be = [-1 1];
Be_K  = Be.'*Be;

Ke    = Be_K.*(A/le);

