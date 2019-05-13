function V = updateNeighbourList02(V, len, k)
for i = 1:len
    display(i);
    if i == 12941
        here = 1;
    end
    %token = false;
    for j = numel(V(i).KNN):-1:1
        y = findout02(V(i).KNN(j), V);
        seg = V(i).p;
        
        if seg ~= y
            T = V(seg).KNN == y;
            if any(T) == 0 && V(y).size
                V(seg).KNN(end + 1, 1) = y;
                V(seg).KNNC(end + 1, 1) = V(i).KNNC(j);
            else
                if V(seg).KNNC(T) > V(i).KNNC(j)
                   V(seg).KNNC(T) = V(i).KNNC(j); 
                end
            end
            if V(V(i).KNN(j)).size == 0
                V(i).KNN(j) = [];
                V(i).KNNC(j) = [];
            end
        elseif i == seg
            V(i).KNN(j) = [];
            V(i).KNNC(j) = [];
%             for q = V(seg).m:-1:1
%                 y = findout02(V(seg).KNN(q), V);
%                 if y == seg
%                    V(seg).KNN(1:q) = [];
%                    V(seg).KNNC(1:q) = [];
%                    token = true;
%                    break;
%                 end
%             end
        end
%         if token
%            break; 
%         end
    end
end
%BX = zeros(len, 1);
for i = 1:len
    if i == 38767 || i == 41021
        here = 1;
    end
    %BX(i, 1) = V(i).p; 
    if V(i).size
        A = [V(i).KNN, V(i).KNNC];
        A = sortrows(A, 2);
        V(i).KNN = A(:, 1);
        V(i).KNNC = A(:, 2);
        sz = size(A, 1);
        kth = k;
        if sz <= kth
            m = sz;
        else
            for j = k+1:sz
                if A(j, 2) == A(k, 2)
                    kth = kth + 1;
                else
                    break;
                end
            end
            m = kth;
        end
        V(i).m = m;
    end
end
% BX = unique(BX);
% sz = numel(BX);
end