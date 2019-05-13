function E = primsMST(V, J, distanceFunction)
n = numel(V);
key = zeros(n, 1);
mstSet = zeros(n, 1, 'logical');
parent = zeros(n, 2);
E = zeros(n-1, 3);

% Initialise the key values
key(:) = intmax;
mstSet(:) = false;

key(1) = 0;

for i = 1:n-1
%     disp(i);
    % find the minimum of Vcost
    u = minKey(key, mstSet, n);
    mstSet(u) = true;
    [B, Diff] = findMinEdgeCost(u, n, J, distanceFunction);
    for k = 1:n-1
        if mstSet(B(k)) == false && Diff(k) < key(B(k))
            key(B(k)) = Diff(k);
            parent(B(k), 1:2) = [u, Diff(k)];
        end
    end        
end
for i = 2:n
   E(i-1, 1:3) = [parent(i,1), i, parent(i,2)]; 
end
% sort the edges
E = sortrows(E, 3);
%fprintf('Total cost is %.6f\n', sum(E(:,3)));
end

function [B, Diff] = findMinEdgeCost(u, n, J, distanceFunction)
B = zeros(n-1, 1);
B(1:u-1) = 1:u-1;
B(u:end) = u+1:n;
A = zeros(numel(B), 1);
A(1:end) = u;

A1 = J(A,:);
B1 = J(B,:);
if strcmp(distanceFunction, 'euclideanDistance')
    Diff = EuclidientD(A1, B1);
elseif strcmp(distanceFunction, 'mahalanobisDistance')
    Diff = mahaldistanceglobal(A1, B1);
elseif strcmp(distanceFunction, 'canberraDistance')
    Diff = canberraDistance(A1, B1);
elseif strcmp(distanceFunction, 'brayCurtisDistance')
    Diff = brayCurtisDistance(A1, B1);
elseif strcmp(distanceFunction, 'CosineDistance')
    Diff = CosineDistance(A1, B1);
elseif strcmp(distanceFunction, 'CorrelationDistance')
    Diff = CorrelationDistance(A1, B1);
elseif strcmp(distanceFunction, 'pearsonCorrelation')
    Diff = CorrelationDistance(A1, B1);
end
end

function u = minKey(key, mstSet, n)
minV = intmax;
for i = 1:n
   if mstSet(i) == false && key(i) < minV
      minV = key(i);
      u = i;
   end
end
end