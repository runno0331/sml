function [w, mu, sigma] = fit(x, m)
    %初期値の設定
    n = length(x);
    mu = 1:m;
    sigma = rand(1, m);
    w = rand(1, m);
    w = w / sum(w);
    epsilon = 1;
    Q = 0;
    eta = zeros(n, m);
    loop = 0;

    while(loop < 1000)
        [new_Q, eta] = estep(x, mu, sigma, w, eta, m, n);
        [w, mu, sigma] = mstep(x, mu, eta, m, n);
        if(converge(new_Q, Q, epsilon))
            break;
        end
        Q = new_Q;
        loop += 1;
    end
    %loop
end

%Eステップ
function [new_Q, new_eta] = estep(x, mu, sigma, w, eta, m, n)
    %etaの導出
    new_eta = zeros(n,m);
    for j = 1:m
        new_eta(:,j) = w(j)*normpdf(x, mu(j), sigma(j));
    end
    for i = 1:n
        new_eta(i,:) = new_eta(i,:) / sum(new_eta(i,:));
    end

    %Qの導出
    new_Q = 0;
    for j = 1:m
        new_Q += dot(new_eta(:,j), (log(w(j) + log(normpdf(x, mu(j), sigma(j))))));
    end
end

%Mステップ
function [new_w, new_mu, new_sigma] = mstep(x, mu, eta, m, n)
    %wの導出
    new_w = mean(eta);

    %muの導出
    new_mu = (x * eta) ./ sum(eta);
    
    %sigmaの導出
    new_sigma = zeros(1, m);
    for j = 1:m
        new_sigma(j) = (x-mu(j)).^2 * eta(:,j);
    end
    new_sigma = sqrt(new_sigma ./ sum(eta));
end

%収束判定
function ret = converge(x, y, epsilon)
    ret = norm(x-y)<epsilon;
end