%%
newpath = 'C:\\Users\tonel\Desktop\MATLAB_Work\Functions';
userpath(newpath)

%%
[dn, n] = unit_sample(16);
%plot n
figure(1);
stem(n,dn,'.','Linewidth',3);
title('unit sample index');
xlabel('index');
ylabel('Amplitude');
