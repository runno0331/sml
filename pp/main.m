clear all; close all; 
rand('state',0); randn('state',0);
n=1000; d=2;
S(:,1)=rand(n,1); S(:,2)=randn(n,1);
%S(1,2)=9; % outlier
S=S-repmat(mean(S),[n,1]); S=S./repmat(std(S),[n,1]);
M=[1 3 ;5 3]; X=S*M'; 
X=(inv(sqrtm(cov(X)))*X')';

B = pp(X)
x = -4:0.1:9;
y1 = x*B(2,1)/B(1,1);
y2 = x*B(2,2)/B(1,2);
figure; 
plot(x,y1,'b-');
hold on
plot(x, y2, 'b-')
plot(X(:,1),X(:,2),['ro']);
ylim([-4 4]);

%Y = S*B;
%figure;
%hist(Y(:,1));
%figure;
%hist(Y(:,2));
