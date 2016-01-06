function [pred] = tree_pred(node,X)
  pred = zeros(size(X,1),1);
  if isfield(node,'g')
    pred(:,:) = node.g;
  else
    b_x = node.b.s * sign(X(:,node.b.i) - node.b.theta);
    b_x(b_x==0)=1;
    pred(b_x == 1,1) = tree_pred(node.right, X(b_x==1,:));
    pred(b_x == -1,1) = tree_pred(node.left, X(b_x==-1,:));
  end
