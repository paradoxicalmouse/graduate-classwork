%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% NaiveBayesClassifier - works to classify a text dataset - function      %
% Author: Taylor B. Morris                                                %
% Date: 10/27/2016                                                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [ output_args ] = NaiveBayesClassifier(tr_data, tr_label,tst_data)
%NaiveBayesClassifier runs Naive Bayes over training, test set.
%   For the time being, this is a Naive Bayes classifier run over data
%   found already in our workspace. Ideally, this will eventually run over
%   passed in test and training data. 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%TRAIN%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% train_data - (document-id, word-id, word-occurence)                     %
% train_label - class assignment information of training documents        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
delta = 0.1; % smoothing parameter
m = 0;
[rows, ~] = size(tr_data);
C_size = max(tr_label);
% Loop to find size of vocabulary
m = max(tr_data(:,2));

%Fills in our vocabulary for easier access.
vocabulary = sparse(C_size, m);
for i = 1 : rows
    word = tr_data(i, 2);
    class = tr_label(tr_data(i, 1));
    count = tr_data(i,3);
    vocabulary(class, word) = vocabulary(class, word) + count;
end

%Calculates the probability of word given class
%pWgC is P(word|class)
pWgC = bsxfun(@rdivide, vocabulary, sum(vocabulary,2));
pWgC = log(((1-delta)*pWgC) + (delta/m));

%Calculate sum of log probabilities
[numData, ~] = size(tst_data);
numDocs = max(tst_data(:,1));
pCgD = sparse(C_size, numDocs);
for i = 1 : numData
   if ( tst_data(i, 2) > m || vocabulary(tst_data(i,2)) == 0 )
       continue;
   end
   thisProb = pWgC(:,tst_data(i,2)) * tst_data(i,3);
   pCgD(:,tst_data(i,1)) = pCgD(:,tst_data(i,1)) + (thisProb); 
end

%Guess the class
[~,indices] = max(pCgD,[],1);
output_args = indices;

end

