
function [train_id,test_id]=train_test_split(Y,percent_train_split)

    train_id=[];
    test_id=[];
    num_classes=length(unique(Y));

% loop through the classes
    for i=1:num_classes 
        % finding the indices belonging to each class
        ind_i=find(Y==i);
        % shuffling the indice
        ind_i_perm=ind_i(randperm(length(ind_i)));
        % the split point for train test
        ind_split=round(percent_train_split*length(ind_i));
        % adding the train ids to the the previous ids 
        train_id=[train_id;ind_i_perm(1:ind_split)];
        % adding the test ids to the the previous ids 
        test_id=[test_id;ind_i_perm(ind_split+1:end)]; 

    end
end