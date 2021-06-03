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

Grid = zeros(20,20);

for i=0:19
    for j=0:19
        Grid(i) = 2.5*i
    end
end

