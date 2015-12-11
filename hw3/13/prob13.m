eins = [];

for i = 1:1000
	% generate data
	X = unifrnd(-1,1,1000,2);
	y = sign(X(:,1).^2+X(:,2).^2-0.6);
	noise = randi(1000,100,1);
	y(noise) = -y(noise);
	X = [ones(1000,1) X];

	wlin = (X'*X)^-1*X'*y;
	ein = mean(sign(X*wlin)~=y);
	eins(i) = ein;
end

mean(eins)
hist(eins)