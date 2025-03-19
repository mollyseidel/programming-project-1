%making the regression
filenames = dir(fullfile('results/', '*.mat'));
responsesall=zeros(2,2);
responseallimages=zeros(2,30);

for i = 1:length(filenames)
    disp(filenames(i))
    fn=fullfile('results/', filenames(i).name);
    r=load(fn);
    C= struct2cell(r);
    responsesall(i, :) = cell2mat(C); % [responsesall r];
end

for i = 1:length(filenames)
    disp(filenames(i))
    fn=fullfile('imageresults/', filenames(i).name);
    r=load(fn);
    C= struct2cell(r);
    responseallimages(i, :) = cell2mat(C); % [responsesallimages r];
end


column1 = responsesall(:, 1);
column2 = responsesall(:, 2);


mdl = fitlm(column1,column2);

mdl1 = fitlm(responseallimages,column2);

disp('Linear regression model:');
disp(mdl);
disp(mdl1);

% Extracting coefficients, p-values, and R-squared value
coefficients = mdl.Coefficients.Estimate;  % Should be 2 Coefficients for the 'predictors'
pValues = mdl.Coefficients.pValue;         % Should be 2 P-values for the 'predictors'
rSquared = mdl.Rsquared.Ordinary;          % R-squared value

acceptHypothesis1 = true;

% Check if all coefficients are positive
if any(coefficients <= 0)
    acceptHypothesis1 = false;  % Reject if any coefficient is negative
end
disp(coefficients)
% Check if all p-values are less than 0.05
if any(pValues >= 0.05)
    acceptHypothesis1 = false;  % Reject if any p-value is >= 0.05
end
disp(pValues)
% Check if R-squared is above 0.70
if rSquared <= 0.70
    acceptHylana pothesis1 = false;  % Reject if R-squared is <= 0.70
end
disp(rSquared)
% Final decision
if acceptHypothesis1
    disp('People who perceive themselves to be more directly impacted by climate change are more likely to support mitigation efforts');
else
    disp('People who perceive themselves to be more directly impacted by climate change are not more likely to support mitigation efforts');
end


% Extracting coefficients, p-values, and R-squared value
coefficients1 = mdl1.Coefficients.Estimate;  % Should be 3 Coefficients for the 'predictors'
pValues1 = mdl1.Coefficients.pValue;         % Should be 3 P-values for the 'predictors'
rSquared1 = mdl1.Rsquared.Ordinary;          % R-squared value

acceptHypothesis2 = true;

% Check if all coefficients are positive
if any(coefficients1 <= 0)
    acceptHypothesis2 = false;  % Reject if any coefficient is negative
end

% Check if all p-values are less than 0.05
if any(pValues1 >= 0.05)
    acceptHypothesis2 = false;  % Reject if any p-value is >= 0.05
end

% Check if R-squared is above 0.70
if rSquared1 <= 0.70
    acceptHypothesis2 = false;  % Reject if R-squared is <= 0.70 
end

% Final decision
if acceptHypothesis2
    disp('People who experience higher emotional distress because of climate change impacts are more likely to support mitigation efforts');
else
    disp('People who experience higher emotional distress because of climate change impacts are not more likely to support mitigation efforts');
end

