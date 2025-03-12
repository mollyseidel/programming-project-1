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

%create frames for images to be displayed on
numSecs = 5; %frame will be displayed for 5 seconds
for the_image = 1:30 %30 images
    %this is where coding for images comes in
    [screenXpixels, screenYpixels] = Screen ('WindowSize', window);

    the_image = imread (sloth.jpg);
    [s1, s2, ~] = size(the_image);

    %check for if image is too big, error if so
    if s1 > screenYpixels || s2 > screenXpixels
        disp ('Image is bigger than the screen');
        sca;
        return;
    end
end

    vbl = Screen ('Flip', window, vbl + numSecs - ifi/2);

Priority (0);
sca;

   
