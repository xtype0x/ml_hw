train_data = dlmread('../hw4_train.dat');
test_data = dlmread('../hw4_test.dat');
N = size(train_data,1);
val_data = train_data(121:200,:);
train_data = train_data(1:120,:);
N = 120;
Eins = [];
Evals = [];
Eouts = [];
for i = 2:-1:-10
	lambda = 10^i;
	N = size(train_data,1);
	d = size(train_data,2);
	X = [ones(N,1) train_data(:,1:(d-1))];
	y = train_data(:,d);
	wreg = (X'*X+lambda*eye(d))^-1*X'*y;
	Eins(3-i) = mean(sign(X*wreg)~=y);

	N = size(val_data,1);
	valX = [ones(N,1) val_data(:,1:(d-1))];
	valy = val_data(:,d);
	Evals(3-i) = mean(sign(valX*wreg)~=valy);

	N = size(test_data,1);
	testX = [ones(N,1) test_data(:,1:(d-1))];
	testy = test_data(:,d);
	Eouts(3-i) = mean(sign(testX*wreg)~=testy);
end
[E,I] = min(Evals);

lambda = 10^(3-I);
train_data = dlmread('../hw4_train.dat');
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