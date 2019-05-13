function V = clusterMerge_Variant_2(V, nextpos, E)
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
                        V(nextpos).size = V(a).size + V(b).size;
                        V(nextpos).list = repmat([V(a).list;V(b).list], 1);
                        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                        V(nextpos).compact = cost;
                        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                        V(a).p = nextpos;
                        V(b).p = nextpos;
                        nextpos = nextpos + 1;
                    else
                        V(a).size = V(a).size + V(b).size;
                        V(a).list = repmat([V(a).list;V(b).list], 1);
                        V(a).maxcost = cost;
                        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                        V(a).compact = cost;
                        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                        V(b).p = V(a).p;
                        V(b).level = -1;
                    end
                else
                    if V(a).size == 1 && V(b).size == 1
                        V(nextpos).maxcost = cost;
                        V(nextpos).level = V(a).level + 1;
                        V(nextpos).p = nextpos;
                        V(nextpos).size = V(a).size + V(b).size;
                        V(nextpos).list = repmat([V(a).list;V(b).list], 1);
                        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                        V(nextpos).compact = cost;
                        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                        V(a).p = nextpos;
                        V(b).p = nextpos;
                        nextpos = nextpos + 1;
                    else
                        V(b).size = V(a).size + V(b).size;
                        V(b).list = repmat([V(a).list;V(b).list], 1);
                        V(b).maxcost = cost;
                        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                        V(b).compact = cost;
                        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                        V(a).p = V(b).p;
                        V(a).level = -1;
                    end
                end
            else
                V(nextpos).maxcost = cost;
                V(nextpos).level = V(a).level + 1;
                V(nextpos).p = nextpos;
                V(nextpos).size = V(a).size + V(b).size;
                V(nextpos).list = repmat([V(a).list;V(b).list], 1);
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                if V(a).level
                    V(nextpos).compact = V(a).compact + V(b).compact;
                    V(a).separation = cost;
                    V(b).separation = cost;
%                     if isempty(V(a).separation)
%                         V(a).separation = cost;
%                     else
%                         V(a).separation = min(double(V(a).separation), cost);
%                     end
%                     if isempty(V(b).separation)
%                         V(b).separation = cost;
%                     else
%                         V(b).separation = min(double(V(b).separation), cost);
%                     end
                else
                    V(nextpos).compact = cost;
                end
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                V(a).p = nextpos;
                V(b).p = nextpos;
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
                    V(nextpos).compact = V(a).compact;
                    if isempty(V(a).separation)
                        V(nextpos).separation = cost;
                    else
                        V(nextpos).separation = V(a).separation;
                    end
                    nextpos = nextpos + 1;
                end
                if leveldiff > 1
                    V(nextpos-1).p = V(b).p;
                else
                    V(a).p = V(b).p;
                end
                V(b).size = V(a).size + V(b).size;
                V(b).list = repmat([V(a).list;V(b).list], 1);
                V(b).maxcost = cost;
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                V(b).compact = V(a).compact + V(b).compact;
%                 if isempty(V(a).separation)
%                     V(a).separation = cost;
%                 else
%                     V(a).separation = min(double(V(a).separation), cost);
%                 end
                V(a).separation = cost;
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
                    V(nextpos).compact = V(b).compact;
                    if isempty(V(b).separation)
                        V(nextpos).separation = cost;
                    else
                        V(nextpos).separation = V(b).separation;
                    end
                    nextpos = nextpos + 1;
                end
                if leveldiff > 1
                    V(nextpos-1).p = V(a).p;
                else
                    V(b).p = V(a).p;
                end
                V(a).size = V(a).size + V(b).size;
                V(a).list = repmat([V(a).list;V(b).list], 1);
                V(a).maxcost = cost;
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                V(a).compact = V(a).compact + V(b).compact;
%                 if isempty(V(b).separation)
%                     V(b).separation = cost;
%                 else
%                     V(b).separation = min(double(V(b).separation), cost);
%                 end
                    V(b).separation = cost;
                %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            end
        end
    end
    i = i + 1;
    if i > size(E,1)
        flag = false;
    end
end
end