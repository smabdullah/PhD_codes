% This function returns the kth-nearest neighbours without considering same
% distance values
function [N1, C1, j] = KNMN(N, C, kth, count, connectivity)
N1 = zeros(1, connectivity);
C1 = zeros(1, connectivity);
j = 1;
ratio = 0;
flag = true;

while flag && count >= 1 && j <= kth
     [val, ind] = min(C(1:count));
    if j > 1
        pk = (abs(val - C1(1, j-1)));
        if pk <= 1
            ratio = 0;
        else
            ratio = log((val + C1(1, j-1)) /(abs(val - C1(1, j-1))));
        end
    end
    if ratio <= 0.5
        N1(1, j) = N(1, ind);
        C1(1, j) = C(1, ind);
        C(ind) = [];
        N(ind) = [];
        count = count - 1;
        j = j + 1;
    else
        flag = false;
    end
end
if count >= 1
    [val, ind] = min(C(1:count));
    while val == C1(j-1)
        N1(1, j) = N(1, ind);
        C1(1, j) = C(1, ind);
        C(ind) = [];
        N(ind) = [];
        count = count - 1;
        j = j + 1;
        [val, ind] = min(C(1:count));
    end
end
end