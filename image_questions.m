sca;
KbName('UnifyKeyNames');
Screen('Preference', 'SkipSyncTests', 1);
[window, screenRect] = Screen('OpenWindow', 0, [255, 255, 255], [], 32, 2); % Open a white window
screenX = screenRect(3);
screenY = screenRect(4);


imageFolder = 'C:\Users\carli\OneDrive\Pictures\Pictures CLPS 950 Project 1'; % folder path
imageFiles = dir(fullfile(imageFolder, '*.png')); % Get all png files in the folder

% Store the responses
numimages = length(imageFiles);
store_responses = zeros(numimages, 1); % Store responses



images = {'flood hurricane.png'};

for i = 1:numimages
    question_prompt = sprintf('Rate the image from 1 to 10 (1 = you do not care and 10 = you care):');
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

responsegood = false;
answer = -1;
while ~responsegood
    [~, keyCode] = KbWait([], 2);  % Check if any key is pressed
          
            % Check if Escape key is pressed to exit
            if keyCode(KbName('ESCAPE'))

                Screen('CloseAll');  % Close all Psychtoolbox windows
                clear;
                return; % Exit the script completely
            end
            
            % Loop through each pressed key 
            if keyCode(KbName('1!'))
                answer = 1;
            elseif keyCode(KbName('2@'))
                 answer = 2;
            elseif keyCode(KbName('3#'))
                 answer = 3;
            elseif keyCode(KbName('4$'))
                 answer = 4;
            elseif keyCode(KbName('5%'))
                 answer = 5;
            elseif keyCode(KbName('6^'))
                 answer = 6;
            elseif keyCode(KbName('7&'))
                 answer = 7;
            elseif keyCode(KbName('8*'))
                 answer = 8;  
            elseif keyCode(KbName('9('))
                 answer = 9;
            elseif keyCode(KbName('0)'))
                 answer = 10;
            end
                  % Convert the key to a number and check if it's within the valid range
                  % Convert the string to a number
                    if answer ~= -1
                        disp(['Selected: ', num2str(answer), '. Press ENTER to confirm'])
                        while true
                            [~, enterKeyCode] = KbWait([], 2);
                            if enterKeyCode(KbName('RETURN'))
                                responsegood = true;
                                break
                            end
                            WaitSecs(0.1); % Short pause
                        end
                    end
end
store_responses(i) = answer;
WaitSecs(0.5);
end

save('imageresponses.mat', 'store_responses');

sca;