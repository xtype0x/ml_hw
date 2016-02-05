clear;
train_data = dlmread('../hw8_train.dat');
d = size(train_data,2)-1;
X = train_data(:,1:d);
y = train_data(:,d+1);

eins = [];
for r = [0.001 0.1 1 10 100]
  pred = [];
  for i = 1:size(X,1)
    xmat = repmat(X(i,:),size(X,1),1);
    dmat = sqrt(sum((xmat - X).^2,2));
    g_x = sign(sum(y .* exp(-r * dmat)));
    pred = [pred;g_x];
  end
  eins = [eins mean(pred ~= y)];
end
plot(log10([0.001 0.1 1 10 100]),eins);
xlabel('log(gamma)');
ylabel('Ein');