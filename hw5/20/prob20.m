addpath('../svm');
train_data = dlmread('../features.train');
test_data = dlmread('../features.test');

gammas = [];
for k = 1:100
	sample = datasample(train_data,1000);
	digits = sample(:,1);
	X = sample(:,2:end);
	y = double(digits==0);
	y(y==0)=-1;
	testX = test_data(:,2:end);
	testy = double(test_data(:,1)==0);
	testy(testy==0)=-1;

	xlabels = 0:4;
	Eouts = [];
	es = [];
	for i = xlabels
		model = svmtrain(y,X,sprintf('-q -t 2 -g %f -c 0.1',10^i));
		[pl, acc, z] = svmpredict(testy,testX,model,'-q');
		Eout = 1-acc(1)/100;
		Eouts = [Eouts Eout];
	end
	[val,ind] = min(Eouts);
	gammas = [gammas 10^(ind-1)];
end
mode(gammas)
hist(gammas)
