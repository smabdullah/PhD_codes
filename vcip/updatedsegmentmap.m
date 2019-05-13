function segmentmap = updatedsegmentmap(segmentmap)
X = unique(segmentmap);
for i = 1:numel(X)
   if i ~= X(i)
%       segmentmap(segmentmap == X(i)) = i;
    [R,C] = find(segmentmap == X(i));
    segmentmap(size(segmentmap), R, C) = i;
   end
end
end