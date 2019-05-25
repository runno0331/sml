clear all; close all; 
n = 1000;
x1 = 1:n;
x1 = x1/100;
S(:,1)=sin(30*x1+1);
S(:,2) = x1/2 - fix(x1/2);

S=S-repmat(mean(S),[n,1]); S=S./repmat(std(S),[n,1]);
M=[1 6 ;7 3]; X=S*M';

%混合後
figure;
plot(x1, X(:,1)); hold on;
plot(x1, X(:,2));
X=(inv(sqrtm(cov(X)))*X')';

B = pp(X)
x2 = -2:0.1:2;
y1 = -x2*B(1,1)/B(1,2);
y2 = -x2*B(2,1)/B(2,2);

%分布
figure;
plot(x2,y1,'b-');
hold on
plot(x2, y2, 'b-')
plot(X(:,1),X(:,2),['ro']);
ylim([-2 2]);

Y = X*B;

%分離後
figure;
plot(x1,Y(:,1)); hold on;
plot(x1,Y(:,2));

%混合前
figure;
plot(x1, sin(30*x1+1)); hold on;
plot(x1, x1/2 - fix(x1/2))