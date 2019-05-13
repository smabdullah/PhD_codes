function [outputImage_mean, outputImage_median] = levelSegmentation(Inoise)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters and their associate values
% addpath('F:\Weekend DIY\Coding\Pooling', 'resmap');
connectivity = 8;
version = 2;
colourspace = 'CIELAB'; %'RGB', 'CIELAB'
showfigure = true;
% Read an image
[Inew, imageType, row, col, dim] = imageRead(Inoise);
   
if imageType ~= 1 && strcmp(colourspace, 'CIELAB') && dim == 3
    Ilab = rgb2lab(Inew);
elseif imageType == 1 && strcmp(colourspace, 'CIELAB') && dim == 1
    Ilab = zeros(row,col,3);
    Ilab(:,:,1) = Inew;
    Ilab(:,:,2) = Inew;
    Ilab(:,:,3) = Inew;
end

if strcmp(colourspace, 'CIELAB')
    [V, E] = precalculation(Ilab, Inew, connectivity, row, col, dim, colourspace);
else
    [V, E] = precalculation([], Inew, connectivity, row, col, dim, colourspace);
end
% disp('Pre-processing completed.');
nextpos = row*col + 1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% disp('Segment formation started.');

    if version == 1
        V = levelSegmentationMerge(V, nextpos, E);
    elseif version == 2
        V = levelSegmentationMerge02(V, nextpos, E);
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% segment map generation
if dim == 3
    tempJ1 = reshape(Inew(:,:,1), row*col, 1);
    tempJ2 = reshape(Inew(:,:,2), row*col, 1);
    tempJ3 = reshape(Inew(:,:,3), row*col, 1);
    J = [tempJ1,tempJ2,tempJ3];
else
    J = reshape(Inew, row*col, 1);
end
segmentmapOutputAll = segmentMapGenerator02(row, col, dim, V, showfigure, J);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
outputImage_mean = segmentmapOutputAll{1, 1};
outputImage_median = segmentmapOutputAll{1, 2};
end