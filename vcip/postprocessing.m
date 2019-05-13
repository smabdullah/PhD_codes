function V = postprocessing(V, E, nlevel, pixelLevel)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
minSize = zeros(nlevel-1, 1);
for i = 1:nlevel-1
   minSize(i) = 2^(i); 
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1:size(E,1)
    alist = pixelLevel(E(i, 1), :);
    blist = pixelLevel(E(i, 2), :);
    for j = nlevel-1:-1:1
        a = alist(j);
        b = blist(j);
        if a~=b && (V(a).size <= minSize(j) || V(b).size <= minSize(j))
            V(a).size = V(a).size + V(b).size;
            %V(a).list = repmat([V(a).list; V(b).list], 1);
            V(a).list = [V(a).list; V(b).list];
            V(b).p = a;
            V(b).level = -1;
            pixelLevel(V(b).list, V(a).level) = a;
        end
    end
end
end
