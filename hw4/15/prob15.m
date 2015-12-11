train_data = dlmread('../hw4_train.dat');
test_data = dlmread('../hw4_test.dat');
Eins = [];
Eouts = [];
for i = 2:-1:-10
	lambda = 10^i;
	N = size(train_data,1);
	d = size(train_data,2);
	X = [ones(N,1) train_data(:,1:(d-1))];
	y = train_data(:,d);
	wreg = (X'*X+lambda*eye(d))^-1*X'*y;
	Eins(3-i) = mean(sign(X*wreg)~=y);

	N = size(test_data,1);
	testX = [ones(N,1) test_data(:,1:(d-1))];
	testy = test_data(:,d);
	Eouts(3-i) = mean(sign(testX*wreg)~=testy);
end
plot(2:-1:-10, Eouts)
[E,I] = min(Eouts);
lambda = 3-I
minEin = Eins(I)
minEout = E