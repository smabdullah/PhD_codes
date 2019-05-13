function [V, count] = processVKNN(V, L, k)
count = 0;
for i = 1:L
    if V(i).rank == 0 && V(i).size == 1 && V(i).p == i
        count = count + 1;
    end
   if numel(V(i).KNN) > 1
      X = V(i).KNN;
      X(1) = [];
      X = sort(X);
      if numel(X) <= k
         V(i).KNN = X(end);
      else
          V(i).KNN = X(k);
      end
   end
end
end