X = [
	1 0;
	0 1;
	0 -1;
	-1 0;
	0 2;
	0 -2;
	-2 0
];
y = [-1; -1; -1; 1; 1; 1; 1];
N = 7;
p = -ones(N,1);
Q = zeros(N);
A = (repmat(y,1,3).*[ones(N,1) X])';
c = zeros(3,1);

for i = 1:N
	for j = 1:N
		Q(i,j) = y(i)*y(j)*(1+X(i,:)*X(j,:)')^2;
	end
end

alpha = quadprog(Q,p,y',0,y',0,zeros(N,1),[],zeros(N,1),optimoptions(@fminunc,'MaxIter',5000))
b=y(2);
for i = 1:N
	b = b - y(i)*alpha(i)*(1+X(i,:)*X(2,:)')^2;
end
b