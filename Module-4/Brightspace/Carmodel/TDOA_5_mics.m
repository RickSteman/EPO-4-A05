%Authors: Ruben Eland and Pieter Gommers
%Date: June 2021

eps = 0.1;
Fs = 40000;

%Recording and estimating the 5-channel data

y = datagen();
x = refsignal_new(15000,5000,2500,'E04869A5',Fs);

h1 = channelEstimation(x,y(:,1),eps);
h2 = channelEstimation(x,y(:,2),eps);
h3 = channelEstimation(x,y(:,3),eps);
h4 = channelEstimation(x,y(:,4),eps);

t = 1/Fs*(0:1:length(y)-1);

%Implementation of localization algorithm from Appendix B.1

firstpeak_1 = firstPeak(h1, 0.7);
firstpeak_2 = firstPeak(h2, 0.7);
firstpeak_3 = firstPeak(h3, 0.7);
firstpeak_4 = firstPeak(h4, 0.7);

n_delay_12 = abs(firstpeak_1 - firstpeak_2);
t_delay_12 = (1/Fs)*(n_delay_12);
r_12 = t_delay_12*34326;

n_delay_13 = abs(firstpeak_1 - firstpeak_3);
t_delay_13 = (1/Fs)*(n_delay_13);
r_13 = t_delay_13*34326;

n_delay_14 = abs(firstpeak_1 - firstpeak_4);
t_delay_14 = (1/Fs)*(n_delay_14);
r_14 = t_delay_14*34326;

n_delay_23 = abs(firstpeak_2 - firstpeak_3);
t_delay_23 = (1/Fs)*(n_delay_23);
r_23 = t_delay_23*34326;

n_delay_24 = abs(firstpeak_2 - firstpeak_3);
t_delay_24 = (1/Fs)*(n_delay_23);
r_24 = t_delay_24*34326;

n_delay_34 = abs(firstpeak_3 - firstpeak_4);
t_delay_34 = (1/Fs)*(n_delay_34);
r_34 = t_delay_34*34326;

%positions of the mics

x1 = [0; 0];
x2 = [600; 0];
x3 = [0; 600];
x4 = [600; 600];

A = [2*((x2-x1).') -2*r_12 0 0;
    2*((x3-x1).') 0 -2*r_13 0;
    2*((x4-x1).') 0 0 -2*r_14;
    2*((x3-x2).') 0 -2*r_23 0;
    2*((x4-x2).') 0 0 -2*r_24;
    2*((x4-x3).') 0 0 -2*r_34];

b = [r_12^2-(norm(x1))^2+(norm(x2))^2;
    r_13^2-(norm(x1))^2+(norm(x3))^2;
    r_14^2-(norm(x1))^2+(norm(x4))^2;
    r_23^2-(norm(x2))^2+(norm(x3))^2;
    r_24^2-(norm(x2))^2+(norm(x4))^2;
    r_34^2-(norm(x3))^2+(norm(x4))^2];

A_t = inv((A.')*A);
y = (A_t.')*(A.')*b;

x = zeros(2,1);

x(1) = y(1);
x(2) = y(2);
d2 = y(3);
d3 = y(4);
d4 = y(5);
