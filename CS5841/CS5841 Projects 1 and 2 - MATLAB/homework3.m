lambda = [0.01, 0.1, 1, 10, 100, 1000];
b = ridge(y_train,x_train,  lambda, 0);
x = [ones([200 1]) x_test];
y = x*w ;
yt = repmat(y_test, [1 6]);
error = sum((y-yt).^2);
bar(error);
set(gca, 'XTick', 1:6, 'XTickLabel', lambda)