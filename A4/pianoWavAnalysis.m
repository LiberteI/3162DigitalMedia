% x: audio signal
% Fs: sampling frequency
[x, Fs] = audioread('piano.wav');

% get mono audio signal
x = x(:, 1);
% get first 5 seconds
x5 = x(1:5*Fs);
t = (0:length(x5)-1)/Fs;

% plot time domain graph in the first 5 seconds
figure;
plot(t, x5);
xlabel('Time (s)');
ylabel('Amplitude');
title('First 5 seconds of piano.wav');

% spectrogram
figure;
% The Analysis Frame
window = 4096;
% The Sliding Step
noverlap = 3072;
% The Frequency Resolution
nfft = 8192;

% S: short-time Fourier Transform
% F: Y-axis values (frequency)
% T: X-axis values (time)
[S, F, T] = spectrogram(x5, hamming(window), noverlap, nfft, Fs);
% Scaling the Volume
% abs(S) gets the magnitude, add 1e-6 to prevent undefined log0
% 20*log10 onvert magnitude to decibels
SdB = 20*log10(abs(S) + 1e-6);

% draws heat map. x-axis: t, y-axis: frequency, db: color
imagesc(T, F, SdB);
axis xy;
xlabel('Time (s)');
ylabel('Frequency (Hz)');
title('Spectrogram');
% add a color legend
colorbar;
% cut frequencies above 2000
ylim([0 2000]);
% anything quieter than -100db will be the darkest color, anythning louder
% than -20db will be the brightest color
caxis([-100 -20]);
% sets rainbow color scheme (blue=quiet, red = loud)
colormap jet;

% from 2s to 3s, every 0.2s
times = 2.0:0.2:3.0;   
% set duration to 100ms
dur = 0.1;             

for i = 1:length(times)
    start = times(i);

    % signal segment
    seg = x(round(start*Fs):round((start+dur)*Fs));

    % FFT
    N = length(seg);
    Y = fft(seg .* hamming(N));
    f = (0:N-1)*(Fs/N);

    % sketch graph
    figure;
    plot(f(1:N/2), abs(Y(1:N/2)));
    xlim([0 2000]);   
    xlabel('Frequency (Hz)');
    ylabel('Magnitude');
    title(['FFT at ', num2str(start), ' s']);
    grid on;
end