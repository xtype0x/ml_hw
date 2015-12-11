train_data = dlmread('../hw4_train.dat');
test_data = dlmread('../hw4_test.dat');
lambda = 11.26;
N = size(train_data,1);
d = size(train_data,2);
X = [ones(N,1) train_data(:,1:(d-1))];
y = train_data(:,d);
wreg = (X'*X+lambda*eye(d))^-1*X'*y;
Ein = mean(sign(X*wreg)~=y)

N = size(test_data,1);
testX = [ones(N,1) test_data(:,1:(d-1))];
testy = test_data(:,d);
Eout = mean(sign(testX*wreg)~=testy)