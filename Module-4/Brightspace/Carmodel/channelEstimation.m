%Authors: Ruben Eland and Pieter Gommers

function h = channelEstimation(x, y, eps)
    Ny = length(y);     %length of recorded signal
    Nx = length(x);     %length of reference signal 
    L = Ny - Nx +1;
    Y = fft(y);         %fft to get y in frequendy domain
    X = fft([x; zeros(Ny - Nx,1)]); %fft to get x in frequency domain
    ii = find(abs(X) > eps*max(abs(X))); %assuring the noise is filtered out

    for n = 1:length(X)
        for i = 1:length(ii)
            if n == ii(i)
                G(n)=1;
                break
            else
                G(n)=0;
            end
        end
    end
    G=G(:);
    H = Y./X;
    H = G.*H;
    h = ifftshift(ifft(H));
end