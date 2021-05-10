% Group A5 - EPO4 2021
% Authors: Ruben Eland & Pieter Gommers
% Description:
% This function finds the pitch (fundamental frequency) for a given input y.

function f0= FindPitch(y,Fs,L,ov)
    f0 = pitch(y, Fs, 'WindowLength', L, 'OverlapLength', ov, 'Method', 'CEP');
end