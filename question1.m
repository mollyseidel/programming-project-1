num_participants = 5; %to be changed

responses = zeros(num_participants, 1);  % Creating a column vector to store responses

for i = 1:num_participants
% Ask to rate if they feel impacted by climate change
climate_impact = input('How directly do you feel climate change is impacting your life or livelihood? (1 - 10 scale: 1 = not at all, 10 = immediate threat): ');

% Make sure response is between 1 and 10
while climate_impact < 1 || climate_impact > 10
    disp('Please enter a number between 1 and 10.');
    climate_impact = input('If the opportunity arose, would you involve yourself with advocacy for climate change mitigation or adaptation? (1 = not at all, 10 = immediate threat): ');
end

responses(i) = impact; %not working

end

save('question1.m', 'responses'); %saving for later calculations - I'm not displaying them but I want to store them for later, like a column vector to later use maybe? 

