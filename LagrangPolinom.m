function [out] = LagrangPolinom(Y, X, t)
N = length(X);
out = zeros(size(t));
for i = 1 : N
  buf = ones(size(t));
  for j = 1 : N
    if j != i
      buf = (t .- X(j)) ./ (X(i) .- X(j)) .* buf;
    end
   end
  out = out .+ Y(i).*buf;
 end