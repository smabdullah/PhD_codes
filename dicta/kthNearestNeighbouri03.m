function [Aloc, Aval] = kthNearestNeighbouri03(temploc, tempval, kMutualNN)
if isempty(temploc)
    Aloc = [];
    Aval = [];
    return;
end
pos = 1;
Inf = 2147483647;
Aloc = zeros(1, kMutualNN);
Aval = zeros(1, kMutualNN);
flag = 1;
ratio = 0;

while flag
    [val, id] = min(tempval);
    if pos > 1
        pk = (abs(val - Aval(1, pos-1)));
        if pk <= 1
            ratio = 0;
        else
            ratio = log((val + Aval(1, pos-1)) / (abs(val - Aval(1, pos-1))));
        end
    end
    if pos <= kMutualNN && val ~= Inf && ratio <= 0.5
        Aloc(1, pos) = temploc(id);
        Aval(1, pos) = tempval(id);
        tempval(id) = Inf;
        temploc(id) = Inf;
        pos = pos + 1;
    else
        flag = 0;
    end
end


while pos > 1 && Aval(1, pos-1) == min(tempval)
    [~, id] = min(tempval);
    Aloc(1, pos) = temploc(id);
    Aval(1, pos) = tempval(id);
    tempval(id) = Inf;
    temploc(id) = Inf;
    pos = pos + 1;
end

Aloc = Aloc(1:pos-1);
Aval = Aval(1:pos-1);
end