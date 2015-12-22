%% ds_alg: decision algorithm for adaboost
function [output] = ds_alg(X,y,u)
  minEin = inf;
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
        ein = sum(((s * sign(X(:,i)-midp)) ~= y).*u);
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
