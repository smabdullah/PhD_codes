function imageSequenceToVideo()
videoFile = '12_12wks.mp4';
v = VideoReader(videoFile);

for i = 1:7
    imageNames = dir(fullfile('images', strcat('level_' , num2str(i)), '*.png'));
    imageNames = {imageNames.name}';
    
    outputVideo = VideoWriter(fullfile('images', strcat('video_level_' , num2str(i))));
    outputVideo.FrameRate = v.FrameRate;
    open(outputVideo)
    
    for ii = 1:length(imageNames)
        img = imread(fullfile('images', strcat('level_' , num2str(i)), strcat(num2str(ii), '.png')));
        writeVideo(outputVideo,img)
    end
    
    close(outputVideo)
end
end