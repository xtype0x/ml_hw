addpath('../svm');
data = dlmread('../hw2_lssvm_all.dat');
train_data = data(1:400,:);
test_data = data(401:end,:);

gammas = [32, 2, 0.125];
lambdas = [0.001 1 1000];

d = size(train_data,2)-1;
X = train_data(:,1:d);
y = train_data(:,d+1);
testX = test_data(:,1:d);
testy = test_data(:,d+1);

minEin = 1;
for g = gammas
  for l = lambdas
    model = svmtrain(y,X,sprintf('-q -s 3 -t 2 -g %f -p 0 -c %f',g,l));
    [pl, acc, z] = svmpredict(y,X,model,'-q');
    Ein = mean(sign(pl)~=y);
    if Ein < minEin
      chose_g = g;
      chose_l = l;
      minEin = Ein;
    end
  end
end 
chose_g
chose_l
minEin