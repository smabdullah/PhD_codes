function levelSegmentationLoop(pathname, filename, subfolder, ver, colspc, distf)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
addpath('distanceFunction');
connectivity = 8;
version = ver;
colourspace = colspc;
showfigure = false;
filtertype = 'median'; %'guassain'; % 'median'
if version > 1
    postprocess = true;
else
    postprocess = false;
end
showrandom = false;
benchmark = true;
applyfilter = true;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[~, folder, ~] = fileparts(pwd);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Read an image

if nargin == 0
    [I, imageType, imageName, row, col, dim, pathname] = imageRead();
    L = regexp(pathname, '\');
    subfolder = pathname(L(end-1)+1:end-1);
elseif nargin > 0
    [I, imageType, imageName, row, col, dim, ~] = imageRead(filename, pathname);
end

% Image filter and noise
if applyfilter
    Inew = imageFilter(I, dim, filtertype);
else
    Inew = I;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Job starts.');
tic
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RGB to CIELAB 1976 conversion
if imageType ~= 1 && strcmp(colourspace, 'CIELAB') && dim == 3
    Ilab = rgb2lab(Inew);
elseif imageType == 1 && strcmp(colourspace, 'CIELAB') && dim == 1
    Ilab = zeros(row,col,3);
    Ilab(:,:,1) = Inew;
    Ilab(:,:,2) = Inew;
    Ilab(:,:,3) = Inew;
elseif strcmp(colourspace, 'HSV')
    Ihsv = rgb2hsv(Inew);
end
disp('Pre-processing started.');
if strcmp(colourspace, 'CIELAB')
    [V, E] = precalculationLoop(Ilab, connectivity, row, col, dim, colourspace, distf);
elseif strcmp(colourspace, 'RGB')
    [V, E] = precalculationLoop(Inew, connectivity, row, col, dim, colourspace, distf);
else
    [V, E] = precalculationLoop(Ihsv, connectivity, row, col, dim, colourspace, distf);
end
disp('Pre-processing completed.');
nextpos = row*col + 1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Segment formation started.');
pixelLevel = [];
if version == 1
    V = levelSegmentationMerge(V, nextpos, E);
elseif version == 2
    [V, pixelLevel] = levelSegmentationMerge02(V, nextpos, E);
end
disp('Segment formation completed.');

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
segmentmapAll = segmentMapGenerator02(row,col,dim,V,E,showfigure,showrandom,postprocess,J,pixelLevel);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Section for benchmark test
if benchmark
    benchmarkMatFileGenerator(imageName, folder, subfolder, segmentmapAll);
end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
disp('Job done.');
toc;
end