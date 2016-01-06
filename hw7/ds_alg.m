%% ds_alg: decision algorithm for adaboost
function [output] = ds_alg(X,y)
  minEin = inf;
  chosen_s = -1;
  chosen_theta = -inf;
  chosen_feature = 1;
  N = size(X,1);
  d = size(X,2);
  for i = 1:d
    threshold = sortrows(X,i);
    for s = [-1 1]
      for n = 1:N
        if n == 1
          midp = -inf;
        else
          midp = (threshold(n-1,i)+threshold(n,i))/2;
        end
        % use gini index as impurity measure
        pred = (s * sign(X(:,i)-midp));
        pred(pred == 0) = 1;
        ein = sum(pred == 1)*gini_index(y(pred == 1)) + sum(pred == -1)*gini_index(y(pred == -1));
        if ein < minEin
          chosen_s = s;
          chosen_theta = midp;
          chosen_feature = i;
          minEin = ein;
        end
      end
    end
  end
  output = struct('s',chosen_s,'i',chosen_feature,'theta',chosen_theta);
