%making the regression
load("question2responses.mat");
disp(responses)

load("question1responses.mat");
disp(responses)

load("imagesresponses.mat")
disp(responses)

X = ["imagesresponses.mat","question1responses.mat", ]; %change when images get set

Y = "question2responses.mat"; %Both X and Y need to be numerical arrays or matrices, not file names or strings.

mdl = fitlm(X,Y);

disp('Linear regression model:');
disp(mdl)

