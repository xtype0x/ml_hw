train_data = tblread('./hw2_train.dat',' ');
d = size(train_data,2) - 1;
y = train_data(:,d+1);
min_ein = 1;

for i = 1:d
	data = sortrows([train_data(:,i) y],1);
	[s,theta,ein] = ds_alg(data(:,1),data(:,2));
	if min_ein > ein
		optimal_i = i;
		optimal_s = s;
		optimal_theta = theta;
		min_ein = ein;
	end	
end

test_data = tblread('./hw2_test.dat',' ');
h_x = optimal_s*sign(test_data(:,optimal_i)-optimal_theta);
h_x(h_x==0)=1;
mean(h_x==test_data(:,size(test_data,2)))