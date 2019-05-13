function V = postprocessing(V, E, nlevel)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
minSize = zeros(nlevel-1, 1);
for i = 1:nlevel-1
   minSize(i) = 2^(i); 
end
list = zeros(1, 2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:size(E,1)
    [~, alist] = findout05(E(i, 1), V, list);
    [~, blist] = findout05(E(i, 2), V, list);
    for j = nlevel-1:-1:1
        a = alist(j, 1);
        b = blist(j, 1);
        if a~=b && (V(a).size <= minSize(j) || V(b).size <= minSize(j)) %&& E(i,3) <= estV
            V(a).list = [V(a).list; V(b).list];
            V(b).p = a;
            V(b).level = -1;
            V(a).size = V(a).size + V(b).size;
%             V(a).maxcost = max(V(a).maxcost, V(b).maxcost);
        end
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% count = 0;
% for i = 1:size(E,1)
%     for j = nlevel-1:-1:1
%         a = findout04(E(i, 1), V, j);
%         b = findout04(E(i, 2), V, j);
%         if a~=b && (V(a).size < minSize(j) || V(b).size < minSize(j))
%             if V(a).size < minSize(j)
%                 edginess = calcedginess(V(a).list, a, V, j);
%             else
%                 edginess = calcedginess(V(b).list, b, V, j);
%             end
%             if edginess
%                 V(a).list = [V(a).list; V(b).list];
%                 V(b).p = a;
%                 V(b).level = -1;
%                 V(a).size = V(a).size + V(b).size;
%                 V(a).maxcost = max(V(a).maxcost, V(b).maxcost);
%             else
%                 count = count + 1;
%             end
%         end
%     end
% end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% display(count);
end
