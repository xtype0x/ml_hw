% initialize
train_data = dlmread('../hw3_train.dat');
d = size(train_data,2)-1;
N = size(train_data,1);
X = [ones(N,1) train_data(:,1:d)];
y = train_data(:,d+1);
n = 0.01;
ws = [];

% logistic alg
for i = 1:2000
	if i == 1
		wi = zeros(d+1,1);
	else
		wi = ws(i-1,:)';
	end
	% ein = mean(sign(X*wi)~=y)
	dein = sum( repmat(sigmoid(-y.*(X*wi)).*-y,1,d+1).*X, 1) / N;
	ws(i,:) = wi' - n*dein;
end

w = ws(end,:)'
test_data = dlmread('../hw3_test.dat');
N = size(test_data,1);
Xtest = [ones(N,1) test_data(:,1:d)];
ytest = test_data(:,d+1);

eout = mean(sign(Xtest*w)~=ytest)
