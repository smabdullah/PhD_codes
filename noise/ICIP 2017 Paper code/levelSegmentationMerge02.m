function V = levelSegmentationMerge02(V, nextpos, E)
i = 1;
flag = true;
while flag
    [a, b] = findout03(E(i, 1), E(i, 2), V);
    if a ~= b
        cost = E(i,3);
        if V(a).level == V(b).level
            if cost <= V(a).maxcost && cost <= V(b).maxcost
                if V(a).size >= V(b).size
                    if V(a).size == 1 && V(b).size == 1
                        V(nextpos).maxcost = cost;
                        V(nextpos).level = V(a).level + 1;
                        V(nextpos).p = nextpos;
                        V(nextpos).list = repmat([V(a).list;V(b).list], 1);
                        V(a).p = nextpos;
                        V(b).p = nextpos;
                        V(nextpos).size = V(a).size + V(b).size;
                        nextpos = nextpos + 1;
                    else
                        V(a).list = repmat([V(a).list;V(b).list], 1);
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
                        V(nextpos).list = repmat([V(a).list;V(b).list], 1);
                        V(a).p = nextpos;
                        V(b).p = nextpos;
                        V(nextpos).size = V(a).size + V(b).size;
                        nextpos = nextpos + 1;
                    else
                        V(b).list = repmat([V(a).list;V(b).list], 1);
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
                V(nextpos).list = repmat([V(a).list;V(b).list], 1);
                V(a).p = nextpos;
                V(b).p = nextpos;
                V(nextpos).size = V(a).size + V(b).size;
                nextpos = nextpos + 1;
            end
        else
            leveldiff = abs(V(a).level - V(b).level);
            if (V(a).level < V(b).level)
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
                V(b).list = repmat([V(a).list;V(b).list], 1);
                V(b).size = V(a).size + V(b).size;
                V(b).maxcost = cost;
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
                V(a).list = repmat([V(a).list;V(b).list], 1);
                V(a).size = V(a).size + V(b).size;
                V(a).maxcost = cost;
            end
        end
    end
    i = i + 1;
    if i > size(E,1)
        flag = false;
    end
end
end