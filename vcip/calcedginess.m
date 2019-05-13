function edginess = calcedginess(list, p, V, level)
edgi = 0;
edgiblock = 0.5;
for i = 1:numel(list)
   N = V(list(i)).NN;
   for j = 1:numel(N)
      p1 = findout04(N(j), V, level);
      if p ~= p1
          edgi = edgi + 1;
          break;
      end
   end
end
segsize = numel(list);
if (edgi/segsize) > edgiblock
   edginess = 1;
else
    edginess = 0;
end
end