% Group A5 - EPO4 2021
% Authors: Ruben Eland & Pieter Gommers
% Description:
% This function removes the starting and ending samples of the original
% signal y where these are under a certain silence threshold. This way it
% only returns the nonsilent samples of the signal, whilst not removing
% intended silences between nonsilent parts of the signal.

function [t_start,t_end,y_nosilence] = RemoveSilence(y,threshold)
    
    % Find() samples that have amplitudes larger than the threshold
    nonsilent_samples = find(y>threshold, 1, 'first'):find(y>threshold, 1, 'last');
    t_start=nonsilent_samples(1);
    t_end=nonsilent_samples(end);
    % Only keep the signal between the first and last sample
    y_nosilence= y( t_start: t_end);
    
end

