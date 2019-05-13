function V = clusterMerge_Variant_3(V, nextpos, E)
%%%%%%%%%%%
pos = nextpos;
Glist = zeros(1,2);
%%%%%%%%%%%
for i = 1:size(E,1)
    ck = zeros(10,1);
    ckcount = 1;
%     if E(i,1) == 1544 || E(i,2) == 1544
%         here = 1;
%     end
    [a, alist] = findout02(E(i, 1), V, Glist);
    [b, blist] = findout02(E(i, 2), V, Glist);
    if a ~= b
%                 if a == 6246 || b == 6246
%                     here = 1;
%                 end
        cost = E(i,3);
%         disp(i);
%         if i == 1783
%             here = 1;
%         end
        if V(a).level == V(b).level
            if V(a).size == 1 && V(b).size == 1
                V(nextpos).level = V(a).level + 1;
                V(nextpos).size = V(a).size + V(b).size;
                V(nextpos).p = nextpos;
                V(nextpos).list = repmat([V(a).list ; V(b).list], 1);
                V(nextpos).compact = cost;
                V(a).p = nextpos;
                V(b).p = nextpos;
                nextpos = nextpos + 1;
            elseif V(a).compact/max(V(a).size-1, 1) == cost && V(b).compact/max(V(b).size-1, 1) == cost
                V(a).size = V(a).size + V(b).size;
                V(a).list = repmat([V(a).list; V(b).list], 1);
                V(a).compact = V(a).compact + V(b).compact + cost;
                V(b).p = V(a).p;
                V(b).level = -1;
            else
                V(nextpos).level = V(a).level + 1;
                V(nextpos).size = V(a).size + V(b).size;
                V(nextpos).p = nextpos;
                V(nextpos).list = repmat([V(a).list ; V(b).list], 1);
                V(nextpos).compact = V(a).compact + V(b).compact + cost;
                V(a).separation = cost;
                V(b).separation = cost;
                V(a).p = nextpos;
                V(b).p = nextpos;
                nextpos = nextpos + 1;
            end
        else
            if V(a).level < V(b).level
                minLevel = V(a).level;
                maxLevel = V(b).level;
                list = blist;
            else
                minLevel = V(b).level;
                maxLevel = V(a).level;
                %                 temp = a;
                a = b;
                %                 b = temp;
                list = alist;
                listcount = 1;
                for ii = 1: size(list, 1)
                   if list(ii, 2) == -1
                       listcount = listcount + 1;
                   end
                end
                list = list(listcount:end,:);
            end
            k = 0;
            flag = true;
            for j = minLevel+1:maxLevel
%                 if list(j, 1) == 6246
%                     here = 1;
%                 end
                if isempty(V(list(j, 1)).separation) && flag
                    if ~k
                        V(a).p  = list(j, 1);
                        k = 1;
                        if V(a).level
                            V(a).separation = cost;
                        end
                    end
                    V(list(j, 1)).size = V(list(j, 1)).size + V(a).size;
                    V(list(j, 1)).list = repmat([V(list(j, 1)).list; V(a).list], 1);
                    if ckcount > 1
                        ck(ckcount) = list(j,1);
                        ckcount = ckcount + 1;
                    end
                    if V(a).level
                        V(list(j, 1)).compact = V(list(j, 1)).compact + V(a).compact + cost;
                    else
                        V(list(j, 1)).compact = V(list(j, 1)).compact + cost;
                    end
                else
                    segsize = V(list(j, 1)).size - 1 + V(a).size - 1 + 1;
                    if segsize <= 0
                        segsize = 1;
                    end
                    if flag && V(list(j, 1)).separation >= (V(list(j, 1)).compact + V(a).compact + cost)/ segsize
                        if ~k
                            V(a).p  = list(j, 1);
                            if V(a).level
                                V(a).separation = cost;
                            end
                            k = 1;
                        end
                        V(list(j, 1)).size = V(list(j, 1)).size + V(a).size;
                        V(list(j, 1)).list = repmat([V(list(j, 1)).list; V(a).list], 1);
                        if ckcount > 1
                            ck(ckcount) = list(j,1);
                            ckcount = ckcount + 1;
                        end
                        if V(a).level
                            V(list(j, 1)).compact = V(list(j, 1)).compact + V(a).compact + cost;
                        else
                            V(list(j, 1)).compact = V(list(j, 1)).compact + cost;
                        end
                    else
                        if ~k
                            V(a).p  = nextpos;
                            if V(a).level
                                V(a).separation = cost;
                            end
                            k = 1;
                        end
                        V(nextpos).level = j;
                        V(nextpos).size = V(a).size;
                        if j ~= maxLevel
                            V(nextpos).p = nextpos+1;
                            ck(ckcount) = V(nextpos).p;
                            ckcount = ckcount + 1;
                        else
                            V(nextpos).p = nextpos;
                            ck(ckcount) = V(nextpos).p;
                            ckcount = ckcount + 1;
                        end
                        V(nextpos).list = V(a).list;
                        V(nextpos).compact = V(a).compact;
                        V(nextpos).separation = cost;
                        nextpos = nextpos + 1;
                        %                         flag = false;
                    end
                end
            end
            ck = ck(1:ckcount-1);
            Vsize = size(V,2);
            %%%%%%%%%%%
            myFlag = true;
            flag = true;
            
            timeone = 1;
            ii = 1;
            while flag && isempty(ck) == 0
                psize = 0;
                for j = ii+2:numel(ck)-1
                   if ck(j) - ck(ii) == 1
                      q = j;
                      if timeone
                          p = ii;
                          timeone = 0;
                      end
                      ii = q;
                      psize = 1;
                      if nextpos == ck(q)
                        myFlag = false;
                        break;
                      end
                   end
                end
                if psize == 0 && ii == numel(ck)
                    flag = false;
                end
                ii = ii + 1;
            end
            
            if myFlag == false
                ckcount = 2;
                for ii = p+1:q
                    if ckcount == 0
                        ckcount = 1;
                    end
                    V(V(nextpos-ckcount).p).list = V(ck(p)-1).list;
                    V(V(nextpos-ckcount).p).level = ii;
                    V(V(nextpos-ckcount).p).size = numel(V(V(nextpos-ckcount).p).list);
                    if nextpos == size(V,2)
                        V(V(nextpos-ckcount).p).p = nextpos + 1;
                    else
                        V(V(nextpos-ckcount).p).p = nextpos;
                    end
                    V(V(nextpos-ckcount).p).compact = V(ck(p)-1).compact;
                    V(V(nextpos-ckcount).p).separation = V(ck(p)-1).separation;
                    if any(ismember(V(list(ii,1)).list,V(ck(p)).list)) == 1
                        V(list(ii,1)).list = setdiff(V(list(ii,1)).list, V(ck(p)).list);
                        V(list(ii,1)).size = numel(V(list(ii,1)).list);
                        V(list(ii,1)).compact = V(list(ii,1)).compact - cost;
                    end
                    nextpos = size(V,2) + 1;
                    ckcount = ckcount - 1;
                end
                V(nextpos-1).p = ck(q+1);
            else
                %%%%%%%%%%%
                for p = 1:numel(ck)
                    if ck(p) > Vsize
                        if p+1 <= numel(ck)
                            V(ck(p)-1).p = ck(p+1);
                        else
                            V(ck(p)-1).p = ck(p) - 1;
                        end
                    end
                end
            end
        end
    end
end

for i = pos:size(V,2)
    V(i).compact = V(i).compact / max(V(i).size-1, 1);
end
end