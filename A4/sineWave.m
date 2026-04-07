% ==== Original Sine Wave ====
% ====                    ====
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

% show first 10 ms (~4 cycles of 440 Hz)
xlim([0 0.01]);   
% keep amplitude range clean
ylim([-1.2 1.2]); 

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

% ==== Dithering ====
% ====           ====

% generate small random noise (uniform)
dither_amp = 1/31;  % roughly 1 quantization step
dither = dither_amp * (rand(size(x)) - 0.5);

% add dither before quantization
xd = x + dither;

% ==== Quantization ====
% ====              ====

% quantize the dithered signal
xqd = round(xd * 31) / 31;

% perform quantization for original signal
xq = round(x * 31) / 31;

% ==== Graphs for compressed original signal ====
% time domain
figure;
plot(t, xq);
xlabel('Time (s)');
ylabel('Amplitude');
title('6-bit Quantized Sine Wave');

% zoom into a short time interval to clearly see waveform
% show first 10 ms (~4 cycles of 440 Hz)
xlim([0 0.01]);   
% keep amplitude range clean
ylim([-1.2 1.2]); 

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

% ==== Graphs for dithered and compressed original signal ====
figure;
plot(t, xqd);
xlabel('Time (s)');
ylabel('Amplitude');
title('Dithered + 6-bit Quantized Sine Wave');

% show first 10 ms (~4 cycles of 440 Hz)
xlim([0 0.01]);   
% keep amplitude range clean
ylim([-1.2 1.2]); 

figure;
Nd = length(xqd);
Yd = fft(xqd);
f_axis_d = (0:Nd-1)*(Fs/Nd);

plot(f_axis_d(1:Nd/2), 20*log10(abs(Yd(1:Nd/2)) + 1e-6));
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
title('FFT of Dithered 6-bit Quantized Sine Wave');
xlim([0 1000]);
grid on;