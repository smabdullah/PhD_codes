function [ FM ] = fm_index( X, Y )
%FM_INDEX computes the Fowlkes and Mallows index
%   X and Y are two vectors containing the labels
%   of the data. This index can be used to compare
%   either two cluster label sets or a cluster label
%   set with a true label set.

if numel(X) ~= numel(Y)
    error('X and Y must have the same number of elements');
end

num_samples = numel(X);
class_X = sort(unique(X), 'ascend');
class_Y = sort(unique(Y), 'ascend');

R = numel(class_X);
C = numel(class_Y);

cont_table = zeros(R, C);

for i = 1:R
    for j = 1:C
        cont_table(i,j) = nnz(X(:) == class_X(i) & Y(:) == class_Y(j));
    end
end

Z = sum(sum(cont_table.^2));
nR = sum(cont_table, 2);
nC = sum(cont_table);

bcR = zeros(R, 1);
for i = 1:R
    if nR(i) >= 2
        bcR(i) = nchoosek(nR(i), 2);
    else
        bcR(i) = 0.5;
    end
end

bcC = zeros(C, 1);
for j = 1:C
    bcC(j) = nchoosek(nC(j), 2);
end

FM = (1/2 * (Z - num_samples)) / sqrt(sum(bcR) * sum(bcC));

end

