%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function determines the input image type, convert the value in [0,
% 1] and stored it in a new matrix.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Inew, imageType] = ImageFileConversion(Iinfo, Ioriginal)
Inew = Ioriginal;
row = Iinfo.Height;
col = Iinfo.Width;

if strcmp(Iinfo.ColorType, 'grayscale') == 1
    imageType = 1;
elseif strcmp(Iinfo.ColorType, 'indexed') == 1
    imageType = 2;
elseif strcmp(Iinfo.ColorType, 'truecolor') == 1
    imageType = 3;
end

if imageType == 2
    Inew = GenerateIndexedImage(Ioriginal, Iinfo.Colormap, row, col);
end
end