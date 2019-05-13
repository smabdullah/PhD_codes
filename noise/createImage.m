function Image = createImage()
% Constant white background of size 256 X 256
Image = ones(256,256, 'uint8');
Image = Image * 128;

% Black square in the white background
% Image = ones(256, 256);
% Image = Image * 255;
% Image(50:100, 50:100) = 0;
end