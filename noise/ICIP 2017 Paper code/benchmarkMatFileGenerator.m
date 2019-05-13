function benchmarkMatFileGenerator(imageName, folder, subfolder, segmentmapAll)
segs = segmentmapAll;
matpath = strcat('../', folder, '_mat files/', subfolder);
if isdir(matpath) == 0
    mkdir(matpath);
end
fname = strcat(matpath, '/', imageName, '.mat');
save(fname,'segs');
end