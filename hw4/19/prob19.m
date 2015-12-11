train_data = dlmread('../hw4_train.dat');
Ecvs = [];
for i = 2:-1:-10
	lambda = 10^i;
	Eval = [];
	for pick = 1:5
		trains = [];
		vals = [];
		for j = 1:5
			if j == pick
				vals = train_data((40*j-39):40*j,:);
			else
				trains = [trains;train_data((40*j-39):40*j,:)];
			end
		end

		N = size(trains,1);
		d = size(trains,2);
		X = [ones(N,1) trains(:,1:(d-1))];
		y = trains(:,d);
		wreg = (X'*X+lambda*eye(d))^-1*X'*y;

		N = size(vals,1);
		valX = [ones(N,1) vals(:,1:(d-1))];
		valy = vals(:,d);
		Eval(pick) = mean(sign(valX*wreg)~=valy);
	end
	Ecvs(3-i) = mean(Eval);
end
plot(2:-1:-10,Ecvs)
[E,I] = min(Ecvs);
lambda = 3-I
Ecv = E