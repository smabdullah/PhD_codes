function L = findNeighbouringSegments(segmentboundary, segmentstatus, currentsegment, VE, connectivity)
temp = VE(segmentboundary, 3:3+connectivity-1);
L1 = temp(temp ~= 0);
A = L1(segmentstatus(L1, 1) ~= currentsegment);
L = unique(segmentstatus(A, 1));
end