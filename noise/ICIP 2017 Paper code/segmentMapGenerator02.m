function segmentmapOutputAll = segmentMapGenerator02(row, col, dim, V, showfigure, J)
A = cell2mat({V(row*col+1:end).level});
maxlevel = max(A);
seglevel = struct('level', []);
for i = 1:maxlevel
    seglevel(i).level = find(A == i) + row*col;
end
%%%%%%%%%
Row = row;
Col = col;
%%%%%%%%%
segmentmapOutputAll = cell(maxlevel-1, 2);
% Information = cell(maxlevel-1, 1);
segmentmap = zeros(Row, Col);
for i = 1:1 %maxlevel-1
%     s = struct('size', [], 'member', [], 'colour', [], 'std', []);
    out_image1_mean = zeros(Row, Col, 'uint8');
    out_image1_median = zeros(Row, Col, 'uint8');
    if dim == 3
        out_image2_mean = zeros(Row, Col, 'uint8');
        out_image3_mean = zeros(Row, Col, 'uint8');
        out_image2_median = zeros(Row, Col, 'uint8');
        out_image3_median = zeros(Row, Col, 'uint8');
    end
    
    len = numel(seglevel(i).level);
    for j = 1:len
        p = seglevel(i).level(j);
%         s(j).size = V(p).size;
%         s(j).member = V(p).list;
        [R,C] = ind2sub(size(segmentmap), V(p).list);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if showfigure
            if V(p).size == 1
                colour_mean = J(V(p).list, :);
                colour_median = J(V(p).list, :);
            else
                colour_mean = mean(J(V(p).list,:));
                colour_median = mean(J(V(p).list,:));
            end
%             s(j).colour = colour;
%             s(j).std = std(J(V(p).list,:));
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        if showfigure
            out_image1_mean(sub2ind(size(out_image1_mean), R, C)) = colour_mean(1);
            out_image1_median(sub2ind(size(out_image1_median), R, C)) = colour_median(1);
            if dim == 3
                out_image2_mean(sub2ind(size(out_image2_mean), R, C)) = colour_mean(2);
                out_image3_mean(sub2ind(size(out_image3_mean), R, C)) = colour_mean(3);
                
                out_image2_median(sub2ind(size(out_image2_median), R, C)) = colour_median(2);
                out_image3_median(sub2ind(size(out_image3_median), R, C)) = colour_median(3);
            end
        end
    end
%     Information{i} = s;
    if showfigure
        out_image = zeros(row,col,dim);
        if dim == 3
            out_image(:,:,1) = out_image1_mean;
            out_image(:,:,2) = out_image2_mean;
            out_image(:,:,3) = out_image3_mean;
        else
            out_image = out_image1_mean;
        end
        segmentmapOutputAll{i, 1} = out_image;
        
        out_image = zeros(row,col,dim);
        if dim == 3
            out_image(:,:,1) = out_image1_median;
            out_image(:,:,2) = out_image2_median;
            out_image(:,:,3) = out_image3_median;
        else
            out_image = out_image1_median;
        end
        segmentmapOutputAll{i, 2} = out_image;
    end
end
end