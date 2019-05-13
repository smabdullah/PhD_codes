function segmentedBitmap = BitmapImageCreation02(Info, row, col)
segmentedBitmap = zeros(row*col, 1, 'uint8');
for i = 1:numel(Info)
   if Info(i).size < 4
      segmentedBitmap(Info(i).member) = 1; 
   end
end
end