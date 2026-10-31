function [R_enhanced,W_R,gradientMagnitude] = enhanceResidualAdaptive(L,R,params)


% Convert inputs to double
L = double(L);
R = double(R);

% Get parameters
if isfield(params,'wMin')
    wMin = params.wMin;
else
    wMin = 0.70;
end

if isfield(params,'tauR')
    tauR = params.tauR;
else
    tauR = 0.05;
end

% Constrain parameters
wMin = min(max(wMin,0),1);
tauR = max(tauR,eps);

% Estimate gradient using Sobel operator
[Gx,Gy] = imgradientxy(L,'sobel');

gradientMagnitude = sqrt(Gx.^2 + Gy.^2);

% Normalize gradient
gradientMagnitude =gradientMagnitude ./ (max(gradientMagnitude(:)) + eps);

% Compute adaptive residual weight
W_R =  wMin +(1-wMin) .*(gradientMagnitude ./(gradientMagnitude + tauR));

% Enhance residual
R_enhanced = W_R .* R;

end
