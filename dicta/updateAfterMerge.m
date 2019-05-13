function [segmentneighbour, segmentstatus, Median] = updateAfterMerge(segmentneighbour, segmentstatus, Median)
j = 1;
sz = max(segmentstatus(:,1));
replacewith = zeros(sz, 1);
for i = 1:sz
    if any(segmentstatus(segmentstatus(:,1) == i))
        if j ~= i
            T = segmentstatus(:, 1) == i;
            segmentstatus(T, 1) = j;
        end
        segmentneighbour{j, 1} = segmentneighbour{i, 1};
        segmentneighbour{j, 2} = segmentneighbour{i, 2};
        segmentneighbour{j, 3} = segmentneighbour{i, 3};
        segmentneighbour{j, 4} = segmentneighbour{i, 4};
        segmentneighbour{j, 5} = segmentneighbour{i, 5};
        segmentneighbour{j, 6} = 0;
        Median(j, :) = Median(i, :);
        replacewith(i) = j;
        j = j + 1;
    end
end
for i = 1:j-1
   for k = 1:numel(segmentneighbour{i, 1})
       segmentneighbour{i, 1}(k) = replacewith(segmentneighbour{i, 1}(k));
   end
   for k = 1:numel(segmentneighbour{i, 3})
       segmentneighbour{i, 3}(k) = replacewith(segmentneighbour{i, 3}(k));
   end
end
end