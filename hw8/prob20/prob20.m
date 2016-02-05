clear;
data = dlmread('../hw8_nolabel_train.dat');
N = size(data,1);

totaleins = [];
  for t = 1:500
  eins = [];
  for k = 2:2:10
    us = data(randi(N,k,1),:);
    prevein = inf;
    while true
      S = knnsearch(us,data,'K',1);
      newus = [];
      for i = 1:k
        newus(i,:) = mean(data(S==i,:),1);
      end
      ein = 0;
      for i = 1:k
        xk = data(S == i,:);
        ein = ein + sum(sum((xk - repmat(us(i,:),size(xk,1),1)).^2,2));
      end
      if ein < prevein
        prevein = ein;
      else
        break;
      end
    end
    eins = [eins ein];
  end
  totaleins = [totaleins;eins];
end
avg_eins = mean(totaleins);
plot(2:2:10,avg_eins);
xlabel('K');
ylabel('Ein');