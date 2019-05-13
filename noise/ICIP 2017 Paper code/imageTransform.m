function I = imageTransform(Inew, connectivity, row, col)
I = Inew;
for i = 1:row
   for j = 1:col
      C = connectivityfinder_2(i, j, Inew, row, col, connectivity); 
      I(i,j,:) = C(:);
   end
end
end