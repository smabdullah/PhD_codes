function [Inew, imageType, row, col, dim] = imageRead(I)
Inew = I;
[row,col,dim] = size(Inew);
imageType = dim;
end