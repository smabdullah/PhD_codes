function generatecontrastmap(segmentmapAll,seglevel)
mode = 'gray'; %'on-off' 'gray'
% threshold = 4;
for ii = 1:numel(segmentmapAll)
    segment = segmentmapAll{ii};
    adaptive_threshold = median(seglevel(ii).size);
    displaycontrast(segment, mode, adaptive_threshold, ii);
end
end

function displaycontrast(segment, mode, threshold, level)
Imap = zeros(size(segment));
element = max(max(segment));
for ii = 1:element
    [row, col] = find(segment == ii);
    if strcmp(mode, 'gray')
        colour = mod(numel(row),256);
        Imap(sub2ind(size(Imap), row, col)) = colour/255;
    else
        if numel(row) < threshold
            Imap(sub2ind(size(Imap), row, col)) = 1;
        end
    end
end
msg = strcat('Contrast map on level# ', num2str(level));
figure('Name', msg), imshow(Imap, [0,1]);
filterredImage(Imap);
end