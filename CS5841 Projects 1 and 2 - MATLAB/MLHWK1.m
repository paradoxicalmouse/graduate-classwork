disp('Problem 1');
format long g;
P_pos_g_ill=.99;
P_pos_g_healthy=.01;
P_ill=1/100000;
P_healthy=1-P_ill;
P_pos=P_pos_g_healthy*P_healthy+P_pos_g_ill*P_ill;
P_ill_g_pos=P_pos_g_ill*P_ill/P_pos;
fprintf('Question 1 %.9f\n', P_ill_g_pos);
fprintf('Question 2 %.9f\n', P_ill_g_pos+P_ill_g_pos);
fprintf('Qustion 3 %1.2f\n', .99/P_ill_g_pos);

disp('Problem 2');
P_C_g_S=.7;
P_C_g_notS=.5;
P_notC_g_S=.3;
P_notC_g_notS=.5;
P_U_g_S=.9;
P_U_g_notS=.2;
P_notU_g_S=.1;
P_notU_g_notS=.8;
P_S=.9;
P_notS=.1;
P_C=(P_C_g_S*P_S)+(P_C_g_notS*P_notS);
P_S_g_C=(P_C_g_S*P_S)/P_C;
% P_notS_g_C=(P_C_g_notS*P_notS)/P_C;
P_notS_g_C=1-P_S_g_C;
P_U_g_C=(P_U_g_S*P_S_g_C)+(P_U_g_notS*P_notS_g_C);
fprintf('Pr(U|C)=%.4f\n',P_U_g_C);

disp('Problem 3');
fprintf('Question 1 %.4f\n',.5^3);
totalSum=0;
for i = 1:6
    for j = 1:6
        for k = 1:6
           totalSum=totalSum+log(i*j*k);
        end
    end
end
totalSum=totalSum/(6^3);
fprintf('Question 3: ');
fprintf('E(log X)=%.5f and ', totalSum);
for i = 1:6
    for j = 1:6
        for k = 1:6
           totalSum=totalSum+(i*j*k);
        end
    end
end
totalSum=totalSum/(6^3);
totalSum=log(totalSum);
fprintf('log(E(X))=%.5f\n',totalSum);
