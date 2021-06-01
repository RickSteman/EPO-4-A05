[pks,locs] = findpeaks(abs(h2));
gev = find(pks>0.7*peak2);
first = locs(gev(1));