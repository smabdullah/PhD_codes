function Ismooth = edgesmooth(I, row, col, connectivity)
if connectivity == 8
    dx = [-1, -1, -1, 0, 1, 1, 1, 0];
    dy = [-1, 0, 1, 1, 1, 0, -1, -1];
elseif connectivity == 4
    dx = [0, -1, 1, 0];
    dy = [-1, 0, 0, 1];
end
Ismooth = zeros(size(I));
for i = 1:row
    for j = 1:col
        count = 1;
        A = double(I(i,j,:));
        for k = 1: connectivity
            inx = i + dx(k);
            iny = j + dy(k);
            if (inx >=1 && inx <= row) && (iny >= 1 && iny <= col)
                A = A + double(I(inx,iny,:));
                count = count + 1;
            end
        end
        Ismooth(i,j,:) = A/count;
    end
end
end