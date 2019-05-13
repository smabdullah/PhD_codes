function Inew = imageRead_new(msg)
[filename, pathname] = uigetfile({'*.jpg;*.jpeg;*.png;*.bmp;*.gif;*.tiff','All Image Files';'*.*','All Files'}, msg);
inputImage = strcat(pathname, filename);
I = imread(inputImage);
Iinfo = imfinfo(inputImage);
[Inew, imageType] = ImageFileConversion(Iinfo, I);
[row,col,dim] = size(Inew);
if dim == 3
    maxinten = max(max(max(Inew)));
    if maxinten > 1
        Inew = double(Inew)/double(255);
    end
end
if dim == 1
    maxinten = max(max(Inew));
    if maxinten > 1
        Inew = double(Inew)/double(255);
    end
end
end