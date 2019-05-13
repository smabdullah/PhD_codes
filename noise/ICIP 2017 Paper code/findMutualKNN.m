function [mutualKNN, currval] = findMutualKNN(segmentneighbour, KNN, currentsegment)
mutualKNN = zeros(1, 100);
j = 1;
for i = 1:size(KNN, 2)
    temp = segmentneighbour{KNN(i), 3};
    loc = temp == currentsegment;
    if any(loc) == 1  && ~segmentneighbour{KNN(i), 6}
        mutualKNN(j) = KNN(i);
        currval = segmentneighbour{currentsegment, 4}(i);
        j = j + 1;
    end
end
if j > 1
    mutualKNN = mutualKNN(1:j-1);
else
    mutualKNN = [];
    currval = 0;
end
end