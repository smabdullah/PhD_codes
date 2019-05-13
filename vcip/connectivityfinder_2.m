%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function creates all the possible k-nearest neighbours and their
% associated cost from an image point (i,j).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [avgcolour] = connectivityfinder_2(i, j, I, row, col, connectivity)
Colour = zeros(connectivity+1, 3);
count = 1;

if connectivity == 8
    dx = [-1, 0, 1, -1, 1, -1, 0, 1];
    dy = [-1, -1, -1, 0, 0, 1, 1, 1];
elseif connectivity == 4
    dx = [0, -1, 1, 0];
    dy = [-1, 0, 0, 1];
elseif connectivity == 24
    dx = [-2,-2,-2,-2,-2,-1,-1,-1,-1,-1,0,0,0,0,1,1,1,1,1,2,2,2,2,2];
    dy = [-2,-1,0,1,2,-2,-1,0,1,2,-2,-1,1,2,-2,-1,0,1,2,-2,-1,0,1,2];
end

for k = 1: connectivity
    inx = i + dx(k);
    iny = j + dy(k);
    if (inx >=1 && inx <= row) && (iny >= 1 && iny <= col)
        Colour(count,:) = I(inx,iny,:); 
        count = count + 1;
    end
end
Colour(count,:) = I(i,j,:);
avgcolour = mean(Colour(1:count,:));
end