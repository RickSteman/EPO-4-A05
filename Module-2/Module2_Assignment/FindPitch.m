function f0= FindPitch(y,Fs,L,ov)
    f0 = pitch(y, Fs, 'WindowLength', L, 'OverlapLength', ov, 'Method', 'CEP');
end