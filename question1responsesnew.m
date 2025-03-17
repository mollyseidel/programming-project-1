subid = 1256;  % Participant ID
num_participants = 1;  % Only one participant now

responses = zeros(num_participants, 1);  % Create a column vector to store responses

% Setup for Psychtoolbox
PsychDefaultSetup(2);
Screen('Preference', 'SkipSyncTests', 1);  % Skip sync tests for development (remove in production)
[window1, rect] = Screen('OpenWindow', 0, [0 0 0]);  % Create a black window on screen 0

textColor = [255 255 255];  % White text
KbName('UnifyKeyNames');  % Standardize key names

% Only include the first question
questionTexts = {
    'How directly do you feel climate change is impacting your life or livelihood? (1 = not at all, 10 = immediate threat):'
};

for i = 1:num_participants
    % Show the question and get the rating
    questionText = questionTexts{i};
    disp(questionText)
    ratingText = 'Press keys 1-10 for your rating (1 = not at all, 10 = immediate threat)';
    
    % Display the question and instructions on the screen
    DrawFormattedText(window1, questionText, 'center', rect(4)/3, textColor);
    DrawFormattedText(window1, ratingText, 'center', rect(4)/2, textColor);
    Screen('Flip', window1);  % Update the screen

    % Wait for the user to press a key corresponding to a rating (1-10)
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
filename = ['results1/question1responsesnew' num2str(subid)];
save(filename, 'responses');

% Close the screen
Screen('CloseAll');
