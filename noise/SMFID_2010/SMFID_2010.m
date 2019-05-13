function SMFID_2010Bitmap = SMFID_2010(Image)
% Zhang, Shuqun, and Mohammad A. Karim. "A new impulse detector for switching median filters."
% IEEE Signal processing letters 9.11 (2002): 360-363.
[row, col, ~] = size(Image);
SMFID_2010Bitmap = zeros((row-20)*(col-20), 1, 'uint8');
count = 1;

Kernel_1 = [0,0,0,0,0,0,0; 0,0,0,0,0,0,0; 0,0,0,0,0,0,0; -1,-1,-1,6,-1,-1,-1; 0,0,0,0,0,0,0; 0,0,0,0,0,0,0; 0,0,0,0,0,0,0];
Kernel_2 = [0,0,0,-1,0,0,0; 0,0,0,-1,0,0,0; 0,0,0,-1,0,0,0; 0,0,0,6,0,0,0; 0,0,0,-1,0,0,0; 0,0,0,-1,0,0,0; 0,0,0,-1,0,0,0];
Kernel_3 = [0,0,0,0,0,0,-1; 0,0,0,0,0,-1,0; 0,0,0,0,-1,0,0; 0,0,0,6,0,0,0; 0,0,-1,0,0,0,0; 0,-1,0,0,0,0,0; -1,0,0,0,0,0,0];
Kernel_4 = [-1,0,0,0,0,0,0; 0,-1,0,0,0,0,0; 0,0,-1,0,0,0,0; 0,0,0,6,0,0,0; 0,0,0,0,-1,0,0; 0,0,0,0,0,-1,0; 0,0,0,0,0,0,-1];

I1 = abs(conv2(double(Image), double(Kernel_1), 'same'));
I2 = abs(conv2(double(Image), double(Kernel_2), 'same'));
I3 = abs(conv2(double(Image), double(Kernel_3), 'same'));
I4 = abs(conv2(double(Image), double(Kernel_4), 'same'));

for j = 11:col-10
    for i = 11:row-10
        SMFID_2010Bitmap(count) = checkPixel(Image, i, j, row, col, I1, I2, I3, I4);
        count = count + 1;
    end
end
end

function flag = checkPixel(I, x, y, row, col, I1, I2, I3, I4)
V441 = zeros(441, 1, 'uint8');
count = 1;
m = 1;
T1 = 5;
T2 = 1;
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

if I(x, y) <= min(b1, m) || I(x, y) >= max(b2, 255-m)
    M = [I1(x,y), I2(x,y), I3(x,y), I4(x,y)];
    r_min = min(M);
    r_max = max(M);
    if r_min > T1 || (r_max - r_min) > T2
        flag = 1;
    else
        flag = 0;
    end
else
    flag = 0;
    return;
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