function outputgeneration2(segmentmapAll, folder_name)
foldername = strcat(folder_name, '\myRes');
if isdir(foldername)
    rmdir(foldername, 's');
    mkdir(foldername);
else
    mkdir(foldername);
end

for i = 1: size(segmentmapAll, 1)
    image = uint16(segmentmapAll{i});
    newimage = fullfile(foldername, strcat(num2str(i), '.pgm'));
    imwrite(image, newimage);
end
end