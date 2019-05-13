function V = levelSegmentationMerge05(V, nextpos, E, singlelink, J)
i = 1;
flag = true;
alpha = 1;
while flag
            display(i);
            if i == 38001
                here = 1;
            end
    a = findout03(E(i, 1), V);
    b = findout03(E(i, 2), V);
    if a ~= b
        cost = E(i,3);
        flag1 = false;
        edginess = 0;
        if V(a).level > 4 && V(b).level > 4
            here = 1;
        end
        if V(a).level == V(b).level
            level = V(a).level + 1;
        else
            level = max(V(a).level, V(b).level);
        end
        if ((V(a).size < 2^level) || (V(b).size < 2^level)) && (cost > V(a).maxcost && cost > V(b).maxcost)
            flag1 = true;
        end
        
        if V(a).level == V(b).level && ~flag1
            if cost <= V(a).maxcost && cost <= V(b).maxcost
                if V(a).size >= V(b).size
                    if V(a).size == 1 && V(b).size == 1
                        V(nextpos).maxcost = cost;
                        V(nextpos).level = V(a).level + 1;
                        V(nextpos).p = nextpos;
                        V(nextpos).list = [V(a).list ; V(b).list];
                        V(a).p = nextpos;
                        V(b).p = nextpos;
                        V(nextpos).size = V(a).size + V(b).size;
                        nextpos = nextpos + 1;
                    else
                        V(a).list = [V(a).list; V(b).list];
                        V(a).maxcost = cost;
                        V(b).p = V(a).p;
                        V(b).level = -1;
                        V(a).size = V(a).size + V(b).size;
                    end
                else
                    if V(a).size == 1 && V(b).size == 1
                        V(nextpos).maxcost = cost;
                        V(nextpos).level = V(a).level + 1;
                        V(nextpos).p = nextpos;
                        V(nextpos).list = [V(a).list ; V(b).list];
                        V(a).p = nextpos;
                        V(b).p = nextpos;
                        V(nextpos).size = V(a).size + V(b).size;
                        nextpos = nextpos + 1;
                    else
                        V(b).list = [V(a).list; V(b).list];
                        V(b).maxcost = cost;
                        V(a).p = V(b).p;
                        V(a).level = -1;
                        V(b).size = V(a).size + V(b).size;
                    end
                end
            else
                %V(nextpos).maxcost = cost;
                V(nextpos).level = V(a).level + 1;
                V(nextpos).p = nextpos;
                V(nextpos).list = [V(a).list ; V(b).list];
                V(a).p = nextpos;
                V(b).p = nextpos;
                V(nextpos).size = V(a).size + V(b).size;
                V(nextpos).maxcost = cost;
                nextpos = nextpos + 1;
            end
        elseif V(a).level ~= V(b).level && ~flag1
            leveldiff = abs(V(a).level - V(b).level);
            mergelevel = max(V(a).level, V(b).level);
            if (V(a).level < V(b).level)
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                allowedcost = V(b).maxcost + V(b).maxcost*alpha;
                
                if numel(V(a).list) > 1 && numel(V(b).list) > 1
                    cost1 = deltaE2000(median(J(V(a).list,:)), median(J(V(b).list,:)));
                elseif numel(V(a).list) == 1 && numel(V(b).list) == 1
                    cost1 = deltaE2000(J(V(a).list,:), J(V(b).list,:));
                elseif numel(V(a).list) == 1
                    cost1 = deltaE2000(J(V(a).list,:), median(J(V(b).list,:)));
                elseif numel(V(b).list) == 1
                    cost1 = deltaE2000(J(V(b).list,:), median(J(V(a).list,:)));
                end
                
                if cost1 > allowedcost %&& (V(a).size > minsegsize && V(b).size > minsegsize)
                    mergelevel = mergelevel + 1;
                    V(a).p = nextpos;
                    for ii = V(a).level+1:mergelevel-1
                        V(nextpos).maxcost = V(a).maxcost;
                        V(nextpos).level = ii;
                        V(nextpos).size = V(a).size;
                        V(nextpos).p = nextpos+1;
                        V(nextpos).list = V(a).list;
                        nextpos = nextpos + 1;
                    end
                    V(nextpos).list = [V(a).list; V(b).list];
                    V(nextpos).size = V(a).size + V(b).size;
                    V(nextpos).maxcost = cost;
                    V(nextpos).level = mergelevel;
                    V(nextpos).p = nextpos;
                    V(b).p = nextpos;
                    nextpos = nextpos + 1;
                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                else
                    if leveldiff > 1
                        V(a).p = nextpos;
                    end
                    for ii = V(a).level+1:V(b).level-1
                        V(nextpos).maxcost = V(a).maxcost;
                        V(nextpos).level = ii;
                        V(nextpos).size = V(a).size;
                        V(nextpos).p = nextpos+1;
                        V(nextpos).list = V(a).list;
                        nextpos = nextpos + 1;
                    end
                    if leveldiff > 1
                        V(nextpos-1).p = V(b).p;
                    else
                        V(a).p = V(b).p;
                    end
                    V(b).list = [V(a).list; V(b).list];
                    V(b).size = V(a).size + V(b).size;
                    V(b).maxcost = cost;
                    %                     V(b).maxcost = deltaE2000(median(J(V(a).list,:)), median(J(V(b).list,:)));
                end
            else
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                allowedcost = V(a).maxcost + V(a).maxcost*alpha;
                
                if numel(V(a).list) > 1 && numel(V(b).list) > 1
                    cost1 = deltaE2000(median(J(V(a).list,:)), median(J(V(b).list,:)));
                elseif numel(V(a).list) == 1 && numel(V(b).list) == 1
                    cost1 = deltaE2000(J(V(a).list,:), J(V(b).list,:));
                elseif numel(V(a).list) == 1
                    cost1 = deltaE2000(J(V(a).list,:), median(J(V(b).list,:)));
                elseif numel(V(b).list) == 1
                    cost1 = deltaE2000(J(V(b).list,:), median(J(V(a).list,:)));
                end
                
                if cost1 > allowedcost %&& (V(b).size > minsegsize && V(a).size > minsegsize)
                    mergelevel = mergelevel + 1;
                    V(b).p = nextpos;
                    for ii = V(b).level+1:mergelevel-1
                        V(nextpos).maxcost = V(b).maxcost;
                        V(nextpos).level = ii;
                        V(nextpos).size = V(b).size;
                        V(nextpos).p = nextpos+1;
                        V(nextpos).list = V(b).list;
                        nextpos = nextpos + 1;
                    end
                    V(nextpos).list = [V(a).list; V(b).list];
                    V(nextpos).size = V(a).size + V(b).size;
                    V(nextpos).maxcost = cost;
                    V(nextpos).level = mergelevel;
                    V(nextpos).p = nextpos;
                    V(a).p = nextpos;
                    nextpos = nextpos + 1;
                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                else
                    if leveldiff > 1
                        V(b).p = nextpos;
                    end
                    for ii = V(b).level+1:V(a).level-1
                        V(nextpos).maxcost = V(b).maxcost;
                        V(nextpos).level = ii;
                        V(nextpos).size = V(b).size;
                        V(nextpos).p = nextpos+1;
                        V(nextpos).list = V(b).list;
                        nextpos = nextpos + 1;
                    end
                    if leveldiff > 1
                        V(nextpos-1).p = V(a).p;
                    else
                        V(b).p = V(a).p;
                    end
                    V(a).list = [V(a).list; V(b).list];
                    V(a).size = V(a).size + V(b).size;
                    V(a).maxcost = cost;
                    %                     V(a).maxcost = deltaE2000(median(J(V(a).list,:)), median(J(V(b).list,:)));
                end
            end
        end
        i = i + 1;
        if i > size(E,1)
            flag = false;
        end
    end
end