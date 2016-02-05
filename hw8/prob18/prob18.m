clear;
train_data = dlmread('../hw8_train.dat');
test_data = dlmread('../hw8_test.dat');
d = size(train_data,2)-1;
X = train_data(:,1:d);
y = train_data(:,d+1);
testX = test_data(:,1:d);
testy = test_data(:,d+1);

eouts = [];
for r = [0.001 0.1 1 10 100]
  pred = [];
  for i = 1:size(testX,1)
    xmat = repmat(testX(i,:),size(X,1),1);
    dmat = sqrt(sum((xmat - X).^2,2));
    g_x = sign(sum(y .* exp(-r * dmat)));
    pred = [pred;g_x];
  end
  eouts = [eouts mean(pred ~= testy)];
end
plot(log10([0.001 0.1 1 10 100]),eouts);
xlabel('log(gamma)');
ylabel('Eout');