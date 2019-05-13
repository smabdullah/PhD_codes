function V = pushit(V, merge, seg, segcost, k)
status = false;
for i = 1:numel(V(merge).KNN)
    if segcost < V(merge).KNNC(i)
        V(merge).KNN(i+1:end+1, 1) = V(merge).KNN(i:end);
        V(merge).KNNC(i+1:end+1, 1) = V(merge).KNNC(i:end);
        V(merge).KNN(i) = seg;
        V(merge).KNNC(i) = segcost;
        status = true;
        break;
    end
end
if ~status
    V(merge).KNN(i+1) = seg;
    V(merge).KNNC(i+1) = segcost;
end
kth = k;
sz = numel(V(merge).KNN);
if sz <= kth
    m = sz;
else
    for j = k+1:sz
        if V(merge).KNNC(j) == V(merge).KNNC(k)
            kth = kth + 1;
        else
            break;
        end
    end
    m = kth;
end
V(merge).m = m;
end