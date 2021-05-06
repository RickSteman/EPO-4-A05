% This script records 4 words with 20 samples each.
% The words are Gij, Stop, Bak & Uur
% These data samples will be used to train our classifier model so that we can use
% voice commands for the EPO-4 Car.
% Full length of recording session around 8 minutes.
% Please send each of 4 data sets to Pieter before the start of the Lab
% session on May 6, 2021.
% Listen to a sample using the command: sound(GijPieter(:,4), Fs); (This is
% the 4th sample of the word Gij spoken by Pieter)
% Please check if there is not too much noise in the signal.
Fs = 8000;
recObj = audiorecorder(Fs,16,1); % create audio object, 16 bits resolution

for i=1:20
    disp('Record word GIJ in 3');
    pause(1);
    disp('Record word GIJ in 2');
    pause(1);
    disp('Record word GIJ in 1');
    pause(1);
    DisplayMsg = ['Start speaking...GIJ (', num2str(i), ')'];
    disp(DisplayMsg);
    recordblocking(recObj, 2); % do a 2 second recording (blocking)
    disp('End of Recording.');
    pause(1);
    GijPieter(:,i) = getaudiodata(recObj);
end

for j=1:20
    disp('Record word STOP in 3');
    pause(1);
    disp('Record word STOP in 2');
    pause(1);
    disp('Record word STOP in 1');
    pause(1);
    DisplayMsg = ['Start speaking...STOP (', num2str(j), ')'];
    disp(DisplayMsg);
    recordblocking(recObj, 2); % do a 2 second recording (blocking)
    disp('End of Recording.');
    pause(1);
    StopPieter(:,j) = getaudiodata(recObj);
end

for k=1:20
    disp('Record word BAK in 3');
    pause(1);
    disp('Record word BAK in 2');
    pause(1);
    disp('Record word BAK in 1');
    pause(1);
    DisplayMsg = ['Start speaking...BAK (', num2str(k), ')'];
    disp(DisplayMsg);
    recordblocking(recObj, 2); % do a 2 second recording (blocking)
    disp('End of Recording.');
    pause(1);
    BakPieter(:,k) = getaudiodata(recObj);
end

for l=1:20
    disp('Record word UUR in 3');
    pause(1);
    disp('Record word UUR in 2');
    pause(1);
    disp('Record word UUR in 1');
    pause(1);
    DisplayMsg = ['Start speaking...UUR (', num2str(l), ')'];
    disp(DisplayMsg);
    recordblocking(recObj, 2); % do a 2 second recording (blocking)
    disp('End of Recording.');
    pause(1);
    UurPieter(:,l) = getaudiodata(recObj);
end