function showSinusoid(audio, frequency)
    
    % convert audio to double
    audio = double(audio);

    % total number of samples
    numSamples = length(audio);

    % time vector from 0 to num - 1
    t = (0 : numSamples - 1) / frequency;

    % plot amplitude vs time
    plot(t, audio);

    xlabel('Time (s)');
    ylabel('Amplitude');
    title(['Audio Signal at ', num2str(frequency), ' Hz']);
   
end