% Group A5 - EPO4 2021
% Authors: Ruben Eland & Pieter Gommers
% Description:
% This file creates a plot with the spectrograms of each of the 4 commands
% that have been created. This plot is used to discuss the differentiality
% and the seperability of these commands by showing differences in
% formants, pitch and frequency overall.

% Variables
threshold = 0.1;
L = (20/1000)*8000; 
Fs = 8000;
ov = L*0.5;

% WORD 1: BAK
y = BakLennert(:,5);

y_norm= y - sum(y)/length(y);
y_norm= y_norm / max(abs(y_norm));
[~,~,y_nosilence] = RemoveSilence(y_norm,threshold);    
f0 = FindPitch(y_nosilence,Fs,L,ov);
[t_vec,frmtns] = FormantsEpo4(y_nosilence,Fs,L,ov);

[~,f,t,ps]=spectrogram(y_nosilence, L,ov,L,Fs,'yaxis');
figure;
subplot(2,2,1);
imagesc(t,f,10*log10(ps)); axis xy;

title('BAK');

hold on;
plot(t_vec,f0,'Color','red','LineWidth',2);
plot(t_vec,frmtns,'Color','black','LineWidth',1.5);
xlabel('Time(s)');ylabel('Frequency(Hz)'); hold off;

% WORD 2: GIJ
y = GijLennert(:,5);

y_norm= y - sum(y)/length(y);
y_norm= y_norm / max(abs(y_norm));
[~,~,y_nosilence] = RemoveSilence(y_norm,threshold);    
f0 = FindPitch(y_nosilence,Fs,L,ov);
[t_vec,frmtns] = FormantsEpo4(y_nosilence,Fs,L,ov);

[~,f,t,ps]=spectrogram(y_nosilence, L,ov,L,Fs,'yaxis');
subplot(2,2,2);
imagesc(t,f,10*log10(ps)); axis xy;

title('GIJ');

hold on;
plot(t_vec,f0,'Color','red','LineWidth',2);
plot(t_vec,frmtns,'Color','black','LineWidth',1.5);
xlabel('Time(s)');ylabel('Frequency(Hz)'); hold off;

% WORD 3: STOP
y = StopLennert(:,5);

y_norm= y - sum(y)/length(y);
y_norm= y_norm / max(abs(y_norm));
[~,~,y_nosilence] = RemoveSilence(y_norm,threshold);    
f0 = FindPitch(y_nosilence,Fs,L,ov);
[t_vec,frmtns] = FormantsEpo4(y_nosilence,Fs,L,ov);

[~,f,t,ps]=spectrogram(y_nosilence, L,ov,L,Fs,'yaxis');
subplot(2,2,3);
imagesc(t,f,10*log10(ps)); axis xy;

title('STOP');

hold on;
plot(t_vec,f0,'Color','red','LineWidth',2);
plot(t_vec,frmtns,'Color','black','LineWidth',1.5);
xlabel('Time(s)');ylabel('Frequency(Hz)'); hold off;

% WORD 1: UUR
y = UurLennert(:,5);

y_norm= y - sum(y)/length(y);
y_norm= y_norm / max(abs(y_norm));
[~,~,y_nosilence] = RemoveSilence(y_norm,threshold);    
f0 = FindPitch(y_nosilence,Fs,L,ov);
[t_vec,frmtns] = FormantsEpo4(y_nosilence,Fs,L,ov);

[~,f,t,ps]=spectrogram(y_nosilence, L,ov,L,Fs,'yaxis');
subplot(2,2,4);
imagesc(t,f,10*log10(ps)); axis xy;

title('UUR');

hold on;
plot(t_vec,f0,'Color','red','LineWidth',2);
plot(t_vec,frmtns,'Color','black','LineWidth',1.5);
xlabel('Time(s)');ylabel('Frequency(Hz)'); hold off;