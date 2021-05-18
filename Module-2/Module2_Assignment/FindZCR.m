% Group A5 - EPO4 2021
% Authors: Ruben Eland & Pieter Gommers
% Description:
% This function calculats the zero crossing rate of a signal

function y = ZCR(x)
    y = sum(abs(diff(x>0)))/length(x);
end