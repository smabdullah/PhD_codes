function D = findNeighbouringSegmentsDistances(segmenti, segmentNeighbour, Median)
segmentNeighbouri = segmentNeighbour{segmenti, 1};
sz = numel(segmentNeighbouri);
D = zeros(1, sz);
D(:) = 2147483647;
M = Median(segmenti, :);

for i = 1: sz
    p = segmentNeighbour{segmentNeighbouri(i), 1} == segmenti;
    if numel(p)
        D(i) = segmentNeighbour{segmentNeighbouri(i), 2}(p);
    end
    if D(i) == 2147483647
        Mi = Median(segmentNeighbouri(i), :);
        D(i) = deltaE2000(M, Mi);
    end
end
end