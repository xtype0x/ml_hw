train_data = dlmread('../features.train');
test_data = dlmread('../features.test');
digits = train_data(:,1);

X = train_data(:,2:end);
y = double(digits==0);

model = svmtrain(X,y,'autoscale',false,'boxconstraint',0.01,'method','QP');
w = sum(repmat(model.Alpha.*y(model.SupportVectorIndices),1,2).*model.SupportVectors)
Ein = mean(svmclassify(model,X)==y);
