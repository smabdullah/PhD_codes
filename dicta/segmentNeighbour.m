function segmentneighbour = segmentNeighbour(segmentstatus, VE, connectivity, kMutualNN, Median, ~)
sz = max(segmentstatus(:,1));
segmentneighbour = cell(sz, 6);
for i = 1:sz
    segmentneighbour{i, 1} = findNeighbouringSegments(segmentstatus(segmentstatus(:, 1) == i, 4), segmentstatus, i, VE, connectivity);
    segmentneighbour{i, 2} = findNeighbouringSegmentsDistances(i, segmentneighbour{i, 1}, Median);
    [segmentneighbour{i, 3}, segmentneighbour{i, 4}] = kthNearestNeighbouri03(segmentneighbour{i, 1}, segmentneighbour{i, 2}, kMutualNN);
if nargin == 6
    segmentneighbour{i, 5} = -1;
    segmentneighbour{i, 6} = 0;
end
end
end