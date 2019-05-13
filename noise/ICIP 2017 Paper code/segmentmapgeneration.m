function segmentmap = segmentmapgeneration(c, row, col)
segmentmap = zeros(row, col);
startp = 1;
endp = col;
for i = 1:row
    segmentmap(i,:) = c(startp:endp);
    startp = endp + 1;
    endp = endp + col;
end