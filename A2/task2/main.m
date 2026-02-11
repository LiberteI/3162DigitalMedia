% load audio piano.wav, using int16
[signal, frequency] = audioread('piano.wav', 'native');

disp(class(x));
disp(frequency);