function playAudioMod()
    global audioSignalMod sampleRate;
        if ~isempty(audioSignalMod) && sampleRate > 0
            soundsc(audioSignalMod(1:round(10 * sampleRate)), sampleRate);
        else
            disp('No audio to play.');
        end
    end
