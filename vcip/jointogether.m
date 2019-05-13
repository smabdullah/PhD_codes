function [V, num, merge] = jointogether(x, y, V, num)
if V(x).rank > V(y).rank
    V(y).p = x;
    V(x).size = V(x).size + V(y).size;
    V(y).size = 0;
    merge = x;
%     mergee = y;
else
    V(x).p = y;
    V(y).size = V(y).size + V(x).size;
    V(x).size = 0;
    merge = y;
%     mergee = x;
    if V(x).rank == V(y).rank
        V(y).rank  = V(y).rank + 1;
    end
end
num = num - 1;
end