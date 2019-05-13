function [mutualKNN, curval] = findAllMutualN(i, segmentneighbour)
mutualKNN = zeros(1, 100);
j = 1;
[tempmutual, curval] = findMutualKNN(segmentneighbour, segmentneighbour{i, 3}, i);
for k = 1:numel(tempmutual)
    if tempmutual(k) ~= i && any(mutualKNN == tempmutual(k)) == 0
        mutualKNN(1, j) = tempmutual(k);
        j = j + 1;
    end
end
if j > 1
    mutualKNN = mutualKNN(1:j-1);
else
    mutualKNN = [];
end
end