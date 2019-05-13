function V = update(mergee, merge, k, V, cost)
for i = 1:numel(V(mergee).KNN)
    seg = V(mergee).KNN(i);
    if seg == 51 || seg == 273
        here = 1;
    end
    ssize = numel(V(seg).KNN);
    Z = false(ssize, 1);
    changeover = false;
    for j = 1:ssize
        if ~Z(j)
            y = findout02(V(seg).KNN(j), V);
%             y = V(seg).KNN(j);
%             if y == mergee
%                 y = findout02(y, V);
%             end
%             if V(seg).KNN(j) == mergee
%                 y = findout02(V(seg).KNN(j), V);
%             else
%                 y = V(seg).KNN(j);
%             end
            if V(seg).p ~= y
                %if V(seg).KNN(j) == merge
                if V(seg).KNN(j) == y
                   id = j;
                else
                    id = find(V(seg).KNN == y);
                end
                %id = find(V(seg).KNN == y);
                if id
%                     if id ~= j && y == merge
%                         here = 1;
%                     end
                    if id ~= j
                        V(seg).KNN(j) = y;
%                         if V(seg).KNNC(j) > V(seg).KNNC(id)
%                             V(seg).KNNC(j) = V(seg).KNNC(id);
%                             changeover = true;
%                         end
                        id1 = V(mergee).KNN == y;
                        cost1 = V(mergee).KNNC(id1);
%                         if cost ~= cost1
%                             here = 1;
%                         end
                        V(seg).KNNC(j) = cost1;
                        %V(seg).KNNC(j) = cost; 
                        changeover = true;
                        Z(id) = true;
                    end
                else
                    V(seg).KNN(j) = y;
                    %if V(seg).KNNC(j) > cost
                    id1 = V(mergee).KNN == y;
                       V(seg).KNNC(j) = V(mergee).KNNC(id1); 
                       changeover = true;
                    %end
                end
            else
                Z(j) = true;
            %end
            end
%             if V(V(seg).KNN(j)).size == 0 && Z(j) == false
%                 Z(j) = true;
%             end
        end
    end
    V(seg).KNN(Z) = [];
    V(seg).KNNC(Z) = [];
    sz = numel(V(seg).KNN);
    if changeover
       A = [V(seg).KNN, V(seg).KNNC];
       A = sortrows(A, 2);
       V(seg).KNN = A(:, 1);
       V(seg).KNNC = A(:, 2);
    end
    if sz <= k
        kth = sz;
    else
        kth = k;
        for j = k + 1:sz
            if V(seg).KNNC(j) == V(seg).KNNC(k)
                kth = kth + 1;
            else
                break;
            end
        end
    end
    V(seg).m = kth;
end

% for i = numel(V(merge).KNN):-1:1
%     y = findout02(V(merge).KNN(i), V);
%     if V(y).size == 0
%         V(merge).KNN(i) = [];
%         V(merge).KNNC(i) = [];
%     end
% end

if merge == 51 || merge == 273
    here = 1;
end
anychange = false;
ssz = numel(V(mergee).KNN);
ssz1 = numel(V(merge).KNN);
for j = 1:ssz
    y = findout02(V(mergee).KNN(j), V);
    if y ~= merge
        T = V(merge).KNN == y;
%         if V(y).size == 0
%             here = 1;
%         end
        if any(T) == 0 %&& V(y).size
            anychange = true;
            [pos, flag] = findposition(V(merge).KNNC, V(mergee).KNNC(j));
            if flag
                V(merge).KNN(pos) = y;
                V(merge).KNNC(pos) = V(mergee).KNNC(j);
            else
                s = numel(V(merge).KNN);
                V(merge).KNN(pos+1:s+1) = V(merge).KNN(pos:s);
                V(merge).KNNC(pos+1:s+1) = V(merge).KNNC(pos:s);
                V(merge).KNN(pos) = y;
                V(merge).KNNC(pos) = V(mergee).KNNC(j);
            end
        end
    end
end
if ssz1 == 0 || ssz1 == 1
    [a, b] = size(V(merge).KNN);
    if a == 1 && b > 1
        V(merge).KNN = V(merge).KNN';
        V(merge).KNNC = V(merge).KNNC';
    end
end
if anychange
    sz = numel(V(merge).KNN);
    if sz <= k
        kth = sz;
    else
        kth = k;
        for j = k + 1:sz
            if V(merge).KNNC(j) == V(merge).KNNC(k)
                kth = kth + 1;
            else
                break;
            end
        end
    end
    V(merge).m = kth;
end
% if mergee == 65270
%     here = 1;
% end
V(mergee).KNN = [];
V(mergee).KNNC = [];
V(mergee).m = 0;
end

%         if V(seg).p ~= y
%             T = V(seg).KNN == y;
%             if any(T) && V(y).size
%                 if V(seg).KNNC(T) > V(seg).KNNC(j)
%                     V(seg).KNNC(T) = V(seg).KNNC(j);
%                 end
%             else
%                 [pos, flag] = findposition(V(seg).KNNC, V(seg).KNNC(j));
%                 if flag
%                     V(seg).KNN(pos) = y;
%                     V(seg).KNNC(pos) = V(seg).KNNC(j);
%                 else
%                     s = numel(V(seg).KNN);
%                     V(seg).KNN(pos+1:s+1,1) = V(seg).KNN(pos:s);
%                     V(seg).KNNC(pos+1:s+1,1) = V(seg).KNNC(pos:s);
%                     V(seg).KNN(pos, 1) = y;
%                     V(seg).KNNC(pos, 1) = V(seg).KNNC(j);
%                 end
%             end
%         else
%             Z(j) = true;
%         end