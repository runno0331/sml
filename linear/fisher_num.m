clear all
%データの読み込み
load digit.mat

%各パラメータの計算
mu = zeros(256,10);
for i=1:10;
    mu(:,i) =  mean(X(:,:,i),2);
end;
S = zeros(256,256);
for i = 1:10;
    S += cov(X(:,:,i)');
end;
S /= 10;
invS = inv(S+0.000001*eye(256));

%事後確率の計算
p = zeros(10,10,200);
for i = 1:10;
    for j = 1:10;
        p(i,j,:) = mu(:,j)'*invS*T(:,:,i)-mu(:,j)'*invS*mu(:,j)/2;
    end;
end;

%最大事後確率となる要素のカウント
result = zeros(10,10);
for i =1:10;
    [M,I] = max(p(i,:,:));
    for j = 1:10;
        result(i,j) = sum(I==j);
    end;
end;

result