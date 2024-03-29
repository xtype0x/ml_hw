addpath('../svm');
train_data = dlmread('../features.train');
test_data = dlmread('../features.test');
digits = train_data(:,1);

X = train_data(:,2:end);
y = double(digits==0);
y(y==0)=-1;

xlabel = -6:2:2;
ws = [];
for i = xlabel
	model = svmtrain(y,X,sprintf('-t 0 -c %f', 10^i));
	w = model.sv_coef' * full(model.SVs);
	wlen = sqrt(sum(w.^2));
	ws = [ws wlen];
end
plot(xlabel,ws)
