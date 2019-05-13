% This function returns the kth-nearest neighbours without considering same
% distance values
function [N1, C1, j] = KNMN02(N, C, kth, count, connectivity)
N1 = zeros(1, connectivity);
C1 = zeros(1, connectivity);
j = 0;
flag = true;
maxvariation = 0.5;
while flag && count
    [~, ind] = min(C(1:count));
    j = j + 1;
    N1(1, j) = N(1, ind);
    C1(1, j) = C(1, ind);
    C(ind) = [];
    N(ind) = [];
    count = count - 1;
    variation = var(C1(1:j));
    if variation > maxvariation
        flag = false;
        N1(j) = 0;
        C1(j) = 0;
        j = j - 1;
    end
end
end