function V = updateNeighbourList(V, sz, connectivity, row, col, k)
if connectivity == 8
    dx = [-1, 0, 1, -1, 1, -1, 0, 1];
    dy = [-1, -1, -1, 0, 0, 1, 1, 1];
elseif connectivity == 4
    dx = [0, -1, 1, 0];
    dy = [-1, 0, 0, 1];
end
for p = 1:sz
    display(p);
    count = numel(V(p).KNN);
    if count
        if p == 17
            here = 1;
        end
        [i, j] = linearto2d(p, col);
        for q = connectivity:-1:1
            inx = i + dx(q);
            iny = j + dy(q);
            if (inx >=1 && inx <= row) && (iny >= 1 && iny <= col)
                y = (inx - 1) * col + iny;
                p1 = findout02(y, V);
                if V(p).p == p1
                    T = V(p).KNN == y;
                    V(p).KNN(T) = [];
                    V(p).KNNC(T) = [];
                end
                %count = count - 1;
            end
        end
        newsz = numel(V(p).KNN);
        if newsz <= k
            kth = newsz;
        else
            kth = k;
            for i = k+1:newsz
                if V(p).KNNC(i) == V(p).KNNC(k);
                    kth = kth + 1;
                end
            end
        end
        V(p).m = kth;
    end
end
end