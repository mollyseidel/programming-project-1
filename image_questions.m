imageFolder = 'C:\Users\carli\OneDrive\Pictures\Pictures CLPS 950 Project 1'; % Change to your actual folder path
imageFiles = dir(fullfile(imageFolder, '*.png')); % Get all JPG files in the folder

% Preallocate storage for ratings
numimages = length(imageFiles);
store_responses = zeros(numimages, 1); % Store r



images = {'flood hurricane.png'};

for i = 1:numimages
    question_prompt = sprintf('Rate the image from 1 to 10 (1 = you do not care and 10 = you care):');
    answer = input(['Rate image ', num2str(i), ' from 1 to 10: ']);
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

while (answer < 1) || (answer > 10)
	disp('Invalid input')
    answer = input(['Rate image ', num2str(i), ' from 1 to 10: ']);
end
	
	store_responses(i) = answer;
    WaitSecs(0.5);
end 

save('imageresponses.mat', 'store_responses');