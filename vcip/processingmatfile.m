% function newsegs = processingmatfile(name, X)
% newsegs = cell(numel(X), 1);
% load(name);
% sz = size(segs, 1);
% j = 1;
% 
% % for i = 2:sz-1
% %     newsegs{j} = segs{i};
% %     j = j + 1;
% % end
% % for i = 1:numel(X) % skip the first last segmentation
% %     newsegs{j} = segs{X(i)+1};
% %     j = j + 1;
% % end
% 
% 
% % for i = 1:numel(X)
% %     newsegs{i} = segs{X(i)};
% % end
% %newsegs{1} = segs{sz};
% % newsegs = newsegs(~cellfun(@isempty, newsegs));
% end
% 
% % function newsegs = processingmatfile(name, maxlevels)
% % newsegs = cell(maxlevels-2, 1);
% % load(name);
% % sz = size(segs, 1);
% %
% % for i = 1:sz
% %    M = segs{i};
% %    val = max(max(M));
% %    if val == 1
% %        level = i-1;
% %        break;
% %    end
% % end
% % j = 1;
% % for i = 3:level % skip the first last segmentation
% %     newsegs{j} = segs{i};
% %     j = j + 1;
% % end
% % for i = j:maxlevels
% %     newsegs{j} = segs{level};
% %     j = j + 1;
% % end
% % %newsegs{1} = segs{sz};
% % newsegs = newsegs(~cellfun(@isempty, newsegs));
% % end

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