clear all
%各パラメータ
mu1 = [2; 0];
mu2 = [-2; 0];
S = [1 0; 0 9];
invS = inv(S);
n = 600; 
alpha = 0.1;
n1 = sum(rand(n,1)<alpha); n2=n-n1;
x1 = [randn(1,n1)+2; 3*randn(1,n1)];
x2 = [randn(1,n2)-2; 3*randn(1,n2)];

%推定
result = zeros(2,2);
p1_a = mu1'*invS*x1-mu1'*invS*mu1/2;
p1_1a = mu2'*invS*x1-mu2'*invS*mu2/2;
p2_a = mu1'*invS*x2-mu1'*invS*mu1/2;
p2_1a = mu2'*invS*x2-mu2'*invS*mu2/2;
result(1,1) = sum(sign(p1_a - p1_1a) == 1);
result(1,2) = sum(sign(p1_a - p1_1a) == -1);
result(2,1) = sum(sign(p2_a - p2_1a) == 1);
result(2,2) = sum(sign(p2_a - p2_1a) == -1);

result