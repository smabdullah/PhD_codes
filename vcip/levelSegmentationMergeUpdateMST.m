function V = levelSegmentationMergeUpdateMST(V, nextpos, E, singlelink, J)
CC = 1;
%%%%%%%%%%%
list = zeros(1,2);
i = 1;
%%%%%%%%%%%
while ~isempty(E)
    [a, alist] = findout02(E(i, 1), V, list);
    [b, blist] = findout02(E(i, 2), V, list);
    if a ~= b
        cost = E(i,3);
        if singlelink
            if any(V(E(i,1).KNN) == E(i,2)) && any(V(E(i,2).KNN) == E(i,1))
                CC = 1;
            else
                CC = 0;
            end
        end
        if CC
            if V(a).level == V(b).level
                if cost <= V(a).maxcost && cost <= V(b).maxcost
                    if V(a).size >= V(b).size
                        if V(a).size == 1 && V(b).size == 1
                            V(nextpos).maxcost = cost;
                            V(nextpos).level = V(a).level + 1;
                            V(nextpos).size = V(a).size + V(b).size;
                            V(nextpos).p = nextpos;
                            V(nextpos).list = [V(a).list ; V(b).list];
                            V(nextpos).colourlab = median(J(V(nextpos).list,:));
                            V(a).p = nextpos;
                            V(b).p = nextpos;
                            nextpos = nextpos + 1;
                        else
                            V(a).size = V(a).size + V(b).size;
                            V(a).list = [V(a).list; V(b).list];
                            V(a).colourlab = median(J(V(a).list,:));
                            V(a).maxcost = cost;
                            V(b).p = V(a).p;
                            V(b).level = -1;
                        end
                    else
                        if V(a).size == 1 && V(b).size == 1
                            V(nextpos).maxcost = cost;
                            V(nextpos).level = V(a).level + 1;
                            V(nextpos).size = V(a).size + V(b).size;
                            V(nextpos).p = nextpos;
                            V(nextpos).list = [V(a).list ; V(b).list];
                            V(nextpos).colourlab = median(J(V(nextpos).list,:));
                            V(a).p = nextpos;
                            V(b).p = nextpos;
                            nextpos = nextpos + 1;
                        else
                            V(b).size = V(a).size + V(b).size;
                            V(b).list = [V(a).list; V(b).list];
                            V(b).colourlab = median(J(V(b).list,:));
                            V(b).maxcost = cost;
                            V(a).p = V(b).p;
                            V(a).level = -1;
                        end
                    end
                else
                    V(nextpos).maxcost = cost;
                    V(nextpos).level = V(a).level + 1;
                    V(nextpos).size = V(a).size + V(b).size;
                    V(nextpos).p = nextpos;
                    V(nextpos).list = [V(a).list ; V(b).list];
                    V(nextpos).colourlab = median(J(V(nextpos).list,:));
                    V(a).p = nextpos;
                    V(b).p = nextpos;
                    nextpos = nextpos + 1;
                end
            else
                if (V(a).level < V(b).level)
                    j = 1;
                    while(blist(j, 2) ~= V(a).level + 1)
                        j = j + 1;
                    end
                    V(a).p = blist(j, 1);
                    for k = 1:size(blist, 1)
                        if blist(k, 2) > V(a).level
                            V(blist(k, 1)).size = V(blist(k, 1)).size + V(a).size;
                            V(blist(k, 1)).list = [V(blist(k, 1)).list; V(a).list];
                            V(blist(k, 1)).colourlab = median(J(V(blist(k, 1)).list,:));
                            V(blist(k, 1)).maxcost = cost;
                        end
                    end
                else
                    j = 1;
                    while(alist(j, 2) ~= V(b).level + 1)
                        j = j + 1;
                    end
                    V(b).p = alist(j, 1);
                    for k = 1:size(alist, 1)
                        if alist(k, 2) > V(b).level
                            V(alist(k, 1)).size = V(alist(k, 1)).size + V(b).size;
                            V(alist(k, 1)).list = [V(alist(k, 1)).list; V(b).list];
                            V(alist(k, 1)).colourlab = median(J(V(alist(k, 1)).list,:));
                            V(alist(k, 1)).maxcost = cost;
                        end
                    end
                end
            end
            e1 = E(i,1);
            e2 = E(i,2);
            E(i,:) = [];
            [E, other] = updateCost(e1, e2, E, V);
            E = pushOther(E, other);
        end
    end
end
end

function [E, other] = updateCost(e1, e2, E, V)
X = find(E(:,1) == e1 | E(:,1) == e2);
Y = find(E(:,2) == e1 | E(:,2) == e2);
U = [X;Y];
% U = union(X,Y);
other = E(U,:);
E(U,:) = [];
for ii = 1: size(other, 1)
   a = findout03(other(ii, 1), V);
   b = findout03(other(ii, 2), V);
   other(ii, 3) = deltaE2000(V(a).colourlab, V(b).colourlab);
end
end

function E = pushOther(E, other)
for ii = 1:size(other, 1) 
   pos = findSortedPos(E(:,3), other(ii, 3));
   E(pos+1:end+1,:) = E(pos:end,:);
   E(pos, :) = other(ii, :);
%     F = [E(1:pos,:); other(ii,:); E(pos+1:end,:)];
%     E = F;
end
end

function pos = findSortedPos(E, val)
pos = find(E >= val, 1);
if isempty(pos)
pos = numel(E) + 1;
end
end