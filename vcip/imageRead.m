function [Inew, imageType, imageName, row, col, dim, pathname] = imageRead(filename, pathname)
if nargin == 0
    [filename, pathname] = uigetfile({'*.jpg;*.jpeg;*.png;*.bmp;*.gif;*.tiff','All Image Files';'*.*','All Files'}, 'Image', '..\..\');
    inputImage = strcat(pathname, filename);
elseif nargin == 2
    inputImage = strcat(pathname, '\', filename);
end
[~, imageName, ~] = fileparts(filename);
I = imread(inputImage);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% I = imgaussfilt(I, 0.8);
% figure,imshowpair(I,I1,'montage');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Iinfo = imfinfo(inputImage);
[Inew, imageType] = ImageFileConversion(Iinfo, I);
[row,col,dim] = size(Inew);
if dim == 3
    maxinten = double(max(max(max(Inew))));
    mininten = double(min(min(min(Inew))));
    if maxinten > 1
%         Inew = double(Inew)/double(255);
        Inew = (double(Inew) - mininten) / (maxinten - mininten);
    end
end
if dim == 1
    maxinten = double(max(max(Inew)));
    mininten = double(min(min(Inew)));
    if maxinten > 1
%         Inew = double(Inew)/double(255);
        Inew = (double(Inew) - mininten) / (maxinten - mininten);
    end
end
end