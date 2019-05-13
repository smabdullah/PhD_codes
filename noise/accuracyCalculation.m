function [MD, FA] = accuracyCalculation(noisyBitmap, segmentedBitmap)
MD = 0; % Miss-detection
FA = 0; % False-alarm
for i = 1:numel(noisyBitmap)
    if noisyBitmap(i) == 1 && segmentedBitmap(i) == 0
        MD = MD + 1;
    end
    if noisyBitmap(i) == 0 && segmentedBitmap(i) == 1
        FA = FA + 1;
    end
end
end