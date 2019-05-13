function [Aloc, Aval] = kthNearestNeighbouri04(temploc, tempval, kMutualNN)
if isempty(temploc)
    Aloc = [];
    Aval = [];
    return;
end
pos = 0;
sz = numel(temploc);
Aloc = zeros(1, sz);
Aval = zeros(1, sz);
flag = true;
maxvariation = 0.5;
while flag && sz
    [~, id] = min(tempval);
    pos = pos + 1;
    Aloc(1, pos) = temploc(id);
    Aval(1, pos) = tempval(id);
    tempval(id) = [];
    temploc(id) = [];
    variation = var(Aval(1:pos));
    sz = sz - 1;
    if variation > maxvariation
        flag = false;
        temploc(pos) = 0;
        tempval(pos) = 0;
        pos = pos - 1;
    end
end
Aloc = Aloc(1:pos);
Aval = Aval(1:pos);
end