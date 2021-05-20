function [distance] = TDOA(y1, y2, Fs)

peak1 = max(y1);                %peak value in the plot of h_y1
peak1_loc = find(y1==peak1);    %peak location in the plot of h_y1
search_interval = 600;          % Maximal expected delay 0.015s/Fs

peak2 = max(y2(peak1_loc-search_interval:peak1_loc + search_interval)); 
                                %Looking for peak in search window
peak2_loc = find(y2(peak1_loc-search_interval:peak1_loc+search_interval)
        == peak2)+peak1_loc - search_interval; %Peak location of h_y2

delay_samples = peak2_loc - peak1_loc; %Finding amount of samples between peaks
delay_time = delay_samples/Fs;  %Finding delay in time between peaks
distance = delay_time*343;      %Calculating distance between microphones 
                                %(343m/s is speed of sound in air)
end