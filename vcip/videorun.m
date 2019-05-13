function videorun()
count = 1;
folder_name = 'test_video';
v = VideoReader('12_12wks.mp4');

while v.CurrentTime <= 10
    image = readFrame(v);
    imwrite(image, 'test.png');
    fprintf('Processing video frame: %d\n',count);
    levelSegmentationVideo(pwd, 'test.png', folder_name, count);
    count = count + 1;
end
end