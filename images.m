%images
%clear all screens and figures as well as all variables in the workspace
sca;
close all;
clear all;
%call defauly settings for setting up Psychtoolbox
PsychDefaultSetup(2);
screen('Preference','SkipSynchTest',1)

%establishing a screen with background grey
screens = Screen ('Screens');

screenNumber = max(screens);
white = WhiteIndex (screenNumber);
black = BlackIndex (screenNumber);
grey = white/2;

[window, windowRect] = PsychImaging ('OpenWindow', screenNumber, grey);


KbStrokeWait;
[screenXpixels, screenYpixels] = Screen ('WindowSize', window);

%coding for the image
the_image = imread ('sloth.jpg') % Check that the image file (sloth.jpg) is in the current directory or provide the full path to the image file. Sometimes, an issue arises if the image file cannot be found, but no error is raised until you try to display it.

[s1, s2, ~] = size(the_image);

sca;    

    %check for if image is too big, error if so
    if s1 > screenYpixels || s2 > screenXpixels
        disp ('Image is bigger than the screen');
        sca;
        return;
    end
imageTexture = Screen ('MakeTexture', window, the_image); %actual display function
Screen ('DrawTexture', window, imageTexture, [], [], 0);
Priority(1);

vbl = Screen ('Flip', window);

Priority(0);

sca;

   
