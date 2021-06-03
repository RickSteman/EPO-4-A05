eps = 0.2;
Fs = 40000;

y = datagen();
x = refsignal_new(15000,5000,2500,'E04869A5',Fs);

h1 = channelEstimation(x,y(:,1),eps);
h2 = channelEstimation(x,y(:,2),eps);

% if(y1>0.

% peak1 = max(h1);%peak value in the plot of h_1
% peak1_loc = find(h1==peak1);%peak location in the plot of h_1

firstpeak1 = firstPeak(h1, 0.7);

% peak2 = max(h2);%peak value in the plot of h_2
% peak2_loc = find(h2==peak2);%peak location in the plot of h_2

firstpeak2 = firstPeak(h2, 0.7);

t = 1/Fs*(0:1:length(y)-1);

% offset = peak1_loc - 500; %Start of first pulse
% length_h = 1000; %Duration of first pulse
% h_1 = h1(offset:offset+length_h);
% h_2 = h2(offset:offset+length_h);
% 
% t_1 = t(offset:offset+length_h);

subplot(2,1,1)
plot(t,h1,'DisplayName', 'Channel estimation of mic 1')
x1 = xline(t(firstpeak1),'--r','DisplayName','Peak in channel estimation of mic 1');
legend('show');

subplot(2,1,2)
plot(t,h2,'DisplayName', 'Channel estimation of mic 2')
x2 = xline(t(firstpeak2),'--r','DisplayName','Peak in channel estimation of mic 2');
legend('show');

%TDOA algorithm

n_delay = firstpeak2 - firstpeak1;
t_delay = (1/Fs)*(n_delay);
distance = t_delay*34326;

