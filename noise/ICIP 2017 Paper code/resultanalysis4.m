function I = resultanalysis4(segmentstatus, segmentbp, row, col)
I = ones(row, col);
segmentboundarymap = zeros(row, col);
sz = max(segmentstatus(:,1));
for i = 1:sz
    Point = segmentstatus(segmentstatus(:,1) == i, 2:3);
    for j = 1:size(Point, 1)
        segmentboundarymap(Point(j, 1), Point(j, 2)) = i;
    end
    I = putvalues2(I, 0, segmentstatus(segmentbp{i},2:3), segmentboundarymap, i);
    
end
end

function I = putvalues2(I, v, ind, segmentboundarymap, currentseg)
[row, col] = size(segmentboundarymap);
for i = 1:size(ind, 1)
    if isBoundary(ind(i,1), ind(i,2), segmentboundarymap, row, col, currentseg)
        I(ind(i,1), ind(i,2)) = v;
    end
end
end

function flag = isBoundary(x, y, segmentmap, row, col, currentseg)
flag = false;
count = 0;
value = currentseg;

if x-1 >= 1 && y-1 >= 1
    count = count + 1;
end
if x-1 >= 1
    count = count + 1;
end
if x-1 >= 1 && y+1 <= col
    count = count + 1;
end
if y-1 >= 1
    count = count + 1;
end
if y+1 <= col
    count = count + 1;
end
if x+1 <= row && y-1 >= 1
    count = count + 1;
end
if x+1 <= row
    count = count + 1;
end
if x+1 <= row && y+1 <= col
    count = count + 1;
end
maxcount = count;
count = 0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if x-1 >= 1 && y-1 >= 1 && (segmentmap(x-1, y-1) == value || segmentmap(x-1, y-1) == 0)
    count = count + 1;
end
if x-1 >= 1 && (segmentmap(x-1, y) == value || segmentmap(x-1, y) == 0)
    count = count + 1;
end
if x-1 >= 1 && y+1 <= col && (segmentmap(x-1, y+1) == value || segmentmap(x-1, y+1) == 0)
    count = count + 1;
end
if y-1 >= 1 && (segmentmap(x, y-1) == value || segmentmap(x, y-1) == 0)
    count = count + 1;
end
if y+1 <= col && (segmentmap(x, y+1) == value || segmentmap(x, y+1) == 0)
    count = count + 1;
end
if x+1 <= row && y-1 >= 1 && (segmentmap(x+1, y-1) == value || segmentmap(x+1, y-1) == 0)
    count = count + 1;
end
if x+1 <= row && (segmentmap(x+1, y) == value || segmentmap(x+1, y) == 0)
    count = count + 1;
end
if x+1 <= row && y+1 <= col && (segmentmap(x+1, y+1) == value || segmentmap(x+1, y+1) == 0)
    count = count + 1;
end
if count == maxcount
    flag = true;
end
end