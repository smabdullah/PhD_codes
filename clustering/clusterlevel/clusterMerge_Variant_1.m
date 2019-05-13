function V = clusterMerge_Variant_1(V, nextpos, E, clusterData)
%%%%%%%%%%%
list = zeros(1,2);
%%%%%%%%%%%
for i = 1:size(E,1)
    [a, alist] = findout02(E(i, 1), V, list);
    [b, blist] = findout02(E(i, 2), V, list);
    if a ~= b
        cost = E(i,3);
        if V(a).level == V(b).level
            if cost <= V(a).maxcost && cost <= V(b).maxcost
                if V(a).size >= V(b).size
                    if V(a).size == 1 && V(b).size == 1
                        V(nextpos).maxcost = cost;
                        V(nextpos).level = V(a).level + 1;
                        V(nextpos).size = V(a).size + V(b).size;
                        V(nextpos).p = nextpos;
                        V(nextpos).list = repmat([V(a).list ; V(b).list], 1);
                        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                        V(nextpos).compact = cost;
                        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                        V(a).p = nextpos;
                        V(b).p = nextpos;
                        nextpos = nextpos + 1;
                    else
                        V(a).size = V(a).size + V(b).size;
                        V(a).list = repmat([V(a).list; V(b).list], 1);
                        V(a).maxcost = cost;
                        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                        V(a).compact = V(a).compact + V(b).compact;
                        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                        V(b).p = V(a).p;
                        V(b).level = -1;
                    end
                else
                    if V(a).size == 1 && V(b).size == 1
                        V(nextpos).maxcost = cost;
                        V(nextpos).level = V(a).level + 1;
                        V(nextpos).size = V(a).size + V(b).size;
                        V(nextpos).p = nextpos;
                        V(nextpos).list = repmat([V(a).list ; V(b).list], 1);
                        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                        V(nextpos).compact = cost;
                        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                        V(a).p = nextpos;
                        V(b).p = nextpos;
                        nextpos = nextpos + 1;
                    else
                        V(b).size = V(a).size + V(b).size;
                        V(b).list = repmat([V(a).list; V(b).list], 1);
                        V(b).maxcost = cost;
                        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                        V(b).compact = V(a).compact + V(b).compact;
                        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                        V(a).p = V(b).p;
                        V(a).level = -1;
                    end
                end
            else
                V(nextpos).maxcost = cost;
                V(nextpos).level = V(a).level + 1;
                V(nextpos).size = V(a).size + V(b).size;
                V(nextpos).p = nextpos;
                V(nextpos).list = repmat([V(a).list ; V(b).list], 1);
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                if V(a).level
                    V(nextpos).compact = V(a).compact + V(b).compact;
                    V(a).separation = cost;
                    V(b).separation = cost;
                else
                    V(nextpos).compact = cost;
                end
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                if V(a).level
                    V(a).separation = cost;
                end
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                for k = 1:size(blist, 1)
                    if blist(k, 2) > V(a).level
                        V(blist(k, 1)).size = V(blist(k, 1)).size + V(a).size;
                        V(blist(k, 1)).list = repmat([V(blist(k, 1)).list; V(a).list], 1);
                        V(blist(k, 1)).maxcost = cost;
                        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                        if V(a).level
                            V(blist(k, 1)).compact = V(blist(k, 1)).compact + V(a).compact;
                        else
                            V(blist(k, 1)).compact = V(blist(k, 1)).compact + cost;
                        end
                        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    end
                end
            else
                j = 1;
                while(alist(j, 2) ~= V(b).level + 1)
                    j = j + 1;
                end
                V(b).p = alist(j, 1);
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                if V(b).level
                    V(b).separation = cost;
                end
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                for k = 1:size(alist, 1)
                    if alist(k, 2) > V(b).level
                        V(alist(k, 1)).size = V(alist(k, 1)).size + V(b).size;
                        V(alist(k, 1)).list = repmat([V(alist(k, 1)).list; V(b).list], 1);
                        V(alist(k, 1)).maxcost = cost;
                        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                        if V(b).level
                            V(alist(k, 1)).compact = V(alist(k, 1)).compact + V(b).compact;
                        else
                            V(alist(k, 1)).compact = V(alist(k, 1)).compact + cost;
                        end
                        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    end
                end
            end
        end
    end
end
end