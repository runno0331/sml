clear all
%初期値の設定
n = 10; %標本数
rep = 1000; %試行回数
rand('seed',2);

x = 0:n;
y = zeros(1,n+1);
z = binornd(n,0.5,[1 rep]);
for i = 0:n
    y(i+1) = sum(z == i); 
end
kurt = kurtosis(y/n)
plot(x/n,y);
