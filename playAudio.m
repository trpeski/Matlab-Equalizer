% Function to play audio
    function playAudio()
    global audioSignal sampleRate;
        if ~isempty(audioSignal) && sampleRate > 0
            soundsc(audioSignal(1:round(10 * sampleRate)), sampleRate);
        else
            disp('No audio to play.');
        end
    end
