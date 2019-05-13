function V = updateNeighbourList04(V, len, k)
for i = 1:len
    if i == 12401 || i == 37480
        here = 1;
    end
    if V(i).size
        changeover = false;
        for j = 1:numel(V(i).KNN)
            T = V(V(i).KNN(j)).KNN == V(i).p;
            if V(i).KNNC(j) > V(V(i).KNN(j)).KNNC(T)
                V(i).KNNC(j) = V(V(i).KNN(j)).KNNC(T);
                changeover = true;
            end
        end
        if changeover
            sz = numel(V(i).KNN);
            A = [V(i).KNN, V(i).KNNC];
            A = sortrows(A, 2);
            V(i).KNN = A(:, 1);
            V(i).KNNC = A(:, 2);
            if sz <= k
                kth = sz;
            else
                kth = k;
                for j = k + 1:sz
                    if V(i).KNNC(j) == V(i).KNNC(k)
                        kth = kth + 1;
                    else
                        break;
                    end
                end
            end
            V(i).m = kth;
        end
    end
end
end