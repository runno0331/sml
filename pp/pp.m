#射影追跡
function B = pp(x)
    m = length(x(1,:));
    n = length(x);
    epsilon = 1e-5;

    for k = 1:m
        b = randn(m,1);
        b = b / norm(b);
        loop = 0;
        while(loop < 1000)
            %g(s) = s^3
            new_b = (sum(3*(x*b).^2) * b - (sum(x.*(x*b).^3))')/n;
            %g(s) = tanh(s)
            %new_b = (sum(1 - tanh(x*b).^2) * b - (sum(x.*tanh(x*b)))')/n;
            for i = 1:k-1
                new_b = new_b - dot(new_b, B(:,i))*B(:,i);
            end
            new_b = new_b / norm(new_b);
            if new_b(1) < 0
                new_b = -new_b;
            end
            if(converge(new_b, b, epsilon))
                break
            end
            b = new_b;
            loop += 1;
        end
        B(:,k) = new_b;
        loop
    end
end

%収束判定
function ret = converge(x, y, epsilon)
    ret = norm(x-y)<epsilon;
end