function [V, num, count] = lowerlevelmerge(a, V, num, k, locAll, count, cost)
m1 = V(a).m;
% if m1 == 1
%     y = V(a).KNN(1);
%     m2 = V(y).m;
%     %if finditout(V(a).KNN(1:m1), y) && finditout(V(y).KNN(1:m2), a)
%         [V, num] = jointogether(a, y, V, num, k, locAll);
%         count = count + 1;
%         return;
%     %end
%     here = 1;
% end
for j = 1:m1
    %y = findout02(V(a).KNN(j), V);
    y = V(a).KNN(j);
    m2 = V(y).m;
    if finditout(V(a).KNN(1:m1), y) && finditout(V(y).KNN(1:m2), a) %&& abs(V(a).level - V(y).level) <= 1
%         T = V(a).KNN == y;
%         val = V(a).KNNC(T);
%         if val > cost
%             here = 1;
%         end
        [V, num] = jointogether(a, y, V, num, k, locAll);
        count = count + 1;
        return;
    end
end
end