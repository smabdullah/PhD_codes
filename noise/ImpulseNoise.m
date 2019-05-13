function ImpulseNoise(varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Salt and Pepper noise detection in several different methods, including
% the proposed segmentation-based method. All methods will generate a
% Bitmap information where '1' means corrupted and '0' means non-corrupted
% pixels. Noise density from 10% to 90% is considered and for every noise
% density each methods run 10 times. We take the ceil average of ten runs
% to make a fair run. 22 grayscale images are considered of size 256 X 256

% Code By: S M Abdullah
% Email: sm.abdullah@monash.edu
% Date: 7th July 2017

% This is free to use without any guarantee it will work on your system.
% Codes are implemented and tested on Windows Platform using MATLAB
% (R2015b)

% Input: This program can be called with an individual image or a folder of
% images. The dirrum.m file can be used for a folder of images while
% noDirRun is for individual image

% Output: For every test image, it will create an excel file
% (imageName.xlsx) where you will find two tables. The left table presents
% the result of miss detection (MD) and the other table presents the result
% of false alarm (FA).
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% addpath of different noise detection algorithm
addpath('ICIP 2017 Paper code', 'BDND', 'SMFID', 'SMFID_2010', 'alphaTrimmedMedian', 'IDCIR');
% test image folder
addpath('images', 'Blackandwhite');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parameter declaration section
numofMethods = 6;                   % Number of methods
runLength = 1;                      % Each algo runs 10 times                        % Number of different noise density
initNoiseDensity = 0.1;             % Initial noise density (10%)
increment = 0.1;                    % Noise increment
finalNoiseDensity = 0.9;            % Final noise density (90%)
steps = (finalNoiseDensity - initNoiseDensity) / increment + 1;  
createImage = false;                % Boolean variable
ext = 10;                           % Image padding
totalMDSeg = zeros(steps, 1);       % Keep MD and FA result
totalFASeg = zeros(steps, 1);
totalMDBDND = zeros(steps, 1);
totalFABDND = zeros(steps, 1);
totalMDSMFID = zeros(steps, 1);
totalFASMFID = zeros(steps, 1);
totalMDSMFID_2010 = zeros(steps, 1);
totalFASMFID_2010 = zeros(steps, 1);
totalMDalpha = zeros(steps, 1);
totalFAalpha = zeros(steps, 1);
totalMDIDCIR = zeros(steps, 1);
totalFAIDCIR = zeros(steps, 1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if nargin == 2
    pathName = varargin{1};
    fileName = varargin{2};
    [Image, textName] = takeInput(createImage, pathName, fileName);
else
    [Image, textName] = takeInput(createImage);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Make large images into 256 X 256 size
% [row, col, ~] = size(Image);
% if row == 512 && col == 512
%     Image = imresize(Image, 0.20);
% end
[row, col, ch] = size(Image);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Change 0 to 1 and 255 to 254 if exist in the test image. Required for our
% proposed method.
% I = reshape(Image, row*col, ch);
% I(I == 0) = 1;
% I(I == 255) = 254;
% Image = reshape(I, row, col, ch);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Use padding to extent the size of the image
Image = padarray(Image, [ext, ext], 'symmetric');

for i = 1:runLength
    fprintf('Running the iteration %d\n', i);
    count = 1;
    for noiseLevel = initNoiseDensity:increment:finalNoiseDensity
        %         fprintf('Noise Level is %d\n', noiseLevel*100);
        %noisyImage = imnoise(Image, 'salt & pepper', noiseLevel);
        [noisyImage, noisyBitmap] = saltandPepperNoise(Image, noiseLevel, ext);
        imshow(noisyImage, []);
%         noisyImage = Image;
%         noisyBitmap = BitmapImageCreation(noisyImage(11:row+10, 11:col+10, :));
        % figure('Name', 'Noisy Image'), imshow(noisyImage, []);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Our proposed method
        tic
        [outputImage_mean, outputImage_median] = levelSegmentation(noisyImage(ext+1:row+ext, ext+1:col+ext, :));
        [BitmapImageMD,  BitmapImageFA] = BitmapImageCreation(outputImage_mean, outputImage_median);
        [MD, FA] = accuracyCalculation2(noisyBitmap, BitmapImageMD,  BitmapImageFA);
        %         fprintf('Miss detection is %d and False alarm is %d\n', MD, FA);
        totalMDSeg(count) = totalMDSeg(count) + MD;
        totalFASeg(count) = totalFASeg(count) + FA;
        toc
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % IDCIR
%         tic
        IDCIRBitmap = IDCIR(noisyImage(ext+1:row+ext, ext+1:col+ext, :));
        [MD, FA] = accuracyCalculation(noisyBitmap, IDCIRBitmap);
        totalMDIDCIR(count) = totalMDIDCIR(count) + MD;
        totalFAIDCIR(count) = totalFAIDCIR(count) + FA;
%         toc
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % BDND
%         tic
        BDNDBitmap = BDND(noisyImage);
        [MD, FA] = accuracyCalculation(noisyBitmap, BDNDBitmap);
        totalMDBDND(count) = totalMDBDND(count) + MD;
        totalFABDND(count) = totalFABDND(count) + FA;
%         toc
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % SMFID
%         tic
        SMFIDBitmap = SMFID(noisyImage(ext+1:row+ext, ext+1:col+ext, :));
        [MD, FA] = accuracyCalculation(noisyBitmap, SMFIDBitmap);
        totalMDSMFID(count) = totalMDSMFID(count) + MD;
        totalFASMFID(count) = totalFASMFID(count) + FA;
%         toc
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % SMFID_2010
%         tic
        SMFID_2010Bitmap = SMFID_2010(noisyImage);
        [MD, FA] = accuracyCalculation(noisyBitmap, SMFID_2010Bitmap);
        totalMDSMFID_2010(count) = totalMDSMFID_2010(count) + MD;
        totalFASMFID_2010(count) = totalFASMFID_2010(count) + FA;
%         toc
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % alphaTrimmedMedian
%         tic
        alphaTrimmedBitmap = alphaTrimmedMedian(noisyImage(ext:row+ext+1, ext:col+ext+1, :));
        [MD, FA] = accuracyCalculation(noisyBitmap, alphaTrimmedBitmap);
        totalMDalpha(count) = totalMDalpha(count) + MD;
        totalFAalpha(count) = totalFAalpha(count) + FA;
%         toc
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        count = count + 1;
    end
    clearvars noisyImage noisyBitmap segmentedImage segmentedBitmap BDNDBitmap SMFIDBitmap SMFID_2010Bitmap alphaTrimmedBitmap MD FA
end

finalContentMD = zeros(steps, numofMethods+1);
finalContentMD(:, 1) = initNoiseDensity*100:increment*100:finalNoiseDensity*100;
finalContentMD(:, 2) = ceil(totalMDSeg/runLength);
finalContentMD(:, 3) = ceil(totalMDBDND/runLength);
finalContentMD(:, 4) = ceil(totalMDSMFID/runLength);
finalContentMD(:, 5) = ceil(totalMDSMFID_2010/runLength);
finalContentMD(:, 6) = ceil(totalMDalpha/runLength);
finalContentMD(:, 7) = ceil(totalMDIDCIR/runLength);

table_MD = table(finalContentMD(:, 1), finalContentMD(:, 2), finalContentMD(:, 3), finalContentMD(:, 4), finalContentMD(:, 5), finalContentMD(:, 6), finalContentMD(:, 7));
table_MD.Properties.VariableNames = {'Noise_density', 'Our_method', 'BDND', 'SMFID', 'SMFID_2010', 'alpha_trimmed', 'IDCIR'};
table_MD.Properties.Description = 'Miss Detection Result';


finalContentFA = zeros(steps, numofMethods+1);
finalContentFA(:, 1) = initNoiseDensity*100:increment*100:finalNoiseDensity*100;
finalContentFA(:, 2) = ceil(totalFASeg/runLength);
finalContentFA(:, 3) = ceil(totalFABDND/runLength);
finalContentFA(:, 4) = ceil(totalFASMFID/runLength);
finalContentFA(:, 5) = ceil(totalFASMFID_2010/runLength);
finalContentFA(:, 6) = ceil(totalFAalpha/runLength);
finalContentFA(:, 7) = ceil(totalFAIDCIR/runLength);

table_FA = table(finalContentFA(:, 1), finalContentFA(:, 2), finalContentFA(:, 3), finalContentFA(:, 4), finalContentFA(:, 5), finalContentFA(:, 6), finalContentFA(:, 7));
table_FA.Properties.VariableNames = {'Noise_density', 'Our_method', 'BDND', 'SMFID', 'SMFID_2010', 'alpha_trimmed', 'IDCIR'};
table_FA.Properties.Description = 'False Alarm Result';

if initNoiseDensity > 0
    excelFileName = fullfile('results', 'temp', strcat(textName, '.xlsx'));
else
    excelFileName = fullfile('results', 'temp', strcat(textName, '_noNoise.xlsx'));
end
writetable(table_MD, excelFileName, 'Sheet', 1, 'Range', 'A3', 'WriteRowNames', true);
writetable(table_FA, excelFileName, 'Sheet', 1, 'Range', 'J3', 'WriteRowNames', true);
end