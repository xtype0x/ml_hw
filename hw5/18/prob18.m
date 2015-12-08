addpath('../svm');
train_data = dlmread('../features.train');
test_data = dlmread('../features.test');
digits = train_data(:,1);

X = train_data(:,2:end);
y = double(digits==0);
y(y==0)=-1;

xlabels = -3:1:1;
ds = [];
for i = xlabels
	model = svmtrain(y,X,sprintf('-t 2 -g 100 -c %f',10^i));
	w = model.sv_coef' * full(model.SVs);
	b = -model.rho;
	d = abs(w*full(model.SVs(1,:))'+b) / sqrt(sum(w.^2));
	ds = [ds d];
end
plot(xlabels, ds)
