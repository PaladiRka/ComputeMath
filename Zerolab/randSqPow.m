function [out] = randSqPow(X)
A = rand(X,1);
for i = 0 : length(A) - 1
  out(:,i + 1) = A .^ i;
endfor
