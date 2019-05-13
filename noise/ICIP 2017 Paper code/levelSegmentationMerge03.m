function V = levelSegmentationMerge03(V, nextpos, E, singlelink, J)
i = 1;
flag = true;
alpha = 0.5;
list = zeros(1,2);
while flag
    %     display(i);
    %     a = findout03(E(i, 1), V);
    %     b = findout03(E(i, 2), V);
    [a, alist] = findout02(E(i, 1), V, list);
    [b, blist] = findout02(E(i, 2), V, list);
    %     if E(i,1) == 100 && E(i,2) == 101
    %         here = 1;
    %     end
    if a ~= b
        cost = E(i,3);
        CC = 1;
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if singlelink
            if any(V(E(i,1)).KNN == E(i,2)) && any(V(E(i,2)).KNN == E(i,1))
                CC = 1;
            else
                CC = 0;
            end
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %         if V(a).level >= 1 && V(b).level >= 1
        %             newcost = deltaE2000(median(J(V(a).list, :)), median(J(V(b).list, :)));
        %             if newcost > cost
        %                 position = find(E(:,3) > newcost, 1);
        %                 if isempty(position)
        %                     E(end+1,:) = E(i,:);
        %                     E(end, 3) = newcost;
        %                 else
        %                     E(position+1:end+1,:) = E(position:end,:);
        %                     E(position,:) = E(i,:);
        %                     E(position, 3) = newcost;
        %                 end
        %                 CC = 0;
        %             end
        %         end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if CC
            if V(a).level == V(b).level
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
                    V(nextpos).maxcost = cost;
                    V(nextpos).level = V(a).level + 1;
                    V(nextpos).p = nextpos;
                    V(nextpos).list = [V(a).list ; V(b).list];
                    V(a).p = nextpos;
                    V(b).p = nextpos;
                    V(nextpos).size = V(a).size + V(b).size;
                    nextpos = nextpos + 1;
                end
            else
                leveldiff = abs(V(a).level - V(b).level);
                mergelevel = max(V(a).level, V(b).level);
                minsegsize = 2^mergelevel/2;
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                if V(a).size < minsegsize || V(b).size < minsegsize
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
                                V(alist(k, 1)).maxcost = cost;
                            end
                        end
                    end
                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                else
                    if (V(a).level < V(b).level)
                        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                        allowedcost = V(b).maxcost + V(b).maxcost*alpha;
                        if cost > allowedcost %&& (V(a).size > minsegsize && V(b).size > minsegsize)
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
                        end
                    else
                        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                        allowedcost = V(a).maxcost + V(a).maxcost*alpha;
                        if cost > allowedcost %&& (V(b).size > minsegsize && V(a).size > minsegsize)
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
                        end
                    end
                end
            end
        end
        i = i + 1;
        if i > size(E,1)
            flag = false;
        end
    end
end