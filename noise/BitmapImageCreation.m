function [BitmapImageMD,  BitmapImageFA] = BitmapImageCreation(meanImage, medianImage)
[row, col, channel] = size(meanImage);
BitmapImageMD = zeros(row*col, 1, 'uint8');
BitmapImageFA = zeros(row*col, 1, 'uint8');
X = reshape(meanImage, row*col, channel);
for i = 1:numel(BitmapImageFA)
   if all(X(i,:) == 0) || all(X(i,:) == 255) % corrupted pixel
       BitmapImageFA(i) = 1;
   else
       BitmapImageFA(i) = 0;
   end
end

X = reshape(medianImage, row*col, channel);
for i = 1:numel(BitmapImageMD)
   if all(X(i,:) == 0) || all(X(i,:) == 255) % corrupted pixel
       BitmapImageMD(i) = 1;
   else
       BitmapImageMD(i) = 0;
   end
end
end