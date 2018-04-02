function [out] = FNVSV(vector, x)
out = 0;
if vector(1) >= x
    out = [-1, 1];
    return;
endif
for i = 2 : length(vector)
    if vector(i) >= x
        out = [i, i - 1]
    endif
endfor

if out == 0
    out = [length(vector) + 1, -1];
endif