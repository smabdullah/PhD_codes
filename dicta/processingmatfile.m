function newsegs = processingmatfile(name, maxlevels)
newsegs = cell(maxlevels-2, 1);
load(name);
sz = size(segs, 1);
j = 1;
for i = 2:sz-1 % skip the first last segmentation
    newsegs{j} = segs{i};
    j = j + 1;
end
for i = j:maxlevels
    newsegs{j} = segs{sz-1};
    j = j + 1;
end
%newsegs{1} = segs{sz};
newsegs = newsegs(~cellfun(@isempty, newsegs));
end