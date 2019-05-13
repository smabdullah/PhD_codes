function [Inew, imageType, imageName, row, col, pathname] = imageRead(filename, pathname)
if nargin == 0
    [filename, pathname] = uigetfile({'*.jpg;*.jpeg;*.png;*.bmp;*.gif;*.tiff','All Image Files';'*.*','All Files'}, 'Image', '..\');
    inputImage = strcat(pathname, filename);
elseif nargin == 2
    inputImage = strcat(pathname, '\', filename);
end
[~, imageName, ~] = fileparts(filename);
I = imread(inputImage);
Iinfo = imfinfo(inputImage);
[Inew, imageType, row, col] = ImageFileConversion(Iinfo, I);
end