    
    % Initialize variables for UI figure, graphic handle, audio data, sample rate, and frequencies
    global ax MAIN audioSignal frequencies sliderBar_var audioFreq;
    
% Create the main UI figure
    MAIN = figure('Name', 'Equalizer App', 'Position', [100, 100, 1320, 480]);
    ax = axes('Position', [0.05 0.1 0.5 0.7]);
    
    warning('off','all')
    
    % Initialize audioSignal and frequencies
    audioSignal = [];

    % Define standard frequency bands (in Hz)
    frequencies = [32, 64, 125, 250, 500, 1000, 2000, 4000, 8000, 16000];
    frequencies_name = {'32', '64', '125', '250', '500', '1K', '2K', '4K', '8K', '16K'};
    sliderBar_var = cell(1, length(frequencies));
    audioFreq = zeros(1, length(frequencies));
    

    % Create a button to load an audio file
    loadButton = uicontrol('Parent', MAIN, 'Style', 'pushbutton', 'String', 'Load Audio', 'Position', [50, 400, 100, 30]);
    % loadButton = uibutton(MAIN, 'push', 'Position', [50, 400, 100, 30], 'Text', 'Load Audio');
    loadButton.Callback = @(btn, ~) loadAudio();

    % Create a button to play the original audio
    playOriginalButton = uicontrol('Parent', MAIN, 'Style', 'pushbutton', 'String', 'Play Original', 'Position', [160, 400, 100, 30]);
    % playOriginalButton = uibutton(MAIN, 'push', 'Position', [160, 400, 100, 30], 'Text', 'Play Original');
    playOriginalButton.Callback = @(btn, ~) playAudio();

    % Create a button to apply equalization
    applyButton = uicontrol('Parent', MAIN, 'Style', 'pushbutton', 'String', 'Apply Equalization', 'Position', [270, 400, 100, 30]);
    % applyButton = uibutton(MAIN, 'push', 'Position', [270, 400, 100, 30], 'Text', 'Apply Equalization');
    applyButton.Callback = @(btn, ~) applyEqualization();

    % Create a button to play the modified audio
    playModifiedButton = uicontrol('Parent', MAIN, 'Style', 'pushbutton', 'String', 'Play Modified', 'Position', [380, 400, 100, 30]);
    % playModifiedButton = uibutton(MAIN, 'push', 'Position', [380, 400, 100, 30], 'Text', 'Play Modified');
    playModifiedButton.Callback = @(btn, ~) playAudioMod();

    % Create a button to save the modified audio
    saveButton = uicontrol('Parent', MAIN, 'Style', 'pushbutton', 'String', 'Save Audio', 'Position', [490, 400, 100, 30]);
    % saveButton = uibutton(MAIN, 'push', 'Position', [490, 400, 100, 30], 'Text', 'Save Audio');
    saveButton.Callback = @(btn, ~) saveAudio();

    % Create a button to reset 
    resetButton = uicontrol('Parent', MAIN, 'Style', 'pushbutton', 'String', 'Reset', 'Position', [600, 400, 100, 30]);
    % resetButton = uibutton(MAIN, 'push', 'Position', [600, 400, 100, 30], 'Text', 'Reset');
    resetButton.Callback = @(btn, ~) resetAudio();

    % Create frequencies slider bar
    maxDb = 120; % Initial maximum Db of the slider bars
    
    % Set the position and objects of the slider bars initially
    for i = 1:length(frequencies)
        sliderBar_var{i} = uicontrol('Parent', MAIN, 'Style','slider','Position', [710 + i*50, 50, 30, 400],...
            'Max', maxDb, 'Min', -60);
        
        % sliderBar_var{i} = uislider(MAIN, 'Position', [710 + i*50, 50, 400, 30], 'Orientation', 'vertical', ...
        %    'Limits', [-60 maxDb], 'MajorTicks', -maxDb:20:maxDb);
        % uilabel(MAIN, 'Position', [700 + i*50, 20, 50, 30], 'Text', frequencies_name{i}, 'FontSize', 16);
    end
    
    % add labels
    Db = -60:20:maxDb;
    h  = 370/(length(Db)-1);
    for i = 1:length(Db)
        uicontrol('Parent', MAIN, 'FontSize', 14, 'Style', 'text', 'String', Db(i), ...
                  'Position', [740 + length(frequencies)*50, 40+h*(i-1) 40 40]);
    end
    uicontrol('Parent', MAIN, 'FontSize', 14, 'Style', 'text', 'String', '(Db)', ...
                  'Position', [780 + length(frequencies)*50, 220 40 40]);
    for i = 1:length(frequencies)
        uicontrol('Parent', MAIN, 'FontSize', 14, 'Style', 'text', 'String', frequencies_name(i), ...
                  'Position', [705 + i*50, 0 40 40]);
    end
    uicontrol('Parent', MAIN, 'FontSize', 14, 'Style', 'text', 'String', '(Hz)', ...
                  'Position', [740 + length(frequencies)*50, -5 40 40]);
    %uilabel(MAIN, 'Position', [750 + i*50, 225, 50, 50], 'Text', 'Db', 'FontSize', 20);
