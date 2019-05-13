%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function will create all the primitive segments (level 1 segments)
% from the input image. This function will start with an unallocated image
% position and grow the segment unless it cannot assign new position to the
% segment.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [segmentstatus, Median] = naturalsegmentation(segmentstatus, VE, connectivity, imageType)
range = size(VE, 1);
loc = 1;
Median = zeros(range, imageType);
cursegmentstatus = false(range, 1);
Tcount = 0;

for i = 1:range
    if segmentstatus(i,1)
        continue;
    else
        [segmentstatus, segment, count] = formingsegment(i, segmentstatus, loc, VE, connectivity, cursegmentstatus);
        if imageType == 1
            Median(loc, :) = median(segmentstatus(segment, 5), 1);
        elseif imageType == 3
            Median(loc, :) = median(segmentstatus(segment, 5:7), 1);
        end
        loc = loc + 1;
        Tcount = Tcount + count;
    end
end
Median = Median(1:loc-1,:);
end

