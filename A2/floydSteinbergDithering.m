function ditheredImage = floydSteinbergDithering(image, b)
    % define error spread ratios in 4 directions
    rightRatio = 7 / 16;
    bottomRightRatio = 1 / 16;
    bottomRatio = 5 / 16;
    bottomLeftRatio = 3 / 16;
    

    % create 2^b levels
    levelCount = 2^b;

    % create 2^b - 1 intervals
    intervalCount = levelCount - 1;

    % get all pixels in image
    [height, width] = size(image);

    for y = 1 : height
        for x = 1 : width
            % fprintf("Pixel at (%d, %d) = %.3f\n", y, x, image(y,x));

            originalPixelValue = image(y, x);
            
            % scale up, round then recover
            roundedPixelValue = round(originalPixelValue * intervalCount) / intervalCount;
           
            error = originalPixelValue - roundedPixelValue;

            image(y, x) = roundedPixelValue;

            % distribute error to its neighbours
            % right
            if x + 1 <= width
                image(y, x+1) = image(y, x+1) + error * rightRatio;
            end

            % bottom-left
            if y + 1 <= height && x - 1 >= 1
                image(y+1, x-1) = image(y+1, x-1) + error * bottomLeftRatio;
            end

            % bottom
            if y + 1 <= height
                image(y+1, x) = image(y+1, x) + error * bottomRatio;
            end

            % bottom-right
            if y + 1 <= height && x + 1 <= width
                image(y+1, x+1) = image(y+1, x+1) + error * bottomRightRatio;
            end
            
        end
    end
    
    % clip the image then return dithered image
    ditheredImage = min(max(image, 0), 1); 
    
end