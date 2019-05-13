function [MD, FA] = accuracyCalculation2(noisyBitmap, BitmapImageMD,  BitmapImageFA)
MD = 0; % Miss-detection
FA = 0; % False-alarm
for i = 1:numel(noisyBitmap)
    if noisyBitmap(i) == 1 && BitmapImageMD(i) == 0
        MD = MD + 1;
    end
    
    if noisyBitmap(i) == 0 && BitmapImageFA(i) == 1
        FA = FA + 1;
    end
end

    

end