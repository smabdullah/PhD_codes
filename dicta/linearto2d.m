% This function takes a linear location and converts it back to two dimentional
% image location.
function [x, y] = linearto2d(pos, column)
modval = mod(pos, column);
if ~modval
    x = floor(pos / column);
    y = column;
else
    x = floor(pos / column) + 1;
    y = modval;
end
end