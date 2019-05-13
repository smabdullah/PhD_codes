function [noisyImage, noisyBitmap] = saltandPepperNoise(Image, noiseDensity, ext)
rng('default');
rng(1);
[row, col, ch] = size(Image);
p3= noiseDensity;
e = zeros((row)*(col), 1, 'uint8');
if ch == 3
    c = rgb2gray(Image);
else
    c = Image;
end
ch = 1;
b = reshape(c, row*col, ch);
x = rand(numel(c), 1);
p4 = p3*0.3;
d = find(x < p4/2); % 30%
b(d,:) = 0; % Minimum value
e(d) = 1;
p5 = p3*0.7;
d = find(x >= p5/2 & x < p3);
b(d,:) = 255; % Maximum (saturated) value
e(d) = 1;
noisyImage = double(reshape(b, row, col, ch));
e = reshape(e, row, col, ch);
e = e(ext+1:row-ext, ext+1:col-ext, :);
noisyBitmap = reshape(e, (row-2*ext)*(col-2*ext), 1);
end