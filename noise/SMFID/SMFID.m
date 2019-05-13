function SMFIDBitmap = SMFID(Image)
% Zhang, Shuqun, and Mohammad A. Karim. "A new impulse detector for switching median filters." 
% IEEE Signal processing letters 9.11 (2002): 360-363.
[row, col, ~] = size(Image);
SMFIDBitmap = zeros(row*col, 1, 'uint8');
count = 1;

Kernel_1 = [0,0,0,0,0;0,0,0,0,0;-1,-1,4,-1,-1;0,0,0,0,0;0,0,0,0,0];
Kernel_2 = [0,0,-1,0,0;0,0,-1,0,0;0,0,4,0,0;0,0,-1,0,0;0,0,-1,0,0];
Kernel_3 = [-1,0,0,0,0;0,-1,0,0,0;0,0,4,0,0;0,0,0,-1,0;0,0,0,0,-1];
Kernel_4 = [0,0,0,0,-1;0,0,0,-1,0;0,0,4,0,0;0,-1,0,0,0;-1,0,0,0,0];

T = 116;

% I1 = imfilter(Image, Kernel_1, 'conv');
% I2 = imfilter(Image, Kernel_2, 'conv');
% I3 = imfilter(Image, Kernel_3, 'conv');
% I4 = imfilter(Image, Kernel_4, 'conv');

I1 = abs(conv2(double(Image), double(Kernel_1), 'same'));
I2 = abs(conv2(double(Image), double(Kernel_2), 'same'));
I3 = abs(conv2(double(Image), double(Kernel_3), 'same'));
I4 = abs(conv2(double(Image), double(Kernel_4), 'same'));

for j = 1:col
   for i = 1:row
       M = [I1(i,j), I2(i,j), I3(i,j), I4(i,j)];
       r = min(M);
       if r > T
           SMFIDBitmap(count) = 1;
       end
       count = count + 1;
   end
end
end