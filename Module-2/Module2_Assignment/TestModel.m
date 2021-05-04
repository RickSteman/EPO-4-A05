recObj = audiorecorder(Fs,16,1); % create audio object, 16 bits resolution
disp('Start speaking...')
recordblocking(recObj, 2); % do a 2 second recording (blocking)
disp('End of Recording.');
disp('1 = GIJP, 2 = STOP, 3 = BAK, 4 = STUUR');
y = getaudiodata(recObj);

% extract feat
x_test = ExtractFeat(y,Fs,L,ov,threshold);

% standard normalize 
x_test = (x_test-mu_train)./sigma_train;

% predict
y_test_pred= str2double(model.predict(x_test));