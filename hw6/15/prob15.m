addpath('../');
train_data = dlmread('../hw2_adaboost_train.dat');
d = size(train_data,2)-1;
N = size(train_data,1);

u1 = ones(N,1)./N;
us = [u1];
gs = [];
alpha = [];
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
end
U = sum(us);
plot(U);
U(2)
U(300)