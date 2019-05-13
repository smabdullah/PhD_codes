function Pvec = getValues(E, I, col)
Pvec = zeros(numel(E), 3);
for i = 1:numel(E)
    [x, y] = linearto2d(E(i), col);
   Pvec(i,:) =  I(x,y,:);
end
end