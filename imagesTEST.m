subid = 0011;  % Participant IDnum_participants = 30;  % Only one participant now, num participant is actually the number of pictures
num_participants = 30;
responses = zeros(num_participants,1);  % Create a column vector to store responses

% Setup for Psychtoolbox
PsychDefaultSetup(2);
Screen('Preference', 'SkipSyncTests', 1);  % Skip sync tests for development (remove in production)
[window, rect] = Screen('OpenWindow', 0, [0 0 0]);  % Create a black window on screen 0

textColor = [255 255 255];  % White text
KbName('UnifyKeyNames');  % Standardize key names

imageFolder = 'Images'; % folder path
imageFiles = dir(fullfile(imageFolder, '*.png')); % Get all png files in the folder

for i = 1:num_participants
question_prompt = sprintf('Rate the image from 1 to 9 (1 = you do not care and 9 = you care):');
    imgPath = fullfile(imageFolder, imageFiles(i).name);
    img = imread(imgPath);
    imshow(img);
    imgTexture = Screen('MakeTexture', window, img);
    
    % Draw the image in the center of the screen
    Screen('DrawTexture', window, imgTexture, [], []);
    
    % Display the prompt below the image
    DrawFormattedText(window, ...
        'Rate the image from 1 to 9\n(1 = Do Not Care, 9 = Care A Lot)', ...
        'center', rect(4) * 0.85, [255 255 255]);
    
    % Flip the screen to show the image and text
    Screen('Flip', window);

    rating = 0;
   while rating < 1 || rating > 9
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
                    if rating >= 1 && rating <= 9
                        break;  % Valid rating, exit loop
                    end
                end
            end
        end
    end

    responses(i) = rating;  % Store the valid rating
    
    % Display a confirmation message for the response
    DrawFormattedText(window, ['You rated: ' num2str(rating)], 'center', rect(4)/2 + 100, textColor);
    Screen('Flip', window);  % Update the screen
    WaitSecs(1);  % Wait for 1 second before moving to the next participant
end



% Save the responses 
filename = ['imageresults/' num2str(subid)];

%z-scoring
responses = (responses - mean(responses)) / std(responses);

save(filename, 'responses');
%averageresponses = mean(responses)

% Close the screen
Screen('CloseAll');