function [out1 out2] = FNVSV(vector, x)
out2 = 0;
if vector(1) >= x
    out1 = 0;
    out2 = 1;
    return;
endif

for i = 2 : length(vector)
    if vector(i) >= x
        out1 = i - 1;
        out2 = i;
        break;
    endif
endfor

if out2 == 0
    out1 = length(vector);
    out2 = length(vector) + 1;
endif