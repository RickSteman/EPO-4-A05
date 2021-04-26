function x_vec=ExtractFeat(y,Fs,L,ov,threshold)
    
    % normalize y
    % remove mean
    y_norm= % your code here; 
    % devide by the max abs value
    y_norm= % your code here;
    
    % remove silence
    [~,~,y_nosilence] = % your code here;;

    % find pitch
    f0 = % your code here;
    
    % find formants
    [~,frmtns] = % your code here;
    
    % features
    % your code here;
    
    x_vec=% your code here;
    
end