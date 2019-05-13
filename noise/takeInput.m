function [Image, textName] = takeInput(varargin)
if varargin{1}
    Image = createImage();
else
    if nargin == 1
        [fileName, pathName] = uigetfile({'*.jpg;*.jpeg;*.png;*.bmp;*.gif;*.tiff','All Image Files';'*.*','All Files'});
    else
        pathName = varargin{2};
        fileName = varargin{3};
    end
    [~, textName, ~] = fileparts(fileName);
    inputImage = fullfile(pathName, fileName);
    Image = imread(inputImage);
end
end