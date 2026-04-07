% sampling rate
Fs = 44100;     
% sample frequency (A4)
f = 440;           
% 2 second
t = 0:1/Fs:2;
% x(t) = sin(2πft)
x = sin(2*pi*f*t);

% time domain
plot(t, x);
xlabel('Time (s)');
ylabel('Amplitude');
title('Pure Sine Wave (440 Hz)');
% play sound
% sound(x, Fs);

% frequency domain graph
figure;
N = length(x);
Y = fft(x);
f_axis = (0:N-1)*(Fs/N);

plot(f_axis(1:N/2), abs(Y(1:N/2)));
xlim([0 1000]);
title('FFT of Pure Sine Wave');

% perform quantization
xq = round(x * 31) / 31;

% time domain
figure;
plot(t, xq);
xlabel('Time (s)');
ylabel('Amplitude');
title('6-bit Quantized Sine Wave');

% frequency domain
figure;
Nq = length(xq);
Yq = fft(xq);
f_axis_q = (0:Nq-1)*(Fs/Nq);

plot(f_axis_q(1:Nq/2), 20*log10(abs(Yq(1:Nq/2)) + 1e-6));
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
title('FFT of 6-bit Quantized Sine Wave');
xlim([0 1000]);
grid on;
sound(xq, Fs);