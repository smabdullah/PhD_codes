function BDNDBitmap = BDND(I)
% A Switching Median Filter With Boundary Discriminative Noise Detection for Extremely Corrupted Images
% Ng, Pei-Eng, and Kai-Kuang Ma. "A switching median filter with boundary discriminative noise detection for extremely corrupted images."
% IEEE Transactions on image processing 15.6 (2006): 1506-1516.
[row, col] = size(I);
BDNDBitmap = zeros((row-20)*(col-20), 1, 'uint8');
count = 1;
for j = 11:col-10
    for i = 11:row-10
        BDNDBitmap(count) = checkPixel(I, i, j, row, col);
        count = count + 1;
    end
end
end

function flag = checkPixel(I, x, y, row, col)
V441 = zeros(441, 1, 'uint8');
V9 = zeros(9, 1, 'uint8');
count = 1;
% run a 21 X 21 window around each pixel. Use zero-padding if required.
for i = -10:10
    for j = -10:10
        if x+i >= 1 && x+i <= row && y+j >= 1 && y+j <= col
            V441(count) = I(x+i, y+j);
            count = count + 1;
        end
    end
end
% Sort V421 in ascending order
sz = count - 1;
V441 = sort(V441(1:sz));
VD440 = zeros(sz-1, 1, 'uint8');
count = 1;
for i = 1: sz-1
    VD440(count) = V441(i+1) - V441(i);
    count = count + 1;
end
%mid = median(V441);
ind = maximum(VD440, 1, 220);
b1 = V441(ind);
ind = maximum(VD440, 221, numel(VD440));
b2 = V441(ind);

C1 = V441(V441 <= b1);
C3 = V441(V441 > b2);
C2 = setdiff(V441, C1);
C2 = setdiff(C2, C3);

if any(C2 == I(x, y))
    flag = 0;
    return;
end

count = 1;
% run a 3 X 3 window around each pixel. Use zero-padding if required.
for i = -1:1
    for j = -1:1
        if x+i >= 1 && x+i <= row && y+j >= 1 && y+j <= col
            V9(count) = I(x+i, y+j);
            count = count + 1;
        end
    end
end
% Sort V9 in ascending order
sz = count - 1;
V9 = sort(V9(1:sz));
VD8 = zeros(sz-1, 1, 'uint8');
count = 1;
for i = 1: sz-1
    VD8(count) = V9(i+1) - V9(i);
    count = count + 1;
end
%mid = median(V9);
ind = maximum(VD8, 1, 4);
b1 = V9(ind);
ind = maximum(VD8, 5, numel(VD8));
b2 = V9(ind);

C1 = V9(V9 <= b1);
C3 = V9(V9 > b2);
C2 = setdiff(V9, C1);
C2 = setdiff(C2, C3);

if any(C2 == I(x,y))
    flag = 0;
else
    flag = 1;
end
end

function ind = maximum(X, inx, iny)
ind = 1;
curMax = -1;
for i = inx:iny
    if X(i) > curMax
        curMax = X(i);
        ind = i;
    end
end
end