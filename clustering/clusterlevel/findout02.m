function [y, list] = findout02(x, V, list)
y = x;
j = 1;
while y ~= V(y).p
    y = V(y).p;
    list(j,1) = y;
    list(j,2) = V(y).level;
    j = j + 1;    
end
end