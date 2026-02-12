% load audio piano.wav, using int16
% x, fs
[signal, sampleRate] = audioread('piano.wav', 'native');




% ==== predictor l = 1 ====
coefficients_l1 = [1];

% get prediction error
predictionError_l1 = predict_signal(signal, coefficients_l1);

outputPath = '/Users/liberte/Desktop/3162/A2/task2/error_l1.wav';

audiowrite(outputPath, int16(predictionError_l1), sampleRate);

[signal_l1, sampleRate_l1] = audioread('error_l1.wav', 'native');




% ---- sanity check ----
% max(abs(int32(signal)))
% max(abs(int32(predictionError_l1)))

% print the first 20 values
% disp([(1:20)', signal(1:20)])
% disp([(1:20)', signal_l1(1:20)])

% show sinusoids
% showSinusoid(signal, sampleRate, 'piano');
% showSinusoid(signal_l1, sampleRate_l1, 'error_l1');