function [x,y] = func(a)
    x = a**2;
    y = 1:3;
    new_sigma = sqrt(sum(eta * transpose(transpose(x)-mu) * (transpose(x)-mu)) ./ sum(eta));
end

function [new_Q, new_eta] = estep(x, mu, sigma, w, eta, m, n)
    new_Q = 0;
    for j = 1:m
        new_Q += sum(eta(:,j).*(log(w(j) + normpdf(x, mu(j), sigma(j)))));
    end

    new_eta = zeros(n,m);
    for j = 1:m
        new_eta(:,j) = w(j)*normpdf(x, mu(j), sigma(j)) / sum(w(j)*normpdf(x, mu(j), sigma(j)));
    end
end

%Mステップ
function [new_w, new_mu, new_sigma] = mstep(x, mu, eta)
    new_w = mean(eta) / sum(mean(eta));
    new_mu = x * eta ./ sum(eta);
    new_sigma = [1 1];
end