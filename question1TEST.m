
subid= 0004; %change for each participant
num_participants = 2;

responses = zeros(num_participants, 1);  % Creating a column vector to store responses

% Setup for Psychtoolbox
PsychDefaultSetup(2);
Screen('Preference', 'SkipSyncTests', 1);  % Skip sync tests for development (remove in production)
[window1, rect] = Screen('OpenWindow', 0, [0 0 0]);  % Create a black window on screen 0

textColor = [255 255 255];  % White text
KbName('UnifyKeyNames');  % Standardize key names

questionTexts = {'How directly do you feel climate change is impacting your life or livelihood? (1 = not at all, 9 = immediate threat):',
   'If the opportunity arose, would you involve yourself with advocacy for climate change mitigation or adaptation? (1 = no, 9 = yes, absolutely)'};

for i = 1:num_participants
    % Show the question and get the rating
   
    questionText = questionTexts{i};
    disp(questionText)
    ratingText = 'Press keys 1-10 for your rating (1 = not at all/no, 10 = immediate threat/yes)';

    % Display the question and instructions on the screen
    DrawFormattedText(window1, questionText, 'center', rect(4)/3, textColor);
    DrawFormattedText(window1, ratingText, 'center', rect(4)/2, textColor);
    Screen('Flip', window1);  % Update the screen

    % Wait for the user to press a key corresponding to a rating (1-9)
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
                key = KbName(keyPressed(1));  % Get the key name
                if any(strcmp(key, {'1!', '2@', '3#', '4$', '5%', '6^', '7&', '8*', '9(', '0)'}))  % Valid keys (1-10)
                    rating = str2double(key);  % Convert key to numerical value
                    keypr = key;
                    if rating >= 1 && rating <= 9
                        break;  % Valid rating, exit loop
                    end
                end 

            end
        end
    end
    disp(keypr)
    responses(i) = str2double(keypr(1)); 

    % Display a confirmation message for the response
    DrawFormattedText(window1, ['You rated: ' keypr(1)], 'center', rect(4)/2 + 100, textColor);
    %responses(i) = rating; 

    Screen('Flip', window1);  % Update the screen
    WaitSecs(1);  % Wait for 1 second before moving to the next participant
end

% Save the responses 

    filename = ['results/' num2str(subid)] ;
save(filename, 'responses');

% Close the screen
Screen('CloseAll');

%gotta figure out again how to store without NaN
%remember how to call from command
%