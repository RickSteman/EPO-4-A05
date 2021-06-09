%Authors: Ruben Eland and Pieter Gommers
%Date: June 2021

eps = 0.1;
Fs = 40000;

%Recording and estimating the 5-channel data

y = datagen();
ref = refsignal_new(15000,5000,2500,'E04869A5',Fs);

h1 = channelEstimation(ref,y(:,1),eps);
h2 = channelEstimation(ref,y(:,2),eps);
h3 = channelEstimation(ref,y(:,3),eps);
h4 = channelEstimation(ref,y(:,4),eps);
h5 = channelEstimation(ref,y(:,5),eps);

%Implementation of localization algorithm from Appendix B.1

firstpeak_1 = firstPeak(h1, 0.9);
firstpeak_2 = firstPeak(h2, 0.9);
firstpeak_3 = firstPeak(h3, 0.9);
firstpeak_4 = firstPeak(h4, 0.9);
firstpeak_5 = firstPeak(h5, 0.9);

n_delay_12 = firstpeak_1 - firstpeak_2;
t_delay_12 = (1/Fs)*(n_delay_12);
r_12 = t_delay_12*34326;
if r_12 == 0
    r_12 = 0.0001;
end

n_delay_13 = firstpeak_1 - firstpeak_3;
t_delay_13 = (1/Fs)*(n_delay_13);
r_13 = t_delay_13*34326;
if r_13 == 0
    r_13 = 0.0001;
end

n_delay_14 = firstpeak_1 - firstpeak_4;
t_delay_14 = (1/Fs)*(n_delay_14);
r_14 = t_delay_14*34326;
if r_14 == 0
    r_14 = 0.0001;
end

n_delay_15 = firstpeak_1 - firstpeak_5;
t_delay_15 = (1/Fs)*(n_delay_15);
r_15 = t_delay_15*34326;
if r_15 == 0
    r_15 = 0.0001;
end

n_delay_23 = firstpeak_2 - firstpeak_3;
t_delay_23 = (1/Fs)*(n_delay_23);
r_23 = t_delay_23*34326;
if r_23 == 0
    r_23 = 0.0001;
end

n_delay_24 = firstpeak_2 - firstpeak_4;
t_delay_24 = (1/Fs)*(n_delay_24);
r_24 = t_delay_24*34326;
if r_24 == 0
    r_24 = 0.0001;
end

n_delay_25 = firstpeak_2 - firstpeak_5;
t_delay_25 = (1/Fs)*(n_delay_25);
r_25 = t_delay_25*34326;
if r_25 == 0
    r_25 = 0.0001;
end

n_delay_34 = firstpeak_3 - firstpeak_4;
t_delay_34 = (1/Fs)*(n_delay_34);
r_34 = t_delay_34*34326;
if r_34 == 0
    r_34 = 0.0001;
end

n_delay_35 = firstpeak_3 - firstpeak_5;
t_delay_35 = (1/Fs)*(n_delay_35);
r_35 = t_delay_35*34326;
if r_35 == 0
    r_35 = 0.0001;
end

n_delay_45 = firstpeak_4 - firstpeak_5;
t_delay_45 = (1/Fs)*(n_delay_45);
r_45 = t_delay_45*34326;
if r_45 == 0
    r_45 = 0.0001;
end

%positions of the mics

x1 = [0; 0];
x2 = [0; 600];
x3 = [600; 0];
x4 = [600; 600];
x5 = [300; 0];

% A = [2*((x2-x1).') -2*r_12 0 0 0;
%     2*((x3-x1).') 0 -2*r_13 0 0;
%     2*((x4-x1).') 0 0 -2*r_14 0;
%     2*((x5-x1).') 0 0 0 -2*r_15;
%     2*((x3-x2).') 0 -2*r_23 0 0;
%     2*((x4-x2).') 0 0 -2*r_24 0;
%     2*((x5-x2).') 0 0 0 -2*r_25;
%     2*((x4-x3).') 0 0 -2*r_34 0;
%     2*((x5-x3).') 0 0 0 -2*r_35;
%     2*((x5-x4).') 0 0 0 -2*r_45];
% 
% b = [r_12^2-(norm(x1))^2+(norm(x2))^2;
%     r_13^2-(norm(x1))^2+(norm(x3))^2;
%     r_14^2-(norm(x1))^2+(norm(x4))^2;
%     r_15^2-(norm(x1))^2+(norm(x5))^2;
%     r_23^2-(norm(x2))^2+(norm(x3))^2;
%     r_24^2-(norm(x2))^2+(norm(x4))^2;
%     r_25^2-(norm(x2))^2+(norm(x5))^2;
%     r_34^2-(norm(x3))^2+(norm(x4))^2;
%     r_35^2-(norm(x3))^2+(norm(x5))^2;
%     r_45^2-(norm(x4))^2+(norm(x5))^2];
% 
% A_t = inv((A.')*A);
% y_out = (A_t)*(A.')*b;
% 
% x = zeros(2,1);
% 
% x(1) = y_out(1);
% x(2) = y_out(2);
% d2 = y_out(3);
% d3 = y_out(4);
% d4 = y_out(5);
% d5 = y_out(6);

%SRD-LS algorithm
B = [-2*x2.' -2*r_12;
    -2*x3.' -2*r_13;
    -2*x4.' -2*r_14;
    -2*x5.' -2*r_15;
];

C = [1 0 0 0;
    0 1 0 0;
    0 0 1 0;
    0 0 0 -1;  
];

g = [r_12^2-norm(x2)^2;
    r_13^2-norm(x3)^2;
    r_14^2-norm(x4)^2;
    r_15^2-norm(x5)^2;
];

y = 


t = 1/Fs*(0:1:length(y)-1);

subplot(5,1,1)
plot(t,h1,'DisplayName', 'Channel estimation of mic 1')
X1 = xline(t(firstpeak_1),'--r','DisplayName','Peak in channel estimation of mic 1');
% legend('show');

subplot(5,1,2)
plot(t,h2,'DisplayName', 'Channel estimation of mic 2')
X2 = xline(t(firstpeak_2),'--r','DisplayName','Peak in channel estimation of mic 2');
% legend('show');

subplot(5,1,3)
plot(t,h3,'DisplayName', 'Channel estimation of mic 3')
X3 = xline(t(firstpeak_3),'--r','DisplayName','Peak in channel estimation of mic 3');
% legend('show');

subplot(5,1,4)
plot(t,h4,'DisplayName', 'Channel estimation of mic 4')
X4 = xline(t(firstpeak_4),'--r','DisplayName','Peak in channel estimation of mic 4');
% legend('show');

subplot(5,1,5)
plot(t,h5,'DisplayName', 'Channel estimation of mic 5')
X5 = xline(t(firstpeak_5),'--r','DisplayName','Peak in channel estimation of mic 5');
% legend('show');