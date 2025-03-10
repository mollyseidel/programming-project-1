%images
%clear all screens and figures as well as all variables in the workspace
sca;
close all;
clear all;
%call defauly settings for setting up Psychtoolbox
PsychDefaultSetup(2);


%establishing a screen with background grey
screens = Screen ('Screens');

screenNumber = max(screens);
white = WhiteIndex (screenNumber);
black = BlackIndex (screenNumber);
grey = white/2;

[window, windowRect] = PsychImaging ('OpenWindow', screenNumber, grey);
KbStrokeWait;
sca;
