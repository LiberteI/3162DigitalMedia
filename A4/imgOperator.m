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
% Su / Sx: noise-to-signal ratio
% F(ixed img) = G * Y(degraded img) 
% H: blur frequency domain
% H*: conjured H
% |H|: amplitude
% Su: noise power spectrum
% Sx: image power spectrum

% degraded image's Frequency Domain
IMG_degraded = fft2(img_degraded);

% H*
H_conj = conj(H);

% |H|^2 
H_abs2 = abs(H).^2;

% Cameraman image power spectrum
Sx1 = abs(fft2(img)).^2;
% Wiener filter
epsilon = 1e-8;

% ---- Sweep Sn values (individual figures) ----
Sn_values = 0.1:1:10.1;
Sn = 1;
% Sn = 6.1 (best performance)
% generating images for cameraman
for i = 1:length(Sn_values)
    % noise power.
    Sn = Sn_values(i);
    
    % Wiener filter
    G = H_conj ./ (H_abs2 + Sn ./ (Sx1 + epsilon));
    
    % restore
    F_hat = G .* IMG_degraded;
    img_restored = real(ifft2(F_hat));
    
    % clip for display
    img_display = min(max(img_restored, 0), 1);
    
    % compute SSE: the difference between restored and the real img
    SSE = sum((img - img_restored).^2, 'all');
    
    % show each in its own figure
    figure;
    imshow(img_display);
    title(['Sn = ', num2str(Sn), ', SSE = ', num2str(SSE, '%.2e')]);
    
end

img2 = imread('building.jpg');
img2 = im2double(img2);
Sx2 = abs(fft2(img2)).^2;


% ---- Building spectrum restoration (Sn sweep) ----

% Sn = 5.1 (best performance)
Sn_values = 0.1:1:10.1;

for i = 1:length(Sn_values)
    
    Sn = Sn_values(i);
    
    % Wiener filter (using building spectrum)
    G2 = H_conj ./ (H_abs2 + Sn ./ (Sx2 + epsilon));
    
    % restore (still using cameraman degraded image)
    F_hat2 = G2 .* IMG_degraded;
    img_restored2 = real(ifft2(F_hat2));
    
    % clip for display
    img_display2 = min(max(img_restored2, 0), 1);
    
    % compute SSE
    SSE2 = sum((img - img_restored2).^2, 'all');
    
    % show result
    figure;
    imshow(img_display2);
    title(['Building Spectrum, Sn = ', num2str(Sn), ...
           ', SSE = ', num2str(SSE2, '%.2e')]);
    
end