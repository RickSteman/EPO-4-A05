%Authors: Ruben Eland and Pieter Gommers

eps = 0.17;
Fs = 40000;

y = datagen();
x = refsignal_new(15000,5000,2500,'aa55aa55',Fs);

h1 = channelEstimation(x,y(:,1),eps);
h2 = channelEstimation(x,y(:,2),eps);

% if(y1>0.

peak1 = max(h);%peak value in the plot of h_y1
peak1_loc = find(h==peak1);%peak location in the plot of h_y1

t = 1/Fs*(0:1:length(y)-1);

plot(t,h,'DisplayName', 'Channel estimation')
x1 = xline(t(peak1_loc),'--r','peak','DisplayName','Peak in channel estimation');
xl.LabelVerticalAlignment = 'middle';
xl.LabelHorizontalAlignment = 'center';
legend('show');

