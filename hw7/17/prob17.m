clear;
addpath('../');
train_data = dlmread('../hw7_train.dat');
d = size(train_data,2)-1;
N = size(train_data,1);

eins = [];
preds = [];
trees = [];
%load trees file
if exist('../trees30000.mat','file') == 2
  load('trees30000.mat');
  for i = 1:30000
    pred = tree_pred(trees(i), train_data(:,1:d));
    preds = [preds pred];
  end
else
  for i = 1:30000
    sample =train_data(randi(N,N,1),:);

    tree = decision_tree(sample(:,1:d),sample(:,d+1));
    trees = [trees tree];
    pred = tree_pred(tree, train_data(:,1:d));
    preds = [preds pred];
  end
end

for i = 1:30000
  G = sign(mean(preds(:,1:i),2));
  ein = mean(G ~= train_data(:,d+1));
  eins = [eins ein];
end
plot(eins);
