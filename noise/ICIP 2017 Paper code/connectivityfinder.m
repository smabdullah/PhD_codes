%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function creates all the possible k-nearest neighbours and their
% associated cost from an image point (i,j).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function edge = connectivityfinder(i, j, row, col, connectivity)
edge = zeros(connectivity, 1);
count = 1;
if connectivity == 8
    dx = [-1, -1, -1, 0, 1, 1, 1, 0];
    dy = [-1, 0, 1, 1, 1, 0, -1, -1];
elseif connectivity == 4
    dx = [0, -1, 1, 0];
    dy = [-1, 0, 0, 1];
end

for q = 1: connectivity
    iny = i + dy(q);
    inx = j + dx(q);
    if (inx >=1 && inx <= row) && (iny >= 1 && iny <= col)
        y = (iny - 1) * row + inx;
        edge(count) = y;
        count = count + 1;
    end
end
edge = edge(1:count-1,:);
end