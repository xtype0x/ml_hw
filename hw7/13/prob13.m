clear;
addpath('../');
train_data = dlmread('../hw7_train.dat');
N = size(train_data,1);
d = size(train_data,2)-1;
X = train_data(:,1:d);
y = train_data(:,d+1);

% tree root
root = decision_tree(X,y);

% plot the figure
figure;
hold on;
color = zeros(N,3);
color(y==1,3) = 1;
color(y==-1,1) =1;
scatter(X(:,1), X(:,2), [], color, 'filled');
root.space = struct('x',0,'y',0,'w',1,'h',1);
queue = [root];

while size(queue,2) ~= 0
  current = queue(1);
  if current.b.i == 1
    left_space = struct('x', current.space.x,'y', current.space.y,'w', current.b.theta - current.space.x, 'h', current.space.h);
    right_space = struct('x', current.b.theta,'y', current.space.y,'w',current.space.w - (current.b.theta - current.space.x), 'h', current.space.h);
  else
    left_space = struct('x', current.space.x,'y', current.space.y,'w', current.space.w, 'h', current.b.theta - current.space.y);
    right_space = struct('x', current.space.x,'y', current.b.theta,'w',current.space.w, 'h', current.space.h - (current.b.theta - current.space.y));
  end
  if isfield(current.left, 'b')
    if current.b.s == 1
      current.left.space = left_space;
    else
      current.left.space = right_space;
    end
    queue = [queue current.left];
  end
  if isfield(current.right, 'b')
    if current.b.s == 1
      current.right.space = right_space;
    else
      current.right.space = left_space;
    end
    queue = [queue current.right];
  end
  plot_node(current.b, current.space);
  queue = queue(2:end);
end
