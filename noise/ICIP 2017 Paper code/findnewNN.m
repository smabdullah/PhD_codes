function KNN = findnewNN(list, V, num)
KNN = zeros(numel(list), 1);
count = 1;
for i = 1:numel(list)
    if V(list(i)).p > num
        [a, ~] = findout02(list(i), V);
        KNN(count) = a;
        count = count + 1;
    end
end
KNN = KNN(1:count-1);
KNN = unique(KNN);
end