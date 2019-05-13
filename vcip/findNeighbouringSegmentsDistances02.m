function D = findNeighbouringSegmentsDistances02(segmenti, segmentNeighbour, Median)
segmentNeighbouri = segmentNeighbour{segmenti, 1};
sz = numel(segmentNeighbouri);
D = zeros(1, sz);
M = Median(segmenti, :);

for i = 1: sz
    Mi = Median(segmentNeighbouri(i), :);
    D(i) = deltaE2000(M, Mi);
end
end