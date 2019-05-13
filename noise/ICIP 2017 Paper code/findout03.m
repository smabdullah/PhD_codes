function [y1, y2] = findout03(x1, x2, V)
y1 = x1;
y2 = x2;
flag1 = true;
flag2 = true;

while (flag1 || flag2)
    if y1 ~= V(y1).p
        y1 = V(y1).p;
    else
        flag1 = false;
    end
    if y2 ~= V(y2).p
        y2 = V(y2).p;
    else
        flag2 = false;
    end
end
end