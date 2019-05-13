%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function creates all the possible k-nearest neighbours and their
% associated cost from an image point (i,j).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [N, C, count] = connectivityfinder(i, j, I, row, col, connectivity)
N = zeros(1, connectivity);
C = zeros(1, connectivity);
count = 1;

if connectivity == 8
    dx = [-1, 0, 1, -1, 1, -1, 0, 1];
    dy = [-1, -1, -1, 0, 0, 1, 1, 1];
elseif connectivity == 4
    dx = [0, -1, 1, 0];
    dy = [-1, 0, 0, 1];
end

for k = 1: connectivity
    inx = i + dx(k);
    iny = j + dy(k);
    if (inx >=1 && inx <= row) && (iny >= 1 && iny <= col)
        N(1, count) = (inx - 1) * col + iny;
        deltaE = deltaE2000(I(i,j,:), I(inx,iny,:));
        C(1, count) = deltaE + 0.0001; % avoid zero distance
        count = count + 1;
    end
end
end