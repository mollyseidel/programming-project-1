% Ask to rate how directly they feel climate change is impacting them
climate_impact = input('How directly do you feel climate change is impacting your life or livelihood? (1 = not at all, 10 = immediate threat): ');

% Make sure response is between 1 and 10
while climate_impact < 1 || climate_impact > 10
    disp('Please enter a number between 1 and 10.');
    climate_impact = input('How directly do you feel climate change is impacting your life or livelihood? (1 = not at all, 10 = immediate threat): ');
end
