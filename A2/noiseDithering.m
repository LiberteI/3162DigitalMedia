% apply noise dithering to image
function ditheredImage = noiseDithering(image, b)
    % create 2^b levels
    levelCount = 2^b;
    
    % create 2^b - 1 intervals
    intervalCount = levelCount - 1;

    % compute length per interval
    intervalLength = 1 / intervalCount;

    % generate noise [-intervalLength, intervalLength)
    noise = (rand(size(image)) - 0.5) * intervalLength * 2;
    
    % add noise to the image
    noisyImage = image + noise;

    % ensure values are within the range [0, 1]
    clippedNoisyImage = min(max(noisyImage, 0), 1);

    % scale the level up so that we can perform round
    scaledValues = clippedNoisyImage * intervalCount;

    % round image
    roundedImage = round(scaledValues);

    % map rounded values back to the original image range [0. 1]
    ditheredImage = roundedImage / intervalCount;


end