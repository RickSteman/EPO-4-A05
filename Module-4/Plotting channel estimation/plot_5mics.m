%Authors: Ruben Eland and Pieter Gommers
%Date: June 2021
%Plotting measurements of the beacon from the 5 microphones

eps = 0.1;
Fs = 40000;

%Recording and estimating the 5-channel data

y = datagen();
%x = refsignal_new(15000,5000,2500,'E04869A5',Fs);

% h1 = channelEstimation(x,y(:,1),eps);
% h2 = channelEstimation(x,y(:,2),eps);
% h3 = channelEstimation(x,y(:,3),eps);
% h4 = channelEstimation(x,y(:,4),eps);

t = 1/Fs*(0:1:length(y)-1);

subplot(5,2,1)
plot(t,y(:,1),'DisplayName', 'Channel estimation of mic 1')
% x1 = xline(t(peak1_loc),'--r','DisplayName','Peak in channel estimation of mic 1');
% legend('show');

subplot(5,2,2)
plot(t,y(:,2),'DisplayName', 'Channel estimation of mic 2')
% x2 = xline(t(peak2_loc),'--r','DisplayName','Peak in channel estimation of mic 2');
% legend('show');

subplot(5,2,3)
plot(t,y(:,3),'DisplayName', 'Channel estimation of mic 1')
% x1 = xline(t(peak1_loc),'--r','DisplayName','Peak in channel estimation of mic 1');
% legend('show');

subplot(5,2,4)
plot(t,y(:,4),'DisplayName', 'Channel estimation of mic 2')
% x2 = xline(t(peak2_loc),'--r','DisplayName','Peak in channel estimation of mic 2');
% legend('show');

subplot(5,2,5)
plot(t,y(:,5),'DisplayName', 'Channel estimation of mic 1')
% x1 = xline(t(peak1_loc),'--r','DisplayName','Peak in channel estimation of mic 1');
% legend('show');