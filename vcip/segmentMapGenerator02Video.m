function segmentmapAll = segmentMapGenerator02Video(row,col,dim,V,E,showfigure,showrandom,postprocess,J,pixelLevel,framenumber)
A = cell2mat({V(row*col+1:end).level});
maxlevel = max(A);
if ~postprocess
    seglevel = struct('level', []);
    for i = 1:maxlevel
        seglevel(i).level = find(A == i) + row*col;
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if postprocess
%     disp('Post-processing started.');
    V = postprocessing(V, E, maxlevel, pixelLevel);
    A = cell2mat({V(row*col+1:end).level});
    seglevel = struct('level', []);
    for i = 1:maxlevel
        seglevel(i).level = find(A == i) + row*col;
    end
%     disp('Post-processing ended.');
end

Row = row;
Col = col;
% xpcount = 1;
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
for i = 1:maxlevel-1
    len = numel(seglevel(i).level);
    for j = 1:len
        p = seglevel(i).level(j);
        [R,C] = ind2sub(size(segmentmap), V(p).list);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if showfigure && ~showrandom
            if V(p).size == 1
                colour = J(V(p).list, :);
            else
                colour = mean(J(V(p).list,:));
            end
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        segmentmap(sub2ind(size(segmentmap), R, C)) = j;
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
                out_image1(sub2ind(size(out_image1), R, C)) = colour(1);
                if dim == 3
                    out_image2(sub2ind(size(out_image2), R, C)) = colour(2);
                    out_image3(sub2ind(size(out_image3), R, C)) = colour(3);
                end
            end
        end
    end  
    segmentmapAll{i} = segmentmap;
    if showfigure
        %msg = strcat('Level ', num2str(i), ' segmentation: ', num2str(numel(unique(segmentmap))), ' segments');
        %figure('Name', msg);
        out_image = zeros(row,col,dim);
        if dim == 3
            out_image(:,:,1) = out_image1;
            out_image(:,:,2) = out_image2;
            out_image(:,:,3) = out_image3;
        else
            out_image = out_image1;
        end
        
        
           imagename = fullfile('images', strcat('level_', num2str(i)), strcat(num2str(framenumber), '.png')); 
           imwrite(out_image, imagename);
        
        %imshow(out_image);
        %imwrite(out_image, strcat(num2str(i), '_random.jpg'));
        %PSNR = psnr(Inew, out_image);
        %fprintf('PSNR for level %d is %2.2f\n',i,PSNR);
    end
end
segmentmapAll = segmentmapAll(~cellfun(@isempty,segmentmapAll));
% A = cell2mat({seglevel(1:maxlevel).avgcsp});
% [val, loc] = max(A);
% fprintf('Segment level [%d] is the optimal segmentation with CSP index of %.4f\n', loc, val);
end