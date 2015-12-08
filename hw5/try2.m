addpath('./svm');
train_data = dlmread('./features.train');
test_data = dlmread('./features.test');
digits = train_data(:,1);

X = train_data(:,2:end);

xlabels = -6:2:2;
as = [];
Eins = [];
for i = 0:9
	y = double(digits==i);
	y(y==0)=-1;
	model = svmtrain(y,X,sprintf('-t 1 -d 2 -g 1 -r 1 -c 0.01'));
	w = model.sv_coef' * full(model.SVs);
	b = -model.rho;
	p = sign(X*w'+b);
	p(p==0)=1;
	Ein = mean(y~=p);
	Eins = [Eins Ein];
	as = [as sum(abs(model.sv_coef))];
end
Eins
plot(0:9, as)
max(as)