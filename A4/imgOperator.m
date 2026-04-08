img = imread('cameraman.jpg');
img = im2double(img);

% frequency domain
IMG = fft2(img);

% define a function to generate filters
% blurred image=h∗image
h = fspecial('disk', 4);
% frequency domain
H = psf2otf(h, size(img));

% blurred image
img_blurred = real(ifft2(H .* IMG));

% add Gaussian noise
noise = 0.01 * randn(size(img_blurred));
img_degraded = img_blurred + noise;


% ---- Original Image ----
figure;
imshow(img);
title('Original Image');
% ---- Blur ----
figure;
imshow(img_blurred, []);
title('Blurred Image');

% ---- Add Noise ----
figure;
imshow(img_degraded, []);
title('Blurred + Noisy Image');

% Wiener filter: G(u,v) = H* / (|H|^2 + Su / Sx)
% F(ixed img) = G * Y(degraded img) 
% H: blur frequency domain
% H*: conjured H
% |H|: amplitude
% Su: noise power spectrum
% Sx: image power spectrum

% degraded image's Frequency Domain
Y = fft2(img_degraded);

% H*
H_conj = conj(H);

% H^2 
H_abs = abs(H).^2;

% noise power. noise = 0.01 * randn
Sn = 0.01^2;