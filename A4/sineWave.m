% sampling rate
Fs = 44100;     
% sample frequency (A4)
f = 440;           
% a second
t = 0:1/Fs:1;
% x(t) = sin(2πft)
x = sin(2*pi*f*t);

plot(t, x);
xlabel('Time (s)');
ylabel('Amplitude');
title('Pure Sine Wave (440 Hz)');
% play sound
sound(x, Fs);