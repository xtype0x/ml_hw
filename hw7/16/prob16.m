clear;
addpath('../');
train_data = dlmread('../hw7_train.dat');
d = size(train_data,2)-1;
N = size(train_data,1);

eins = [];
trees = [];

for i = 1:30000
  sample =train_data(randi(N,N,1),:);

  tree = decision_tree(sample(:,1:d),sample(:,d+1));
  trees = [trees tree];
  ein = mean(tree_pred(tree, train_data(:,1:d)) ~= train_data(:,d+1));
  eins = [eins ein];
end
plot(eins)
mean(eins)
