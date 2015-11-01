eins = [];
eouts = [];
for i = 1:5000
	x = sort(unifrnd(-1,1,20,1));
	y = sign(x);
	vf = rand(20,1)<0.2;
	y(vf) = -y(vf);

	[s,theta,ein] = ds_alg(x,y);
	eins(i) = ein;
	eouts(i) = 0.5 + 0.3*s*(1-abs(theta));
end

mean(eins)
mean(eouts)
subplot(2,1,1);
hist(eins);
subplot(2,1,2);
hist(eouts);