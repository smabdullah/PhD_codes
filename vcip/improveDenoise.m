function improveDenoise()
addpath resmap
%addpath MST_level_segmentation

% Read Input Image
I = imageRead_new('Original Image');

% Read Denoise Image
Id = imageRead_new('Denoised Image');

% Apply Gaussian Noise
In = addNoise(I, 'gaussian', 50);
% In = I;
estsigmasquare = filterredImage(In);
estsigma = sqrt(estsigmasquare);

Idnew = Id;
[row, col, ~] = size(Id);

for i = 1:row
   for j =  1:col
       if Id(i,j) > 3*estsigma
          Idnew(i,j) = In(i,j); 
       end
   end
end
figure('Name', 'Old Denoise Image'), imshow(Id);
figure('Name', 'New Denoise Image'), imshow(Idnew);
end