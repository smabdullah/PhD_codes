function KNN = findnewNNC(colourlab, V, KNN, k)
KNNC = zeros(numel(KNN), 1);
for i = 1:numel(KNN)
   KNNC(i) = deltaE2000(colourlab, V(KNN(i)).colourlab); 
end
edge = [KNN, KNNC];
edge = sortrows(edge, 2);
kth = k;
KNN = edge(:,1);
if numel(KNN) <= kth
    return;
else
    for i = k+1:numel(KNN)
        if edge(i, 2) == edge(k, 2)
            kth = kth + 1;
        else
            break;
        end
    end
    KNN = KNN(1:kth);
end
end