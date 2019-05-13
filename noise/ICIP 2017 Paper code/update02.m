function V = update02(mergee, merge, k, V)
for i = 1:numel(V(mergee).KNN)
    seg = V(mergee).KNN(i);
    if seg == 8515
        here = 1;
    end
    T1 = [];
    if seg == merge
        T1 = V(seg).KNN == mergee;
        V(seg).KNN(T1) = [];
        V(seg).KNNC(T1) = [];
    else
        T = V(seg).KNN == mergee;
        hold = V(seg).KNNC(T);
        V(seg).KNN(T) = [];
        V(seg).KNNC(T) = [];
        T1 = V(seg).KNN == merge;
        if any(T1)
            %if V(seg).KNNC(T1) < hold
                %V(seg).KNNC(T1) = hold;
            %end
        else
            V(seg).KNN(end+1) = merge;
            V(seg).KNNC(end+1) = hold;
        end
        T = V(merge).KNN == seg;
        if ~T
            V(merge).KNN(end+1) = seg;
            %V(merge).KNNC(end+1) = V(mergee).KNNC(i);
            V(merge).KNNC(end+1) = hold;
        elseif isempty(T)
            V(merge).KNN(end+1) = seg;
            %V(merge).KNNC(end+1) = V(mergee).KNNC(i);
            V(merge).KNNC(end+1) = hold;
        end
        
        [a, b] = size(V(seg).KNN);
        if a == 1 && b > 1
            V(seg).KNN = V(seg).KNN';
            V(seg).KNNC = V(seg).KNNC';
        end
        sz = numel(V(seg).KNN);
        edge = [V(seg).KNN, V(seg).KNNC];
        %A = [edge(:, 2), edge(:, 3)];
        edge = sortrows(edge, 2);
        V(seg).KNN = edge(:, 1);
        V(seg).KNNC = edge(:, 2);
        kth = k;
        if sz <= kth
            m = sz;
        else
            for j = k+1:sz
                if edge(j, 2) == edge(k, 2)
                    kth = kth + 1;
                else
                    break;
                end
            end
            m = kth;
        end
        V(seg).m = m;
    end
end
[a, b] = size(V(merge).KNN);
if a == 1 && b > 1
    V(merge).KNN = V(merge).KNN';
    V(merge).KNNC = V(merge).KNNC';
end
sz = numel(V(merge).KNN);
edge = [V(merge).KNN, V(merge).KNNC];
edge = sortrows(edge, 2);
V(merge).KNN = edge(:, 1);
V(merge).KNNC = edge(:, 2);
kth = k;
if sz <= kth
    m = sz;
else
    for j = k+1:sz
        if edge(j, 2) == edge(k, 2)
            kth = kth + 1;
        else
            break;
        end
    end
    m = kth;
end
V(merge).m = m;
end