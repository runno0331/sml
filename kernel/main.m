close all; clear all;
n = 3000;
x = myrand(n);
t = 0:0.01:5;
p = kernel(x, t);

%figure;
%hist(x, 50)
figure;
plot(t, p)
