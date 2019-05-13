function Inew = imageFilter(I, dim, filtertype)
if strcmp(filtertype, 'guassain')
    Inew = imgaussfilt(I, 0.2);
else
    [row, col, ~] = size(I);
    Inew = zeros(row, col, dim);
    if dim == 3
        Inew(:,:,1) = medfilt2(I(:,:,1));
        Inew(:,:,2) = medfilt2(I(:,:,2));
        Inew(:,:,3) = medfilt2(I(:,:,3));
    elseif dim == 1
        Inew = medfilt2(I);
    end
end
end