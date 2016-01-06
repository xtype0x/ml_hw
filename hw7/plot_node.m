function [out] =  plot_node(model,space)
  if model.i == 1
    plot([model.theta, model.theta],[space.y, space.y+space.h], 'Color', 'green');
  elseif model.i == 2
    plot([space.x, space.x+space.w],[model.theta, model.theta], 'Color', 'green');
  end
  out = 0;
