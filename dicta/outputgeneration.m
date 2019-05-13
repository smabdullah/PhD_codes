function outputgeneration(I, filename, segmentstatusAll, segmentmapAll, row, col, subfolder)
[~, folder, ~] = fileparts(pwd);
foldername = strcat('../', folder, '_output/', subfolder);
if isdir(strcat(foldername,'/',filename))
    rmdir(strcat(foldername,'/',filename), 's');
    mkdir(strcat(foldername,'/',filename));
else
    mkdir(strcat(foldername,'/',filename));
end

Inew = zeros(row*col, 3);
for i = 1:row*col
    [x, y] = linearto2d(i, col);
    Inew(i,:) = I(x,y,:);
end
for i = 1: size(segmentstatusAll, 1)
    segmentstatus = segmentstatusAll{i};
    X = sprintf('Level %d segment %d\n',i, numel(unique(segmentmapAll{i})));
    disp(X);
    %segmentbp = findSegmentBoundary(segmentmapAll{i}, segmentstatus, row, col);
    [image2, image3] = resultanalysis2(Inew, segmentstatus, row, col);
    [row, col, ~] = size(image2);
    %image1 = resultanalysis4(segmentstatus, segmentbp, row, col); %boundary
    
    %figfile = strcat(foldername, '/', filename, '/', 'boundary_fig_level_', num2str(i), '.bmp');
    %imwrite(image1,figfile);
%     figfile = strcat(foldername, '/', filename, '/', 'fig_level_', num2str(i), '.png');
%     imwrite(image2,figfile);
%     figfile = strcat(foldername, '/', filename, '/', 'fig_level_', num2str(i), '_', '.png');
%     imwrite(image3,figfile);
    figure, imshow(image3, []);
end
end