function x_vec=ExtractFeat(y,Fs,L,ov,threshold)
    
    % normalize y
    % remove mean
    y_norm= y - sum(y)/length(y); 
    % devide by the max abs value
    y_norm= y_norm / max(abs(y_norm));
    
    % remove silence
    [~,~,y_nosilence] = RemoveSilence(y_norm,threshold);

    % find pitch
    f0 = FindPitch(y_nosilence,Fs,L,ov);
    
    % find formants
    [~,frmtns] = FormantsEpo4(y_nosilence,Fs,L,ov);
    
    % features
    % mean, median, and variance of the pitch: 
    x1=mean(f0,'omitnan');
    x2=median(f0,'omitnan');
    x3=var(f0,'omitnan');

    % mean, median, and variance of each formants
    x4=mean(frmtns,1,"omitnan");
    x5=median(frmtns,1,"omitnan");
    x6=var(frmtns,1,"omitnan");

    % mean, median, and variance of F1/F2
    f1f2=frmtns(:,1)./frmtns(:,2); % F1/F2
    x7=mean(f1f2,'omitnan');
    x8=median(f1f2,'omitnan');
    x9=var(f1f2,'omitnan');

    % putting all the features together: size 1*15
    x_vec=[x1,x2,x3,x4,x5,x6,x7,x8,x9]; 
    
end