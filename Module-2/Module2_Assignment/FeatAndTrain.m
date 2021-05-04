dataTotal=[UpPieter, GijpRuben, StopPieter, StopRuben, BakPieter, BakRuben, StuurPieter, StuurRuben];

num_samples=size(dataTotal,2);
num_feat=16;
threshold= 0.1;
L= (20/1000)*8000; 

% "ov": Length of the overlap (in samples)
ov= L*0.5;

% matrix for recording the features
X=zeros(num_samples, num_feat);

% Extracting the features
for i=1:size(dataTotal,2)
    
    y = dataTotal(:,i);
    X(i,:)=ExtractFeat(y,Fs,L,ov,threshold);
    
end

Y=[ones(20,1);2.*ones(20,1);3.*ones(20,1);4.*ones(20,1)];

percent_train_split=70/100;
[train_id,test_id]=train_test_split(Y,percent_train_split);

% splitting the inputs
Xtrain=X(train_id,:);
Xtest=X(test_id,:);

% splitting the labels
Ytrain=Y(train_id,:);
Ytest=Y(test_id,:);

[Xtrain,mu_train,sigma_train] = zscore(Xtrain);

Xtest= (Xtest-mu_train)./sigma_train;

[idx,scores] = fscmrmr(Xtrain,Ytrain);

figure;bar(idx,scores(idx)) %Create bar graph
xlabel('Feature')
set(gca,'TickLabelInterpreter','latex');
ylabel('Predictor Score'); hold off;

rng default
% number of trees
nTrees = 30;

% Train the TreeBagger (Random Forest).
model = TreeBagger( nTrees,Xtrain,Ytrain ...
    , 'Method', 'classification');

Ytest_pred_str = model.predict(Xtest);
Ytest_pred = str2double(Ytest_pred_str);

num_classes=length(unique(Y));
Ytest_cat=zeros(num_classes,size(Ytest,1));
Ytest_pred_cat=zeros(num_classes,size(Ytest,1));

for i=1:num_classes
    Ytest_cat(i, Ytest==i) = 1;
    Ytest_pred_cat(i, Ytest_pred==i) = 1;
end

figure; plotconfusion(Ytest_cat,Ytest_pred_cat); hold off;