%making the regression
filenames = dir(fullfile('results', '*.mat'));
responsesall=[];

for i = 1:length(filenames)
    disp(filenames(i))
    fn=fullfile('results', filenames(i).name);
    r=load(fn);
    responsesall = [responsesall r];
end


X = ["imagesresponses.mat","question1responses.mat", ]; %change when images get set

Y = "question2responses.mat"; %Both X and Y need to be numerical arrays or matrices, not file names or strings.

mdl = fitlm(X,Y);

disp('Linear regression model:');
disp(mdl)

% Extracting coefficients, p-values, and R-squared value
coefficients = mdl.Coefficients.Estimate;  % Should be 3 Coefficients for the 'predictors'
pValues = mdl.Coefficients.pValue;         % Should be 3 P-values for the 'predictors'
rSquared = mdl.Rsquared.Ordinary;          % R-squared value

acceptHypothesis = true;

% Check if all coefficients are positive
if any(coefficients <= 0)
    acceptHypothesis = false;  % Reject if any coefficient is negative
end

% Check if all p-values are less than 0.05
if any(pValues >= 0.05)
    acceptHypothesis = false;  % Reject if any p-value is >= 0.05
end

% Check if R-squared is above 0.70
if rSquared <= 0.70
    acceptHypothesis = false;  % Reject if R-squared is <= 0.70
end

% Final decision
if acceptHypothesis
    disp('People who perceive themselves to be more directly impacted by climate change and experience higher emotional distress because of climate change impacts are more likely to support mitigation efforts');
else
    disp('People who perceive themselves to be more directly impacted by climate change and experience higher emotional distress because of climate change impacts are not more likely to support mitigation efforts');
end


