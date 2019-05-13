function [y, V] = findout(x, V)
y = x;
while y ~= V(y).p
   y = V(y).p; 
end
V(x).p = y;
end