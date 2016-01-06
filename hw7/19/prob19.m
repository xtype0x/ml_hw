clear;
addpath('../');
train_data = dlmread('../hw7_train.dat');
d = size(train_data,2)-1;
N = size(train_data,1);
T = 300;

eins = [];
preds = [];
trees = [];
%load trees file
for i = 1:T
  sample =train_data(randi(N,N,1),:);

  tree = prune_decision_tree(sample(:,1:d),sample(:,d+1));
  trees = [trees tree];
  pred = tree_pred(tree, train_data(:,1:d));
  preds = [preds pred];
  G = sign(mean(preds,2));
  ein = mean(G ~= train_data(:,d+1));
  eins = [eins ein];
end

plot(eins);
