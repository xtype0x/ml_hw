clear;
train_data = dlmread('../hw8_train.dat');
d = size(train_data,2)-1;
X = train_data(:,1:d);
y = train_data(:,d+1);

eins = [];
for i = 1:2:9
  idx = knnsearch(X,X,'K',i);
  pred = sign(sum(y(idx),2));
  ein = mean(pred ~= y);
  eins = [eins ein];
end
plot(1:2:9,eins);