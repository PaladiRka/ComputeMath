function [out] = NewtonPolinom(Y, X, t)

N = length(X);
% вычисляем разделенные разности
differen = Y;
for k = 1 : (N - 1)
    for i = 1 : (N - k)
        differen(i) = (differen(i + 1) - differen(i)) / (X(i + k) - X(i));
    end
end

out = differen(1) * ones(size(t));
for k = 2 : N
    out = differen(k) + (t - X(k)) .* out;
end