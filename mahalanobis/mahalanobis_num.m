clear all
%データの読み込み
load digit.mat

%各パラメータの計算
mu = zeros(256,10);
for i=1:10;
    mu(:,i) =  mean(X(:,:,i),2);
end;
logdetS = zeros(10);
invS = zeros(10,256,256);
for i = 1:10;
    logdetS(i) = trace(log((cov(X(:,:,i)') + 0.00001*eye(256))));
    invS(i,:,:) = inv(cov(X(:,:,i)') + 0.00001*eye(256));
end;

%事後確率の計算
p = zeros(10,10,200);
for i = 1:10;
    for j = 1:10;
        for k = 1:200;
            p(i,j,k) = -(T(:,k,i)-mu(:,j))'*reshape(invS(j,:,:), [256 256])*(T(:,k,i)-mu(:,j))/2 - (logdetS(j))/2;
        end;
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