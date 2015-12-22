addpath('../');
train_data = dlmread('../hw2_adaboost_train.dat');
d = size(train_data,2)-1;
N = size(train_data,1);

u1 = ones(N,1)./N;
us = [u1];
gs = [];
alpha = [];
eins = [];
for T = 1:300
  % decision stump algorithm
  u = us(:,T);
  X = train_data(:,1:d);
  y = train_data(:,d+1);
  g = ds_alg(X, y, u);
  pred = g.s .* sign(X(:,g.i) - g.theta);
  et = sum(u .* (pred~=y)) / sum(u);
  diamond = sqrt((1-et)/et);
  u(y == pred) = u(y == pred) ./ diamond;
  u(y ~= pred) = u(y ~= pred) .* diamond;
  gs = [gs g];
  alpha = [alpha log(diamond)];
  us = [us u];
  G = zeros(N,1);
  for i = 1:size(alpha,2)
    G = G+alpha(i).* (gs(i).s .* sign(X(:,gs(i).i) - gs(i).theta));
  end
  eins = [eins mean(sign(G)~=y)];
end
plot(eins)
eins(end)