% load audio piano.wav, using int16
% signals fs
[signal, sampleRate] = audioread('piano.wav', 'native');

% disp(class(signal));
% disp(frequency);

showSinusoid(signal, sampleRate);

% predictor l = 1
coefficients_l1 = [1];
% get prediction error
predictionError_l1 = predict_signal(signal, coefficients_l1);

audiowrite('error_l1.wav', int16(predictionError_l1), sampleRate);