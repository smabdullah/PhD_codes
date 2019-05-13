function [segmentneighbour, segmentstatus, segmentmap, Median, flag1] = mergeSegmentsLevel(segmentneighbour, segmentstatus, kMutualNN, VE, connectivity, Inf, Median, row, col)
sz = max(segmentstatus(:,1));
flag1 = true;
count = 0;
tcount = 0;
segmentmap = [];
i = 1;

while i <= sz
    if any(segmentstatus(:,1) == i)
        %display(i);
        [mutualKNN, maxcurval] = findAllMutualN(i, segmentneighbour);
        if isempty(mutualKNN) == 0
            %tempoutput(i, mutualKNN, segmentstatus);
            segmentstatus = updateSegmentstatus(mutualKNN, i, segmentstatus);
            [segmentneighbour, Median] = updateSegment(segmentneighbour, Median, i, segmentstatus, VE, connectivity, kMutualNN, mutualKNN);
            segmentneighbour{i, 5} = max(double(maxcurval), double(segmentneighbour{i, 5}));
            count = count + 1;
            tcount = tcount + 1;
        else
            if tcount || segmentneighbour{i, 5} ~= -1
                segmentneighbour{i, 6} = 1;
            end
            i = i + 1;
            tcount = 0;
        end
    else
        i = i + 1;
    end
end

if ~count
    flag1 = false;
end

if flag1
    [segmentneighbour, segmentstatus, Median] = updateAfterMerge(segmentneighbour, segmentstatus, Median);
    segmentmap = segmentmapgeneration(segmentstatus(:,1), row, col);
end
end



