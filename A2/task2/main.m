
% ==== load audio piano.wav, using int16 ====
% x, fs
[signal, sampleRate] = audioread('piano.wav', 'native');


% ==== predictor l = 1 ====
coefficients_l1 = [1];

% get prediction error
predictionError_l1 = predict_signal(signal, coefficients_l1);

% generate error file
audiowrite('error_l1.wav', int16(predictionError_l1), sampleRate);

% read newly generated error file
[signal_l1, sampleRate_l1] = audioread('error_l1.wav', 'native');

% get reconstruction signals
reconstructedSignal_l1 = reconstruct(predictionError_l1, coefficients_l1);

% check equal: expected: reconstructedSignal = signal
maxDifference = max(abs(int32(signal) - reconstructedSignal_l1));
disp(maxDifference);


% ==== predictor l = 2 ====
coefficients_l2 = [2, -1];

% get prediction error
predictionError_l2 = predict_signal(signal, coefficients_l2);
% generate error file for l = 2
audiowrite('error_l2.wav', int16(predictionError_l2), sampleRate);

% read newly generated error file for l = 2
[signal_l2, sampleRate_l2] = audioread('error_l2.wav', 'native');

% get reconstruction signals for l = 2
reconstructedSignal_l2 = reconstruct(predictionError_l2, coefficients_l2);

% check equal: expected: reconstructedSignal = signal for l = 2
maxDifference_l2 = max(abs(int32(signal) - reconstructedSignal_l2));
disp(maxDifference_l2);

% ==== predictor l = 3 ====
coefficients_l3 = [3 -3 1];

% get prediction error
predictionError_l3 = predict_signal(signal, coefficients_l3);

% write error file
audiowrite('error_l3.wav', int16(predictionError_l3), sampleRate);

% read error file back
[signal_l3, sampleRate_l3] = audioread('error_l3.wav', 'native');

% reconstruct from in-memory error
reconstructedSignal_l3 = reconstruct(predictionError_l3, coefficients_l3);

% check equality
maxDifference_l3 = max(abs(int32(signal) - reconstructedSignal_l3));
disp(maxDifference_l3);



% ---- sanity check ---- (used for debugging)
% max(abs(int32(signal)))
% max(abs(int32(predictionError_l1)))

% print the first 20 values
% disp([(1:20)', signal(1:20)])
% disp([(1:20)', signal_l1(1:20)])

% show sinusoids
% showSinusoid(signal, sampleRate, 'piano');
% showSinusoid(signal_l1, sampleRate_l1, 'error_l1');