function [V, E] = preCalculationData(data, distanceFunction)
V = struct('size', [], 'p', [], 'level', [], 'maxcost', [], 'list', [], 'compact', [], 'separation', [], 'csp', []);
n = size(data, 1);
for i = 1:n
    V(i).size = 1;
    V(i).p = i;
    V(i).level = 0;
    V(i).maxcost = 0;
    V(i).list = i;
    V(i).compact = 0;
    V(i).separation = [];
    V(i).csp = 1;
end
E = primsMST(V, data, distanceFunction);
end