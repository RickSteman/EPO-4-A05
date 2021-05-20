% Group A5 - EPO4 2021
% Authors: Ruben Eland & Pieter Gommers
% Description:
% This file tests a model (trained by both a man and woman) using only the
% man as input for the test.

dataMan=[DownM,LeftM,RightM,UpM];

num_samples=size(dataMan,2);
num_feat=16;

X=zeros(num_samples, num_feat);

% Extracting the features
for i=1:size(dataMan,2)
    
    y = dataMan(:,i);
    X(i,:)=ExtractFeat(y,Fs,L,ov,threshold);
    
end

% labels
Y=[ones(10,1);2.*ones(10,1);3.*ones(10,1);4.*ones(10,1)];

% standard normalization of testing data
X= (X-mu_train)./sigma_train;

Y_pred_str = model.predict(X);
Y_pred = str2double(Y_pred_str);

num_classes=length(unique(Y));
Y_cat=zeros(num_classes,size(Y,1));
Y_pred_cat=zeros(num_classes,size(Y_pred,1));

for i=1:num_classes
    Y_cat(i, Y==i) = 1;
    Y_pred_cat(i, Y_pred==i) = 1;
end

figure; plotconfusion(Y_cat,Y_pred_cat); hold off;