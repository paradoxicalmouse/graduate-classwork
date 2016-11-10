%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% NaiveBayesScript - runs Naive Bayes over the 20 news group dataset      %
% Author: Taylor B. Morris                                                %
% Date: 10/27/2016                                                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Load the Data
train_data = load('train.data');
train_label = load('train.label');
test_data = load('test.data');
test_label = load('test.label');

% Run Classifier
result_label = NaiveBayesClassifier(train_data,train_label,test_data);

% Calculate Correctness
[tot , ~] = size(test_label);
for k = 1:20
   result(k) = 100* sum(result_label(test_label==k)==k)/sum(test_label == k);
end

% Output Results
'Per Class'
result'
'Overall'
sum(result_label' == test_label)/tot*100


