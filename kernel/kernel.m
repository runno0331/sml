%一次元カーネル密度推定法
function p = kernel(x, t)
    n = length(x); %データ数
    h = cross_val(x) %バンド幅
    %h = 0.1;
    p = sum(normpdf((t - x')/h)/(n * h));
end

function p = gauss_kernel(x_part, x_remain, h)
    n = length(x_remain);
    abs_T = length(x_part);

    for i = 1:abs_T;
        tem_p(i) = sum(normpdf((x_part(i) - x_remain)/h))/(n*h);
    end
    p = sum(log(tem_p))/abs_T;
end

%尤度交差確認
function ret = cross_val(x)
    h = 0.01:0.01:0.3;
    t = 5; %分割数
    n = length(x);
    p = zeros(1, length(h));

    for i = 1:length(h);
        for j = 1:t;
            x_part = x(j:t:end);
            x_remain = x;
            x_remain(j:t:end) = [];

            p(i) += gauss_kernel(x_part, x_remain, h(i));
        end
    end
    p /= t;
    ret = h(p==max(p));

    %figure;
    %plot(h, p)
end
