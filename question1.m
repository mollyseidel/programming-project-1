num_participants = 5; %to be changed

responses = zeros(num_participants, 1);  % Creating a column vector to store responses

for i = 1:num_participants
% Ask to rate how directly they feel climate change is impacting them
perceived_impact = input('How directly do you feel climate change is impacting your life or livelihood? (1 = not at all, 10 = immediate threat): ');


while perceived_impact < 1 || perceived_impact > 10
   disp('Please enter a number between 1 and 10.');
   perceived_impact = input('How directly do you feel climate change is impacting your life or livelihood? (1 = not at all, 10 = immediate threat): ');
end

responses(i) = perceived_impact; 
end

save('question1responses.mat', 'responses'); %saving for later calculations
