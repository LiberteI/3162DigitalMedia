
% apply thresholding to image with a bit depth of b
function ditheredImage = thresholding(image, b)
    % create 2^b levels
    levelCount = 2^b;
    
    % create 2^b - 1 intervals
    interval = levelCount - 1;

    % scale the level up so that we can perform round
    scaledValues = image * interval;

    % round image
    roundedImage = round(scaledValues);

    % map rounded values back to the original image range [0. 1]
    ditheredImage = roundedImage / interval;
end