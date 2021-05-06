function prediction = PredictVoice()
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
y_test_pred = str2double(model.predict(x_test));

if(y_test_pred == 1)
    prediction = 4;
elseif(y_test_pred == 2)
    prediction = 1;
elseif(y_test_pred == 3)
    prediction = 2;
else
    prediction = 3;
end

end