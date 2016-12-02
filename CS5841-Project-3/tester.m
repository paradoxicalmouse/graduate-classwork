
%leaveOneOut performs leave one out cross validation
bestC1 = 1;
errors = 0;

    X = K33;
    Y = Y3;
    [m, ~] = size(X);
    for i = 1: 100 : m-100
      Z = X;
      Z(i:i+100,:) = [];
      Z(:,i:i+100) = [];
      W = Y;
      W(i:i+100,:) = [];
      pred = mySVM(Z, W, X([1:i-1 i+101:m],i:i+100 ), 3);
      errors = errors + sum(pred' ~= Y(i:i+100));
      
    end
errors

