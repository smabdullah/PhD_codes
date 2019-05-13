function D = findNeighbouringSegmentsDistances(segmenti, segmentNeighbouri, Median)
sz = numel(segmentNeighbouri);
D = zeros(1, sz);
M = Median(segmenti, :);

for i = 1: sz
    Mi = Median(segmentNeighbouri(i), :);
    D(i) = deltaE2000(M, Mi);
end
end