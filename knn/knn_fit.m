function ret = knn_fit(X, T)
    new_X = reshape(X, [256 5000]);
    new_T = reshape(T, [256 2000]);
    Y = reshape((repmat(1:10, [500 1])), [1 5000]);
    ks = cross_val(new_X, Y)
    %ks = 1;
    est = knn(new_X,Y,new_T,ks);
    
    ret = zeros(10);
    for i = 1:10
        for j = 1:10
            ret(i,j) = sum(est((i-1)*200+1:i*200) == j);
        end
    end
    total = trace(ret)
    rate = total/2000
end

function U=knn(X,Y,T,ks)
    m=size(T,2); D2=repmat(sum(T.^2,1),[size(X,2) 1]);
    D2=D2+repmat(sum(X.^2,1)',[1 m])-2*X'*T; [dum,z]=sort(D2,1);
    for i=1:length(ks)
        k=ks(i);
        for j=1:m
            Z=sort(Y(z(1:k,j))); g=find([1 Z(1:end-1)~=Z(2:end)]);
            [dum,a]= max([g(2:end) k+1]-g); U(i,j)=Z(g(a));
        end 
    end
end

%交差確認
function ret = cross_val(X, Y)
    n = 10;
    k = 1:n;
    t = 10; %分割数
    rate = zeros(n,1);

    for i = 1:t
        X_part = X(:,i:t:end);
        Y_part = Y(:,i:t:end);
        X_remain = X;
        Y_remain = Y;
        X_remain(:,i:t:end) = [];
        Y_remain(:,i:t:end) = [];
        est = knn(X_remain, Y_remain, X_part, k);
        rate += sum(est == Y_part, 2);
    end

    %識別率最大のときのk
    ret = k(max(rate) == rate);
end