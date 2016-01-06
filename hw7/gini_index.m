%% ds_alg: decision algorithm for adaboost
function [output] = gini_index(y)
  if isempty(y)
    output = 0;
  else
    output = 1 - (mean(y == 1)^2 + mean(y == -1)^2);
  end
