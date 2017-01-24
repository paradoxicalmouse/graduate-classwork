function [prediction, alpha, b] = mySVM(K, Y, Kt, dataset)
   
    switch dataset
        case 1
            C = 3;
        case 2
            C = 2;
        case 3
            C = 1;
        otherwise
            C = 1;
    end
    [N,~] = size(K);
    alpha  = quadprog((Y*Y').*K,-1 .* ones(N,1),[],[],-Y',0,zeros(N,1),C*ones(N,1));
    j = 1:N;
    j = j(alpha(j) > 0 + exp(-3) & alpha(j) < C - exp(-3));
    b = Y(j(1)) - sum(alpha.*Y.*K(:,j(1)));
    f = Y'.*alpha'*Kt + b;
    prediction = sign(f);
    
    
    
end