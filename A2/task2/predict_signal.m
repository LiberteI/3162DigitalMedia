function predictionError = predict_signal(signal, coefficient)
    
    % total number of samples
    numSamples = length(signal);

    % number of samples used in predictor
    l = length(coefficient);
    
    % initialise array
    predictionError = zeros(size(signal), 'int16');
    
    % store first l signal sample(s)
    predictionError(1 : l) = signal(1 : l);

    % compute predictions
    for n = l+1 : numSamples
        currentPrediction = 0;
        
        % prediction = coefficient[1] * signal[n - 1] + coefficient[2] * signal[n - 2] + ... + coefficient[l] * signal[n - l]
        for k = 1 : l
            currentPrediction = currentPrediction + coefficient(k) * signal(n - k);
        end

        % record prediction error
        predictionError(n) = signal(n) - currentPrediction;
    end
end