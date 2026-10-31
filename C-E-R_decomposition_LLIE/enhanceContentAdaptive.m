function [C_enhanced,W_C,G] = enhanceContentAdaptive(L,C,params)

L = double(L);
C = double(C);

% Compute image gradient
[Gx,Gy] = gradient(L);
G = sqrt(Gx.^2 + Gy.^2);

% Normalize gradient
Gmax = max(G(:));

if Gmax > eps
    G = G ./ Gmax;
else
    G = zeros(size(G));
end

% Compute adaptive content gain
W_C = params.cGainMin +(params.cGainMax - params.cGainMin) .* G ./ (G + params.tauC);

% Enhance content
C_enhanced = W_C .* C;

end
