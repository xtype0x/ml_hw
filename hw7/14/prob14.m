clear;
addpath('../');
train_data = dlmread('../hw7_train.dat');
N = size(train_data,1);
d = size(train_data,2)-1;
X = train_data(:,1:d);
y = train_data(:,d+1);

% tree root
root = decision_tree(X,y);
pred = tree_pred(root,X);
ein = mean(pred ~= y)
