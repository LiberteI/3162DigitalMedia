function originalSignal = reconstruct(predictionError, coefficients)
    % signal(n) = predictionError(n) + currentPrediction

    % convert to int 32 to prevent overflow
    predictionError = int32(predictionError); 

    % size of signal
    signalSize = length(predictionError);

    % number of samples used in predictor
    l = length(coefficients);

    % initialise array
    reconstructedSignals = zeros(size(predictionError), 'int32');

    % store the first samples
    reconstructedSignals(1 : l) = predictionError(1 : l);

    % compute reconstruction
    for n = l + 1: signalSize

        currentPrediction = 0;
        for k = 1 : l
            % record reconstructed signal
            currentPrediction = currentPrediction + reconstructedSignals(n - k) * coefficients(k);
        end

        % record reconstruction 
        reconstructedSignals(n) = predictionError(n) + currentPrediction;
    end

    originalSignal = reconstructedSignals;
end