function V = clusterMerge_Variant_1(V, E, c, k)
for i = 1:size(E,1)
    a = findout02(E(i, 1), V);
    b = findout02(E(i, 2), V);
    if a > b
        V(a).size = V(a).size + V(b).size;
        V(a).list = [V(a).list;V(b).list];
        V(b).p = a;
        V(a).layer = 1;
        c = c - 1;
    else
        V(b).size = V(a).size + V(b).size;
        V(b).list = [V(a).list;V(b).list];
        V(a).p = b;
        V(b).layer = V(b).layer + 1;
        c = c - 1;
    end
end
end