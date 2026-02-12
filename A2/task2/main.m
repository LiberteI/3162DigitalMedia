% load audio piano.wav, using int16
% signals fs
[signal, sampleRate] = audioread('piano.wav', 'native');

showSinusoid(signal, sampleRate, 'piano');

% predictor l = 1
coefficients_l1 = [1];
% get prediction error
predictionError_l1 = predict_signal(signal, coefficients_l1);

outputPath = '/Users/liberte/Desktop/3162/A2/task2/error_l1.wav';

audiowrite(outputPath, int16(predictionError_l1), sampleRate);

% [signal_l1, sampleRate_l1] = audioread('error_l1.wav', 'native');
showSinusoid(signal_l1, sampleRate_l1, 'error_l1');

max(abs(int32(signal)))
max(abs(int32(predictionError_l1)))
