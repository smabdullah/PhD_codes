X = dlmread('jain.txt');
X = X(:,1:2);
Z = linkage(X, 'single');

n = size(Z, 1);
replace by leaf nodes
if issorted(Z, 3) == 0
    Z = sortrows(Z, 3);
end

Z(:, 4) = n+1:n+size(Z,1);
for i = 1:n
    if Z(i, 1) > n % replace by leaf node
        possibleValues = Z(Z(i, 1) - n, 1:2);
        if possibleValues(1) <= n
            Z(i, 1) = possibleValues(1);
        else
            Z(i, 1) = possibleValues(2);
        end
    end
    if Z(i, 2) > n % replace by leaf node
        possibleValues = Z(Z(i, 2) - n, 1:2);
        if possibleValues(1) <= n
            Z(i, 2) = possibleValues(1);
        else
            Z(i, 2) = possibleValues(2);
        end
    end
end

G = graph(Z(:,1),Z(:,2),Z(:,3));
[T,~] = minspantree(G,'Method','sparse');
X = T.Edges;
E = table2array(X);
E = sortrows(E, 3);
here = 1;