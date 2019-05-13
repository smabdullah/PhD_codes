function estV = filterredImage(Iori)
Immerkaerfilter = [1,-2,1;-2,4,-2;1,-2,1];
Ifilter = imfilter(Iori, Immerkaerfilter);
% minv = min(min(Ifilter));
% maxv = max(max(Ifilter));
%figure('Name', 'Filterred image using Immerkaer''s filter'), imshow(Ifilter, [minv,maxv]);
Id = double(Ifilter);
estV = var(Id(:));
end