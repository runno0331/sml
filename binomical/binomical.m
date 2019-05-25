n = 1000; %標本数
x = 0:n;
y = binopdf(x,n,0.5);
plot(x,y)