function [pos, flag] = findposition(KNN, val)
flag = true;
sz = numel(KNN);
if sz == 0
   pos = 1;
   return;
end
for i = 1:numel(KNN)
   if val < KNN(i)
      flag = false;
      pos = i;
      return;
   end
end
pos = i + 1;
end