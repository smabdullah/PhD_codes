function nonDirRun()
[fileName, pathName] = uigetfile({'*.jpg;*.jpeg;*.png;*.bmp;*.gif;*.tiff','All Image Files';'*.*','All Files'});
ImpulseNoise(pathName, fileName);
end