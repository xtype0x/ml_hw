clear;
addpath('../');
train_data = dlmread('../hw7_train.dat');
d = size(train_data,2)-1;
N = size(train_data,1);

eouts = [];
preds = [];
trees = [];
%load trees file
if exist('../trees30000.mat','file') == 2
  load('trees30000.mat');
  for i = 1:30000
    pred = tree_pred(tree, train_data(:,1:d));
    preds = [preds pred];
  end
else
  for i = 1:30000
    sample =train_data(randi(N,N,1),:);

    tree = decision_tree(sample(:,1:d),sample(:,d+1));
    trees = [trees tree];
  end
end

test_data = dlmread('../hw7_test.dat');

for i = 1:30000
  pred = tree_pred(trees(i), test_data(:,1:d));
  preds = [preds pred];
  G = sign(mean(preds,2));
  eout = mean(G ~= test_data(:,d+1));
  eouts = [eouts eout];
end
plot(eouts);
