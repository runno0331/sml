close all; clear all;
n = 1000;
rand('seed',0);

m = 2;
x=randn(1,n)+(rand(1,n)>0.3)*4-2;


%{
m = 3;
t = rand(1,n);
x = randn(1,n)+(t>0.7)*3-(t<0.3)*4;
%}

[w, mu, sigma] = fit(x,m);
%{
w
mu
sigma
%}
x1 = -9:0.1:9;
y = 0;
for j = 1:m
    y += w(j)*normpdf(x1, mu(j), sigma(j))/2;
end

f1 = figure;
hist(x)
f2 = figure;
plot(x1,y)
