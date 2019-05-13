function [segmentmapAll, seglevel] = segmentMapGenerator(row,col,dim,V,E,showfigure,showstat,showrandom,imageName,putcolour,postprocess)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% if isdir(imageName)
%    rmdir(imageName, 's');
%    mkdir(imageName);
% else
%     mkdir(imageName);
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
maxlevel = max(cell2mat({V(1:end).level}));
seglevel = struct('level', [], 'size', []);
for i = 1:maxlevel
    seglevel(i).level = 0;
end
if ~postprocess
    for i = row*col+1:numel(V)
        if V(i).level >= 1
            seglevel(V(i).level).level = [seglevel(V(i).level).level; i];
            seglevel(V(i).level).size = [seglevel(V(i).level).size; V(i).size];
        end
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if postprocess
    disp('Post-processing started.');
    minSize = 50;
    V = postprocessing(V, E, minSize, maxlevel,putcolour);
    seglevel = struct('level', [], 'size', []);
    for i = 1:maxlevel
        seglevel(i).level = 0;
    end
    for i = row*col+1:numel(V)
        if V(i).level >= 1
            seglevel(V(i).level).level = [seglevel(V(i).level).level; i];
            seglevel(V(i).level).size = [seglevel(V(i).level).size; V(i).size];
        end
    end
    display('Post-processing ended.');
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%
Row = col;
Col = row;
%%%%%%%%%
if showfigure
    out_image1 = zeros(Row, Col);
    if dim == 3
        out_image2 = zeros(Row, Col);
        out_image3 = zeros(Row, Col);
    end
end
segmentmapAll = cell(maxlevel, 1);
segmentmap = zeros(Row, Col);
for i = 1:maxlevel
    len = numel(seglevel(i).level);
    if showstat
        seg_length = zeros(len-1, 1);
    end
    
    for j = 2:len
        p = seglevel(i).level(j);
        if showstat
            seg_length(j-1) = V(p).size;
        end
        [R,C] = ind2sub(size(segmentmap), V(p).list);
        segmentmap(sub2ind(size(segmentmap), R, C)) = j-1;
        if showfigure
            if showrandom
                Red = rand;
                Green = rand;
                Blue = rand;
                out_image1(sub2ind(size(out_image1), R, C)) = Red;
                if dim == 3
                    out_image2(sub2ind(size(out_image2), R, C)) = Green;
                    out_image3(sub2ind(size(out_image3), R, C)) = Blue;
                end
            else
                out_image1(sub2ind(size(out_image1), R, C)) = double(V(p).colour(1));
                if dim == 3
                    out_image2(sub2ind(size(out_image2), R, C)) = double(V(p).colour(2));
                    out_image3(sub2ind(size(out_image3), R, C)) = double(V(p).colour(3));
                end
            end
        end
    end
    if showstat
        count = 1;
        freq = zeros(len,1);
        freq_tick = zeros(len,1);
        for q = min(seg_length):max(seg_length)
            freq_val = numel(seg_length(seg_length == q));
            if freq_val
                freq(count) = freq_val;
                freq_tick(count) = q;
                count = count + 1;
            end
        end
        freq = freq(1:count-1);
        freq_tick = freq_tick(1:count-1);
        len = 20;
        if count-1 < len
            len = count - 1;
        end
        
        filename = 'size_frequncy.xlsx';
        B = [freq_tick, freq];
        B = sortrows(B, -2);
        B = sortrows(B, 1);
        sheet = i;
        xlswrite(filename,B,sheet);
        
        msg = strcat('Level ', num2str(i), ' histogram: ', num2str(numel(unique(segmentmap))), ' segments');
        figure('Name', msg); bar(B(1:len,2));
        set(gca,'XLim',[B(1,1) B(len, 1)+1]);
        set(gca,'XTick',B(1:len,1));
        set(gca,'XTickLabel',B(1:len,1));
    end
    
    segmentmapAll{i} = segmentmap';
    if showfigure
        msg = strcat('Level ', num2str(i), ' segmentation: ', num2str(numel(unique(segmentmap))), ' segments');
        figure('Name', msg);
        out_image = zeros(row,col,dim);
        if dim == 3
            out_image(:,:,1) = out_image1';
            out_image(:,:,2) = out_image2';
            out_image(:,:,3) = out_image3';
        else
            out_image = out_image1';
        end
        imshow(out_image);
        %         figfile = strcat(imageName, '/', 'Level_', num2str(i), 'segment_', num2str(numel(unique(segmentmap))), '.png');
        %         imwrite(out_image, figfile);
    end
end
segmentmapAll = segmentmapAll(~cellfun(@isempty,segmentmapAll));
end