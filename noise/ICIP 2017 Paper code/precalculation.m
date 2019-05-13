%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function VE = precalculation(I, info, imagetype, connectivity, kth)
% This function creates k-nearest neighbour and picks the nearest 'kth'
% elements from it. It stores both of the information in the following
% order [numberofitems k-nearestvertex k-nearestcost kth-nearestvertex kth-nearestcost]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [V, E] = precalculation(Ilab, Inew, connectivity, row, col, dim, colourspace)
numofedge = 1;
cedge = false(row*col, 1);
A = zeros(row*col, 1);
B = zeros(row*col, 1);

if strcmp(colourspace, 'RGB')
    if dim == 3
        tempJ1 = reshape(Inew(:,:,1), row*col, 1);
        tempJ2 = reshape(Inew(:,:,2), row*col, 1);
        tempJ3 = reshape(Inew(:,:,3), row*col, 1);
        J = [tempJ1,tempJ2,tempJ3];
    else
        J = reshape(Inew, row*col, 1);
    end
end

if strcmp(colourspace, 'CIELAB')
    tempJ1 = reshape(Ilab(:,:,1), row*col, 1);
    tempJ2 = reshape(Ilab(:,:,2), row*col, 1);
    tempJ3 = reshape(Ilab(:,:,3), row*col, 1);
    J = [tempJ1,tempJ2,tempJ3];
end

V = struct('size', [], 'p', [], 'level', [], 'maxcost', [], 'list', []);

for i = 1:row*col
    V(i).size = 1;
    V(i).p = i;
    V(i).level = 0;
    V(i).list = i;
end

for i = 1:col
    for j = 1:row
        x = (i - 1) * row + j;
        edge = connectivityfinder(i, j, row, col, connectivity);
        cedge(x) = true;
  
        for q = 1:numel(edge)
            if cedge(edge(q)) == false
                A(numofedge) = x;
                B(numofedge) = edge(q);
                numofedge = numofedge + 1;
            end
        end
        V(x).maxcost = 0;
    end
end

A = A(1:numofedge-1);
B = B(1:numofedge-1);
X = J(A,:);
Y = J(B,:);

if strcmp(colourspace, 'CIELAB')
    Diff = deltaE2000(X,Y);
else
    Diff = EuclidientD(X,Y);
end
G = graph(A,B,Diff);
[T,~] = minspantree(G,'Method','sparse');
X = T.Edges;
E = table2array(X);
E = sortrows(E, 3);
end