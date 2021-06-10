%Authors: Ruben Eland and Pieter Gommers

function peak = firstPeak(x, threshold)
    [pks,locs] = findpeaks(abs(x));
    allpeaks = find(pks>threshold*max(x));
    peak = locs(allpeaks(1));
end

% peakdistance & peakheight enzo