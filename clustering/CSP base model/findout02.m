function y = findout02(x, V)
y = x;
j = 1;
% list = zeros(1,2);
while y ~= V(y).p
    y = V(y).p;
    j = j + 1;    
end
end