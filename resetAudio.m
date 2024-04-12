% Function to reset frequencies to the original audio
    function resetAudio()
        global sliderBar_var audioFreq dataFFT ax frequencies_sample sampleRate
        for i = 1:length(sliderBar_var)
            sliderBar_var{i}.Value = audioFreq(i);
        end
        
        % FFT plot
        semilogx(ax, frequencies_sample, abs(dataFFT));
        xlim(ax(1), [10 sampleRate*2]);
        xlabel(ax, 'Frequency')
        ylabel(ax, 'Magnitude')
    end