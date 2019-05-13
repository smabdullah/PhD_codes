function [segmentneighbour, Median] = updateSegment(segmentneighbour, Median, i, segmentstatus, VE, connectivity, kMutualNN, mutualKNN)
Point = segmentstatus(segmentstatus(:, 1) == i, 5:7);
Median(i, :) = median(Point, 1);
segmentneighbour{i, 1} = findNeighbouringSegments(segmentstatus(segmentstatus(:, 1) == i, 4), segmentstatus, i, VE, connectivity);
segmentneighbour{i, 2} = findNeighbouringSegmentsDistances(i, segmentneighbour{i, 1}, Median);
[segmentneighbour{i, 3}, segmentneighbour{i, 4}] = kthNearestNeighbouri03(segmentneighbour{i, 1}, segmentneighbour{i, 2}, kMutualNN);

for j = 1: numel(segmentneighbour{i, 1})
    loc = segmentneighbour{i, 1}(j);
    A = 0;
    for k = 1: numel(mutualKNN)
       A = A | (segmentneighbour{loc, 1} == mutualKNN(k)); 
    end
    segmentneighbour{loc, 1}(A) = [];
    segmentneighbour{loc, 2}(A) = [];
    
    A = segmentneighbour{loc, 1} == i;
    if any(A)
        segmentneighbour{loc, 2}(A) = deltaE2000(Median(i, :), Median(loc, :));
    else
        segmentneighbour{loc, 1}(end+1) = i;
        segmentneighbour{loc, 2}(end+1) = deltaE2000(Median(i, :), Median(loc, :));
    end
    [segmentneighbour{loc, 3}, segmentneighbour{loc, 4}] = kthNearestNeighbouri03(segmentneighbour{loc, 1}, segmentneighbour{loc, 2}, kMutualNN);
end
end