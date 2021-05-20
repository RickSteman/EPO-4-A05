%Authors: Ruben Eland and Pieter Gommers

function h = channelEstimation(x, y, eps)
    Ny = length(y); 
    Nx = length(x); 
    L = Ny - Nx +1;
    Y = fft(y);
    X = fft([x; zeros(Ny - Nx,1)]);  
    ii = find(abs(X) > eps*abs(X));

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