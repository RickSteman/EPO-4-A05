% This script records 4 words with 20 samples each.
% The words are Gijp, Stop, Bak & Stuur
% These data samples will be used to train our classifier model so that we can use
% voice commands for the EPO-4 Car.
% Please send each of 4 data sets to Pieter before the start of the Lab
% session on May 4, 2021.
Fs = 8000;
recObj = audiorecorder(Fs,16,1); % create audio object, 16 bits resolution

for i=1:20
    DisplayMsg = ['Start speaking...GIJP (', num2str(i), ')'];
    disp(DisplayMsg);
    recordblocking(recObj, 2); % do a 2 second recording (blocking)
    disp('End of Recording.');
    GijpPieter(:,i) = getaudiodata(recObj);
end

for j=1:20
    DisplayMsg = ['Start speaking...STOP (', num2str(j), ')'];
    disp(DisplayMsg);
    recordblocking(recObj, 2); % do a 2 second recording (blocking)
    disp('End of Recording.');
    StopPieter(:,j) = getaudiodata(recObj);
end

for k=1:20
    DisplayMsg = ['Start speaking...BAK (', num2str(k), ')'];
    disp(DisplayMsg);
    recordblocking(recObj, 2); % do a 2 second recording (blocking)
    disp('End of Recording.');
    BakPieter(:,k) = getaudiodata(recObj);
end

for l=1:20
    DisplayMsg = ['Start speaking...STUUR (', num2str(l), ')'];
    disp(DisplayMsg);
    recordblocking(recObj, 2); % do a 2 second recording (blocking)
    disp('End of Recording.');
    StuurPieter(:,l) = getaudiodata(recObj);
end