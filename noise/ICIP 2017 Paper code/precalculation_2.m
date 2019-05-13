%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function VE = precalculation(I, info, imagetype, connectivity, kth)
% This function creates k-nearest neighbour and picks the nearest 'kth'
% elements from it. It stores both of the information in the following
% order [numberofitems k-nearestvertex k-nearestcost kth-nearestvertex kth-nearestcost]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [V, E, noisyblock] = precalculation_2(Ilab, Inew, connectivity, k, row, col)
V = struct('size', [], 'p', [], 'level', [], 'maxcost', [], 'list', [], 'colour', [], 'colourlab', [], 'NN', [], 'NNC', [], 'KNN', []);
Inf = 2147483647;
numofedge = 1;
A = zeros(row*col, 1);
B = zeros(row*col, 1);
Diff = zeros(row*col, 1);

for p = 1: row*col
    [i, j] = linearto2d(p, col);
    [N, C, count] = connectivityfinder_2(i, j, Ilab, row, col, connectivity);
    [N1, C1] = KNMN_2(N, C, k, count-1, connectivity);
    V(p).NN = N1;
    V(p).NNC = C1;
    V(p).KNN = N(1:count-1);
    V(p).size = 1;
    V(p).p = p;
    V(p).level = 0;
    V(p).list = p;
    V(p).maxcost = Inf;
    V(p).colour = Inew(i,j,:);
    V(p).colourlab = Ilab(i,j,:);
end

for i = 1:numel(V)
    for q = 1:numel(V(i).NN)
        A(numofedge) = i;
        B(numofedge) = V(i).NN(q);
        Diff(numofedge) = V(i).NNC(q);
        numofedge = numofedge + 1;
    end
end

A = A(1:numofedge-1,:);
B = B(1:numofedge-1,:);
C = [A,B];
[C, ia, ~] = unique(sort(C,2), 'rows');
Diff = Diff(ia);
G = graph(C(:,1),C(:,2),Diff);
[T,~] = minspantree(G,'Method','sparse');
X = T.Edges;
E = table2array(X);
E = sortrows(E, 3);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
I = zeros(row,col);
for i = 1:size(E,1)
    [x,y] = linearto2d(E(i,1), col);
    I(x,y) = 1;
    [x,y] = linearto2d(E(i,2), col);
    I(x,y) = 1;
end
[r,c] = find(I == 0);
noisyblock = [r,c];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end