function Inew = addNoise(I, noisetype, var)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % Add noise to the image (for experimental purpose)
if strcmp(noisetype, 'gaussian')
    Inew = imnoise(I,'gaussian',0,var); % addative noise
end
if strcmp(noisetype, 'salt & pepper')
    Inew = imnoise(I,'salt & pepper',var); % on-off noise
end
if strcmp(noisetype, 'speckle')
    Inew = imnoise(I,'speckle', var); % multiplicative noise
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end