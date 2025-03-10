num_participants = 5; %to be changed

responses = zeros(num_participants, 1);  % Creating a column vector to store responses

for i = 1:num_participants
% Ask to rate if they would engage in climate advocacy
potential_advocacy = input('If the opportunity arose, would you involve yourself with advocacy for climate change mitigation or adaptation? (1 = no I don’t really care, 10 = yes, absolutely): ');

% Make sure response is between 1 and 10
while potential_advocacy < 1 || potential_advocacy > 10
    disp('Please enter a number between 1 and 10.');
    potential_advocacy = input('If the opportunity arose, would you involve yourself with advocacy for climate change mitigation or adaptation? (1 = no I don’t really care, 10 = yes, absolutely): ');
end

responses(i) = advocacy; %not working

disp(responses)
end

save('question2.m', 'responses'); %saving for later calculations - I'm not displaying them but I want to store them for later, like a column vector to later use maybe? 

