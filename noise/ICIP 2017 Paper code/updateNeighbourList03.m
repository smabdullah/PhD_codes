function V = updateNeighbourList03(V, len, k1)
for i = 1:len
    display(i);
    if i == 41021
        here = 1;
    end
    count = 1;
    for j = numel(V(i).KNN):-1:1
        y = findout02(V(i).KNN(j), V);
        if V(i).p == y
            V(i).KNN(j) = [];
            V(i).KNNC(j) = [];
        end
    end
    for j = 1:numel(V(i).KNN)
        y = findout02(V(i).KNN(j), V);
        T = V(i).KNN(1:count-1) == y;
        if any(T)
            if V(i).KNNC(T) > V(i).KNNC(j)
                V(i).KNNC(T) = V(i).KNNC(j);
            end
        else
            V(i).KNN(count) = y;
            V(i).KNNC(count) = V(i).KNNC(j);
            count = count + 1;
        end
    end
    V(i).KNN = V(i).KNN(1:count-1);
    V(i).KNNC = V(i).KNNC(1:count-1);
    %if count-1 > 0
    kth = k1;
    if count-1 <= kth
        m = count-1;
    else
        for j = k1+1:count-1
            if V(i).KNNC(j) == V(i).KNNC(k1)
                kth = kth + 1;
            else
                break;
            end
        end
        m = kth;
    end
    V(i).m = m;
    %end
end
end