addpath('../svm');
train_data = dlmread('../features.train');
test_data = dlmread('../features.test');
digits = train_data(:,1);

X = train_data(:,2:end);
y = double(digits==0);
y(y==0)=-1;
testX = test_data(:,2:end);
testy = double(test_data(:,1)==0);
testy(testy==0)=-1;

xlabels = 0:4;
Eouts = [];
es = [];
for i = xlabels
	model = svmtrain(y,X,sprintf('-t 2 -g %f -c 0.1',10^i));
	[pl, acc, z] = svmpredict(testy,testX,model);
	Eout = 1-acc(1)/100;
	Eouts = [Eouts Eout];
end
plot(xlabels, Eouts)
