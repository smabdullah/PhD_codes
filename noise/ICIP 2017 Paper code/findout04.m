function y = findout04(x, V, reqlevel)
y = x;
while reqlevel ~= V(y).level
   y = V(y).p; 
end
end