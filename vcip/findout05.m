function [y, list] = findout05(x, V, list)
y = x;
j = 1;
while y ~= V(y).p
    y = V(y).p;
    if V(y).level >= 1
        list(j,1) = y;
        list(j,2) = V(y).level;
        j = j + 1;
    end
end
end