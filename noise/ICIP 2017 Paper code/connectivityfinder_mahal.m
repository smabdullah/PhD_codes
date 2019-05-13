%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function creates all the possible k-nearest neighbours and their
% associated cost from an image point (i,j).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [edge, count] = connectivityfinder_mahal(i, j, row, col, connectivity)
edge = zeros(connectivity, 1);
count = 1;
if connectivity == 8
    dx = [-1, -1, -1, 0, 1, 1, 1, 0];
    dy = [-1, 0, 1, 1, 1, 0, -1, -1];
elseif connectivity == 4
    dx = [0, -1, 1, 0];
    dy = [-1, 0, 0, 1];
end

x25 = [-2,-2,-2,-2,-2,-1,-1,0,0,1,1,2,2,2,2,2];
y25 = [-2,-1,0,1,2,-2,2,-2,2,-2,2,-2,-1,0,1,2];

for q = 1: connectivity
    inx = i + dx(q);
    iny = j + dy(q);
    if (inx >=1 && inx <= row) && (iny >= 1 && iny <= col)
        y = (inx - 1) * row + iny;
        edge(count) = y;
        count = count + 1;
    end
end
edge = edge(1:count-1,:);
count25 = count;
for q = 1: numel(x25)
    inx = i + x25(q);
    iny = j + y25(q);
    if (inx >=1 && inx <= row) && (iny >= 1 && iny <= col)
        y = (inx - 1) * row + iny;
        edge(count25) = y;
        count25 = count25 + 1;
    end
end
end