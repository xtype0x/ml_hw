% tree node struct:
% g: termination node
% left: b_x =-1 node
% right: b_x = 1 node
% b: dicision stump model
function [root] = prune_decision_tree(X,y)
    root = {};
    b = ds_alg(X,y);
    root.left = struct('g', -1);
    root.right = struct('g',1);
    root.b = b;
  end
