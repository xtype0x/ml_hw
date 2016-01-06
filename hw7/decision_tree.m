% tree node struct:
% g: termination node
% left: b_x =-1 node
% right: b_x = 1 node
% b: dicision stump model
function [root] = decision_tree(X,y)
  if size(unique(y),1) == 1
    root = struct('g', unique(y));
  else
    root = {};
    b = ds_alg(X,y);
    b_x = b.s * sign(X(:,b.i) - b.theta);
    b_x(b_x==0)=1;
    if size(X(b_x == -1,:),1) ~= 0
      root.left = decision_tree(X(b_x == -1,:), y(b_x == -1));
    else
      root.left = struct('g', -1);
    end
    if size(X(b_x == 1,:),1) ~= 0
      root.right = decision_tree(X(b_x == 1,:), y(b_x == 1));
    else
      root.right = struct('g',1);
    end
    root.b = b;
  end
