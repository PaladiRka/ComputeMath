clc;
clear;
b = 1;
ans = 0;
while (max(ans) < 0.01)
b = b + 1;
A = randSqPow(b);
C = A ^ (-1);
ans = C * A - eye(b);
endwhile
disp(b);
