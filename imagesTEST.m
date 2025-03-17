subid = 1256;  % Participant ID
num_participants = 30;  % Only one participant now

responses = zeros(num_participants, 30);  % Create a column vector to store responses

% Setup for Psychtoolbox
PsychDefaultSetup(2);
Screen('Preference', 'SkipSyncTests', 1);  % Skip sync tests for development (remove in production)
[window1, rect] = Screen('OpenWindow', 0, [0 0 0]);  % Create a black window on screen 0

textColor = [255 255 255];  % White text
KbName('UnifyKeyNames');  % Standardize key names

imageFolder = 'Images'; % folder path
imageFiles = dir(fullfile(imageFolder, '*.png')); % Get all png files in the folder

for i = 1:num_participants
   ratingText = 'Press keys 1-10 for your rating (1 = not at all, 10 = immediate threat)';
    imgPath = fullfile(imageFolder, imageFiles(i).name);
    img = imread(imgPath);
    imshow(img);
    imgTexture = Screen('MakeTexture', window, img);
    
    % Draw the image in the center of the screen
    Screen('DrawTexture', window, imgTexture, [], []);
    
    % Display the prompt below the image
    DrawFormattedText(window, ...
        'Rate the image from 1 to 10\n(1 = Do Not Care, 10 = Care A Lot)', ...
        'center', screenY * 0.85, [0 0 0]);
    
    % Flip the screen to show the image and text
    Screen('Flip', window);
   rating = 0;
   while rating < 1 || rating > 10
        [keyIsDown, ~, keyCode] = KbCheck;
        
        if keyIsDown
            keyPressed = find(keyCode);
            
            % Check for the ESCAPE key to quit the experiment
            if keyCode(KbName('ESCAPE')) == 1
                % Close the screen and exit the function
                Screen('CloseAll');
                sca;  % Clear the screen and all Psychtoolbox windows
                disp('ESCAPE key pressed. Exiting the experiment.');  % Print to console
                return;  % Exit the function (ends the experiment)
            end

            if ~isempty(keyPressed)
                key = KbName(keyPressed(1));  % Get the key name (e.g., '1!', '2@', ...)
                
                % Extract the numeric part of the key press using regex
                num_str = regexp(key, '\d', 'match');  % Find the digit(s) in the key name
                if ~isempty(num_str)
                    rating = str2double(num_str{1});  % Convert the first match to a number
                    if rating >= 1 && rating <= 10
                        break;  % Valid rating, exit loop
                    end
                end
            end
        end
    end

    responses(i) = rating;  % Store the valid rating
    
    % Display a confirmation message for the response
    DrawFormattedText(window1, ['You rated: ' num2str(rating)], 'center', rect(4)/2 + 100, textColor);
    Screen('Flip', window1);  % Update the screen
    WaitSecs(1);  % Wait for 1 second before moving to the next participant
end

% Save the responses 
filename = ['imageresponses/response' num2str(subid)];
save(filename, 'responses');

% Close the screen
Screen('CloseAll');
