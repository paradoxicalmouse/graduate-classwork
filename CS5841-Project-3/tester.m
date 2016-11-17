
%leaveOneOut performs leave one out cross validation
X = K1;
Y = Y1;
errors = 0;
[m, ~] = size(X);
for i = 1 : m
  Z = X;
  Z(i,:) = [];
  Z(:,i) = [];
  W = Y;
  W(i,:) = [];
  pred = mySVM(Z, W, X(i,:), 1);
  if pred ~= Y(i)
      errors = errors + 1;
  end
end
