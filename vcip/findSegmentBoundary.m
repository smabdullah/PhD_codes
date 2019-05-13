function segmentboundary = findSegmentBoundary(segmentmap, segmentstatus, row, col)
sz = max(segmentstatus(:,1));
segmentboundary = cell(sz, 1);
for i = 1:sz
    Point = segmentstatus(segmentstatus(:,1) == i, 4);
    if numel(Point) ~= 1
        segmentboundary{i, 1} = getBoundary(Point, segmentmap, row, col);
    else
        segmentboundary{i, 1} = Point;
    end
end

end

function segbound = getBoundary(segment, segmentmap, row, col)
segbound = [];
for i = 1: size(segment, 1)
    [x, y] = linearto2d(segment(i), col);
    if isBoundary(x, y, segmentmap, row, col)
        segbound = [segbound ; segment(i)];
    end
end
end

function flag = isBoundary(x, y, segmentmap, row, col)
flag = false;
count = 0;
value = segmentmap(x, y);

if x-1 >= 1 && y-1 >= 1 && segmentmap(x-1, y-1) == value
    count = count + 1;
end
if x-1 >= 1 && segmentmap(x-1, y) == value
    count = count + 1;
end
if x-1 >= 1 && y+1 <= col && segmentmap(x-1, y+1) == value
    count = count + 1;
end
if y-1 >= 1 && segmentmap(x, y-1) == value
    count = count + 1;
end
if y+1 <= col && segmentmap(x, y+1) == value
    count = count + 1;
end
if x+1 <= row && y-1 >= 1 && segmentmap(x+1, y-1) == value
    count = count + 1;
end
if x+1 <= row && segmentmap(x+1, y) == value
    count = count + 1;
end
if x+1 <= row && y+1 <= col && segmentmap(x+1, y+1) == value
    count = count + 1;
end
if count < 8
    flag = true;
end
end