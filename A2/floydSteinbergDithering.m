function ditheredImage = floydSteinbergDithering(image, b)
    % define error spread ratios in 4 directions
    rightRatio = 7 / 16;
    buttomRightRatio = 1 / 16;
    buttomRatio = 5 / 16;
    buttomLeftRatio = 3 / 16;

    % get all pixels in image
    [height, width] = size(image);

    for y = 1 : height
        for x = 1 : width
            fprintf("Pixel at (%d, %d) = %.3f\n", y, x, image(y,x));
        end
    end
    

end