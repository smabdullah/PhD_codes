function dirrunLoop()
dict = uigetdir('..\benchmark images');
A = dir(fullfile(dict,'*.jpg'));
version = 1;
colourspace = {"CIELAB"};
colourspace = string(colourspace);
distanceFunc = {"deltaE2000"};
distanceFunc = string(distanceFunc);

for i = 1:length(colourspace)
    for k = 1:length(distanceFunc)
        clc
        count = 1;
        folder_name = strcat(colourspace(i), '_', distanceFunc(k), '_V', num2str(version));
        folder_name = convertStringsToChars(folder_name);
        for j = 1:200
            if A(j).isdir == 0
                fprintf('[%d]: Processing image file: %s\n',count, A(j).name);
                levelSegmentationLoop(dict, A(j).name, folder_name, version, colourspace(i), distanceFunc(k));
                count = count + 1;
            end
        end
        dirrunmatfile(folder_name);
    end
end
end