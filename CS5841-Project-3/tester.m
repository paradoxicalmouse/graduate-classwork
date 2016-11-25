
%leaveOneOut performs leave one out cross validation
bestC1 = 1;
errors = sparse(150,1);
for C = 10:10:150
    C1 = C;
    C1
    X = K1;
    Y = Y1;
    [m, ~] = size(X);
    for i = 1: 10 : m-10
      Z = X;
      Z(i:i+10,:) = [];
      Z(:,i:i+10) = [];
      W = Y;
      W(i:i+10,:) = [];
      pred = mySVM(Z, W, X(i:i+10, [1:i-1 i+11:m]), 1,C1);
      errors(C) = errors(C) + sum(pred ~= Y(i:i+10));
      
    end
end
[minimum, index] = min(errors)

