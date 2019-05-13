function HMNNSegmentation(pathname, filename, subfolder)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameters and their associate values
clc
connectivity = 8;
k = 3;
locAll = 2;
maxlevel = 100;
Inf = 2147483647;
colourspace = 'CIELAB'; %'RGB', 'CIELAB'
segmentmapAll = cell(maxlevel, 1);
segmentstatusAll = cell(maxlevel, 1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[~, folder, ~] = fileparts(pwd);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Input section
% Read an image
if nargin == 0
    [I, imageType, imageName, row, col, pathname] = imageRead();
    L = regexp(pathname, '\');
    subfolder = pathname(L(end-1)+1:end-1);
elseif nargin > 0
    [I, imageType, imageName, row, col, ~] = imageRead(filename, pathname);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Add noise to the image (for experimental purpose)
% Inoise = imnoise(I,'gaussian',0,0.01);
% %imshow(Inoise);
% imwrite(Inoise, strcat(imageName, '_noise', '.jpg'));
% I = Inoise;
% rng(0);
% sigma = 5.0;
% I = I + sigma/255 * randn(size(I));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A Guassian filter to smooth the input image
Inew = imgaussfilt(I, 0.2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parallel pool creation (4 workers)
poolobj = gcp('nocreate');
if isempty(poolobj)
    parpool('local', 2);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
display(strcat('Job starts for #', ' ', imageName));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RGB to CIELAB 1976 conversion
if imageType ~= 1 && strcmp(colourspace, 'CIELAB')
    Ilab = rgb2lab(Inew);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Pre-calculation
display('Pre-processing started.');
[segmentstatus, VE] = precalculation(Ilab, imageType, connectivity, k, row, col);
display('Pre-processing completed.');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Natural level segment formation
display('Natural segment formation started.');
[segmentstatus, Median] = naturalsegmentation(segmentstatus, VE, connectivity, imageType);
segmentneighbour = segmentNeighbour(segmentstatus, VE, connectivity, k, Median, locAll);
segmentmap = segmentmapgeneration(segmentstatus(:,1), row, col);
display('Natural segment formation completed.');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
segmentmapAll{locAll} = segmentmap;
segmentstatusAll{locAll} = segmentstatus;
locAll = locAll + 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Higher level segment generation
prevnumofseg = 0;
currnumofseg = max(segmentstatus(:,1));
flag = true;
%imshow(Inew); hold on;
while prevnumofseg ~= currnumofseg && currnumofseg ~= 1 && flag
    display(strcat('Level#', ' ',num2str(locAll), ' segmentation generation started'));
    prevnumofseg = currnumofseg;
    [segmentneighbour, segmentstatus, segmentmap, Median, flag] = mergeSegmentsLevel(segmentneighbour, segmentstatus, k, VE, connectivity, Inf, Median, row, col);
    segmentstatusAll{locAll} = segmentstatus;
    segmentmapAll{locAll} = segmentmap;
    currnumofseg = max(segmentstatus(:,1));
    display(strcat('Level#', ' ',num2str(locAll), ' segmentation generation completed'));
    locAll = locAll + 1;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Section for benchmark test
segmentmapAll = segmentmapAll(~cellfun(@isempty,segmentmapAll));
segs = segmentmapAll;
matpath = strcat('../', folder, '_mat files/', subfolder);
if isdir(matpath) == 0
    mkdir(matpath);
end
fname = strcat(matpath, '/', imageName, '.mat');
save(fname,'segs');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% output module
display('Segment generation completed! Wait for output generation.');
segmentstatusAll = segmentstatusAll(~cellfun(@isempty,segmentstatusAll));
outputgeneration(Inew, strcat(imageName, '_' ,num2str(k)), segmentstatusAll, segmentmapAll, row, col, subfolder);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
display(strcat('Job done for #', ' ',imageName));
end