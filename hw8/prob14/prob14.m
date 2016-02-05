clear;
train_data = dlmread('../hw8_train.dat');
test_data = dlmread('../hw8_test.dat');
d = size(train_data,2)-1;
X = train_data(:,1:d);
y = train_data(:,d+1);
testX = test_data(:,1:d);
testy = test_data(:,d+1);

eouts = [];
for i = 1:2:9
  idx = knnsearch(X,testX,'K',i);
  pred = sign(sum(y(idx),2));
  eout = mean(pred ~= testy);
  eouts = [eouts eout];
end
plot(1:2:9,eouts);