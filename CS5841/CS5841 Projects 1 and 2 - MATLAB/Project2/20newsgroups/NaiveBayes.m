train_data = load('train.data');
train_label = load('train.label');
train_map = load('train.map');
test_data = load('test.data');
test_label = load('test.map');

result_label = NaiveBayesClassifier(train_data,train_label,test_data);

totalDocsPerClass = zeros(1, max(train.label));
totalDocsCorrectlyClassified = zeros(1, max(train.label));

totalDocs = size(test_label);
for i = 1 : totalDocs
   actual = test_label(i);
   pred = result_label(i);
   totalDocsPerClass(actual) = totalDocsPerClass(actual) + 1;
   if (pred == actual)
      totalDocsCorrectlyClassified(actual) = totalDocsCorrectlyClassified(actual);
   end
end

percentageClassified = totalDocsCorrectlyClassified./totalDocsPerClass;
'Percentage Classified:'
train_map(:,2) = percentageClassified;
train_map