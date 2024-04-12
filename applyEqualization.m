% Function to apply equalization
    function applyEqualization()
        global ax audioSignal frequencies_sample audioSignalMod audioFreq sliderBar_var frequencies sampleRate freqIntLeft freqIntRight;
        if isempty(audioSignal) || isempty(frequencies)
            disp('Please load an audio file and define frequencies first.');
            return;
        end
        dataFFT = fft(audioSignal);
        numSamples = length(audioSignal);
        frequencies_sample = (0:numSamples - 1) * (sampleRate / numSamples);

        % Initialize boost filter
        boostFilter = ones(size(dataFFT));


        % Construct boost filter on each frequency intervals
        for i = 1:length(frequencies)
            dbEq = get(sliderBar_var{i}, 'Value'); % get value from the slider bars
            dbOriginal = audioFreq(i);
            gain = 10^((dbEq-dbOriginal)/20); % get the boost factor
            indicesFreq = (frequencies_sample >= freqIntLeft(i)) & (frequencies_sample < freqIntRight(i));
            boostFilter(indicesFreq) = gain;
        end
	    
        
        % Apply the boost filter to the FFT signal
        dataFFT_mod = dataFFT .* boostFilter;
        
        % FFT plot after apply equalization
        semilogx(ax, frequencies_sample, abs(dataFFT_mod));
        xlim(ax(1), [10 sampleRate*2]);
        xlabel(ax, 'Frequency')
        ylabel(ax, 'Magnitude')
        
	    % Inverse FFT to get the modified audio and keep only the real part
	    audioSignalMod = real(ifft(dataFFT_mod));
    end
