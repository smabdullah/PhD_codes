%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Based on the provided colormap, generate the new indexed image. The
% offset is determined by the minimum value of the index of the original
% image
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Inew = GenerateIndexedImage(Ioriginal, colorMap, row, col)
Inew(:,:,1:3) = zeros(row, col, 3);
if min(min(Ioriginal)) == 0
    offset = 1;
else
    offset = 0;
end

for i = 1: row
   for j = 1: col
      Inew(i, j, 1:3) = colorMap((Ioriginal(i, j) + offset),:); 
   end
end
end