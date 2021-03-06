% Group A5 - EPO4 2021
% Authors: Ruben Eland & Pieter Gommers
% Description:
% This file tests a model trained by our own dictionary. When the file is
% run, the user will record a command and the model in the workspace will
% predict the command. The prediction is then displayed to the user.

threshold= 0.1;
Fs = 8000;
L= (20/1000)*8000;
ov= L*0.5;

recObj = audiorecorder(Fs,16,1); % create audio object, 16 bits resolution
disp('Start speaking...')
recordblocking(recObj, 2); % do a 2 second recording (blocking)
disp('End of Recording.');
y = getaudiodata(recObj);

% extract feat
x_test = ExtractFeat(y,Fs,L,ov,threshold);

% standard normalize 
x_test = (x_test-mu_train)./sigma_train;

% predict
y_test_pred= str2double(model.predict(x_test));


% if(y_test_pred == 1)
%     disp('Bak');
% elseif(y_test_pred == 2)
%     disp('Gijp');
% elseif(y_test_pred == 3)
%     disp('Stop');
% else
%     disp('Stuur');
% end

if(y_test_pred == 1)
    disp('Bak');
elseif(y_test_pred == 2)
    disp('Gij');
else
    disp('Stop');
end