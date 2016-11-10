A = importdata('airfoil_self_noise.dat');
[m,n]=size(A);

myregression(A,A(:,1:n-1),1);
% myregression(B,B(:,1:n),1);
% myregression(C,C(:,1:p),1);