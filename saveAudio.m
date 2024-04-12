% Function to save the modified audio
    function saveAudio()
        global audioSignalMod sampleRate;
        if ~isempty(audioSignalMod) && sampleRate > 0
            [filename, pathname] = uiputfile({'*.wav', 'Waveform Audio File Format (*.wav)'}, 'Save processed audio as');

            if filename
                filePath = fullfile(pathname, filename);
                audiowrite(filePath, audioSignalMod, sampleRate);
                disp(['Saved processed audio as: ' filename]);
            end
        else
            disp('No processed audio to save. Please load an audio file and apply equalization first.');
        end
    end