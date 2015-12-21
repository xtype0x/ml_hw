train_data = dlmread('../hw2_adaboost_train.dat');
d = size(train_data,2)-1;
N = size(train_data,1);

% decision stump algorithm
minEin = 1;
for i = 1:d
  train_data = sortrows(train_data,i);
  X = train_data(:,1:d);
  y = train_data(:,d+1);
  for s = [-1 1]
    for n = 1:N
      if n == 1
        midp = -inf;
      else
        midp = (X(n-1,i)+X(n,i))/2;
      end
      ein = mean( sign(X(:,i)-midp) ~= y);
      if ein < minEin
        chosen_s = s;
        chosen_theta = midp;
        chosen_feature = i;
        minEin = ein;
      end
    end
  end
end
minEin
chosen_theta
chosen_feature
chosen_s