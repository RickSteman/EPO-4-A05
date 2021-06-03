clear all;
<<<<<<< HEAD

pos = [250;350];
=======
pos = [361;278];
>>>>>>> c4b80faa86b6ad7a37aed6e16770914d4e6877ec
EPOCommunications('init',['X' mat2str(pos)]); % initial position of car
EPOCommunications('init','D[0;1]'); % initial direction of car

P = [
0 0 600 600 300;
0 600 0 600 0; 
<<<<<<< HEAD
30 30 30 30 5]; % positions of mics
=======
30 30 30 30 30]; % positions of mics
>>>>>>> c4b80faa86b6ad7a37aed6e16770914d4e6877ec

EPOCommunications('init',['P' mat2str(P)]); % initialize positions of mics
EPOCommunications('init','J40000'); % set sample rate of mics (Hz)
EPOCommunications('init','N2000'); % set number of samples to return

kitt = EPOCommunications('open'); % create kitt! (hidden state)
% kitt = EPOCommunications('open','P'); % create kitt! now in public mode

%EPOCommunications('transmit','S'); % request status string

%EPOCommunications('transmit', 'A0'); % switch off audio beacon
EPOCommunications('transmit', 'A1'); % switch on audio beacon

EPOCommunications('transmit', 'B5000'); % set the bit frequency
EPOCommunications('transmit', 'F15000');% set the carrier frequency
EPOCommunications('transmit', 'R2500'); % set the repetition count
EPOCommunications('transmit', 'C0xE04869A5'); % set the audio code

%E04869A5
% x = kitt.Beacon.message;
% 
% X = EPOCommunications('receive'); % receive micarray signals (matrix)
% X = EPOCommunications('receive','N20000');
% 
% plot(X)
% 
% [~,~,y_nosilence] = RemoveSilence(X,0.1);
