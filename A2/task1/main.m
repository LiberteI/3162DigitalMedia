
% load image
load('a2images.mat')

image = im2double(bridge);




% === threshold dithering for b = 1 ~ 8 ===

% Mean squared error(MSE)
thresholdMSE = zeros(8, 1);
% structural similarity index (SSIM)
thresholdSSIM = zeros(8, 1);

for b = 1 : 8
    currentDitheredImg = thresholding(image, b);
    
    % Calculate MSE and SSIM for the current dithered image
    thresholdMSE(b) = immse(currentDitheredImg, image);
    thresholdSSIM(b) = ssim(currentDitheredImg, image);
    
    

end
% init new canvas
figure; 
% draw curve with 1 ~ 8 as x, MSE value as y, use -o to connect points
plot(1 : 8, thresholdMSE, '-o');

xlabel('Bit Depth');
ylabel('MSE');
title('Threshold Dithering - MSE');
% enable grid
grid on;

% plot SSIM curve
figure;
plot(1:8, thresholdSSIM, '-o');
xlabel('Bit Depth');
ylabel('SSIM');
title('Threshold Dithering - SSIM');
grid on;



% === noise dithering dithering for b = 1 ~ 8 ===

noiseMSE = zeros(8,1);
noiseSSIM = zeros(8,1);

for b = 1:8
    
    % generate dithered image with noise
    currentDitheredImg = noiseDithering(image, b);
    
    % compute MSE and SSIM
    noiseMSE(b) = immse(currentDitheredImg, image);
    noiseSSIM(b) = ssim(currentDitheredImg, image);
    
end

% plot MSE curve
figure;
plot(1:8, noiseMSE, '-o');
xlabel('Bit Depth');
ylabel('MSE');
title('Noise Dithering - MSE');
grid on;

% plot SSIM curve
figure;
plot(1:8, noiseSSIM, '-o');
xlabel('Bit Depth');
ylabel('SSIM');
title('Noise Dithering SSIM ');
grid on;


% === floyd steinberg dithering for b = 1 ~ 8 ===

fsMSE = zeros(8,1);
fsSSIM = zeros(8,1);

for b = 1:8
    
    % generate floyd-steinberg dithered image
    currentDitheredImg = floydSteinbergDithering(image, b);
    
    % compute MSE and SSIM
    fsMSE(b) = immse(currentDitheredImg, image);
    fsSSIM(b) = ssim(currentDitheredImg, image);
    
end

% plot MSE curve
figure;
plot(1:8, fsMSE, '-o');
xlabel('Bit Depth');
ylabel('MSE');
title('Floyd-Steinberg - MSE');
grid on;

% plot SSIM curve
figure;
plot(1:8, fsSSIM, '-o');
xlabel('Bit Depth');
ylabel('SSIM');
title('Floyd-Steinberg - SSIM');
grid on;

% comparision MSE / SSIM
figure;
plot(1:8, thresholdSSIM, '-o'); hold on;
plot(1:8, noiseSSIM, '-o');
plot(1:8, fsSSIM, '-o');
legend('Threshold','Noise','Floyd-Steinberg');
xlabel('Bit Depth');
ylabel('SSIM');
title('SSIM Comparison');
grid on;

figure;
plot(1:8, thresholdMSE, '-o'); hold on;
plot(1:8, noiseMSE, '-o');
plot(1:8, fsMSE, '-o');
legend('Threshold','Noise','Floyd-Steinberg');
xlabel('Bit Depth');
ylabel('MSE');
title('MSE Comparison');
grid on;

% ==== showing dithered images ====

bListToShow = [1 3 5 8];

figure;
for i = 1:length(bListToShow)
    b = bListToShow(i);
    ditheredImg1 = thresholding(image, b);
    
    subplot(2,2,i);
    imshow(ditheredImg1, []);
    title(['Threshold b = ', num2str(b)]);
end

figure;
for i = 1:length(bListToShow)
    b = bListToShow(i);
    ditheredImg2 = noiseDithering(image, b);
    
    subplot(2,2,i);
    imshow(ditheredImg2, []);
    title(['Noise b = ', num2str(b)]);
end

figure;
for i = 1:length(bListToShow)
    b = bListToShow(i);
    ditheredImg3 = floydSteinbergDithering(image, b);
    
    subplot(2,2,i);
    imshow(ditheredImg3, []);
    title(['Floyd Steinberg b = ', num2str(b)]);
end
