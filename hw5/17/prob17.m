addpath('../svm');
train_data = dlmread('../features.train');
test_data = dlmread('../features.test');
digits = train_data(:,1);

X = train_data(:,2:end);
y = double(digits==8);
y(y==0)=-1;

xlabels = -6:2:2;
as = [];
for i = xlabels
	model = svmtrain(y,X,sprintf('-t 1 -d 2 -g 1 -r 1 -c %f',10^i));
	as = [as sum(abs(model.sv_coef))];
end
plot(xlabels, as)
