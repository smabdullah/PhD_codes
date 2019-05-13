function X = clusterMapGenerator02(V, nextpos, clusterData)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:size(V,2)
    if isempty(V(i).csp)
        V(i).csp = 1;
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
A = cell2mat({V(nextpos+1:end).level});
maxlevel = max(A);

seglevel = struct('level', [], 'avgcsp', []);
for i = 1:maxlevel
    seglevel(i).level = find(A == i) + nextpos;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
e = 0.0000001;
for i = 1:maxlevel
    for j = 1:numel(seglevel(i).level)
        V(seglevel(i).level(j)).csp = (double(V(seglevel(i).level(j)).separation) - V(seglevel(i).level(j)).compact) / (double(V(seglevel(i).level(j)).separation) + V(seglevel(i).level(j)).compact);
        if abs(V(seglevel(i).level(j)).csp) <= e
            V(seglevel(i).level(j)).csp = 0;
        end
        if isempty(V(seglevel(i).level(j)).csp)
            V(seglevel(i).level(j)).csp = 0;
        end
        if V(seglevel(i).level(j)).csp < 0
           V(seglevel(i).level(j)).csp = abs(V(seglevel(i).level(j)).csp); 
        end
    end
end
A = cell2mat({V(1:end).csp});
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:maxlevel
    data = [];
   for j = 1:numel(seglevel(i).level)
      data = repmat([data; V(seglevel(i).level(j)).list],1);
   end
   here = 1;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:maxlevel
    len = numel(seglevel(i).level);
    seglevel(i).avgcsp = mean(A(seglevel(i).level));
    fprintf('The number of clusters in level %d is: %d\n', i, len);
end

A = cell2mat({seglevel(1:maxlevel).avgcsp});
[val, loc] = max(A);
fprintf('Cluster level [%d] is the best cluster with CSP index of %.4f\n', loc, val);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
PQ = seglevel(loc).level;
X = zeros(size(clusterData, 1),1);
for i = 1:numel(PQ)
   X(V(PQ(i)).list) = i;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end