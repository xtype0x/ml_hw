function [S,theta,ein] = ds_alg(x,y)
	ein = 1;
	m = length(y);
	for s = [-1,1]
		for i = 1:m
			t = ones(m,1);
			t(1:m <= i) = -t(1:m <= i);
			t = t.*s;
			test_ein = mean(t==y);
			if test_ein < ein
				ein = test_ein;
				S = s;
				theta = x(i);
			end
		end
	end
