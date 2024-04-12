% Function to load an audio file
    function loadAudio()
        global ax audioSignal sampleRate frequencies sliderBar_var frequencies_sample dataFFT audioFreq freqIntLeft freqIntRight;
        [filename, pathname] = uigetfile({'*.wav', 'Waveform Audio File Format (*.wav)'}, 'Select an audio file');

        if filename
            filePath = fullfile(pathname, filename);
            [audioSignal, sampleRate] = audioread(filePath);
            disp(['Loaded audio file: ' filename]);
            
            % Define the interval for each frequency band
            freqIntLeft = [0, 48, 96, 187, 375, 750, 1500, 3000, 6000, 12000];
            freqIntRight = [48, 96, 187, 375, 750, 1500, 3000, 6000, 12000, sampleRate];

            % Do FFT to the signal
            dataFFT = fft(audioSignal);
	        numSamples = length(audioSignal);
            lenFreq = length(frequencies);
	        frequencies_sample = (0:numSamples - 1) * (sampleRate / numSamples);
            
            % Change the value of the slider bars
            for i = 1: lenFreq
                indicesFreq = (frequencies_sample >= freqIntLeft(i)) & (frequencies_sample < freqIntRight(i));
                audioFreq(i) = 20*log10(max(abs(dataFFT(indicesFreq))));
                sliderBar_var{i}.Value = audioFreq(i);
            end
            
            % original FFT plot
            semilogx(ax, frequencies_sample, abs(dataFFT));
            xlim(ax(1), [10 sampleRate*2]);
            xlabel(ax, 'Frequency')
            ylabel(ax, 'Magnitude')
        end
    end