%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function is for growing the segment. It will grow by considering the
% kth nearest mutual neighbourhood property. If the currently growing segment
% is part of already existing segment, the current segment will merge with the
% already existing segment.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [segmentstatus, cursegment] = formingsegment(pos, segmentstatus, loc, VE, connectivity, cursegmentstatus)
cursegment = zeros(1, 1);
cursegment(1, 1) = pos;
i = 2;
ptr = 1;
flag = 1;
startpos = 2*connectivity+3;
cursegmentstatus(pos) = true;

while flag 
    locations = VE(pos, startpos:startpos+VE(pos, 2)-1);
    for k = 1: numel(locations) 
        Tloc = VE(locations(k), 2);
        if ~cursegmentstatus(locations(k))
            Nei = VE(locations(k), startpos:startpos+Tloc-1);
            if any(pos == Nei) %mutualNN(pos, Nei) % find the mutual nearest point of the current point which is not in the current segment
                cursegment(i, 1) = locations(k);
%                 p = segmentstatus(segmentstatus(:,4) == locations(k),2:3);
%                 plot(p(2),p(1),'.'); hold on;
                cursegmentstatus(locations(k)) = true;
                i = i + 1;
            end
        end
    end
    ptr = ptr + 1;
    if ptr > size(cursegment, 1)
        flag = 0;
    else
        pos = cursegment(ptr);
    end
end
segmentstatus(cursegment, 1) = loc;
end