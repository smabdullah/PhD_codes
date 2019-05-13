%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function VE = precalculation(I, info, imagetype, connectivity, kth)
% This function creates k-nearest neighbour and picks the nearest 'kth'
% elements from it. It stores both of the information in the following
% order [numberofitems k-nearestvertex k-nearestcost kth-nearestvertex kth-nearestcost]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [segmentstatus, VE] = precalculation(Ilab, imagetype, connectivity, k, row, col)
if imagetype == 1
    count = 1;
else
    count = 3;
end
VE = zeros(row*col,4*connectivity+2);
segmentstatus = zeros(row*col, 4+count);

parfor p = 1: row*col
    [i, j] = linearto2d(p, col);
    [N, C, count] = connectivityfinder(i, j, Ilab, row, col, connectivity);
    [N1, C1, range] = KNMN(N, C, k, count-1, connectivity);
    VE(p,:) = [count-1, range-1, N, C, N1, C1];
    if imagetype == 1
        segmentstatus(p,:) = [0, i, j, p, double(Ilab(i,j))];
    else
        segmentstatus(p,:) = [0, i, j, p, double(Ilab(i,j,1)), double(Ilab(i,j,2)), double(Ilab(i,j,3))];
    end
end
end