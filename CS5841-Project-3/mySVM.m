function [prediction, alpha, b] = mySVM(K, Y, Kt, dataset)
   
    switch dataset
        case 1
            C = 2;
        case 2
            C = 1;
        case 3
            C = 1;
        otherwise
            C = 1;
    end
    [N,~] = size(K);
    alpha = quadprog(K*Y*Y',-1 .* ones(N,1),[],[],Y',0,zeros(N,1),C*ones(N,1));
    b = Y(1) - Y'*K*alpha;
    f = alpha*Kt + b;
    prediction = sign(f);
    
end