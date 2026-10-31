function [I_W2,Y_W2,W2,W2_squared] = wassersteinOT(inputImage)

I_rgb = im2double(imread(inputImage));

if size(I_rgb,3) == 1
    I_rgb = repmat(I_rgb,[1 1 3]);
end

I_rgb = min(max(I_rgb,0),1);

%%  RGB -> LUMINANCE

Y = rgb2gray(I_rgb);
Y = im2double(Y);
Y = min(max(Y,0),1);

%%  ADAPTIVE TARGET

muY  = mean(Y(:));
stdY = std(Y(:));

targetLocation =  0.50 + 0.15*(0.35 - muY);

targetLocation =  min(max(targetLocation,0.45),0.65);

targetScale = max(stdY,0.18);

%% TRUNCATED NORMAL TARGET

mu    = targetLocation;
sigma = targetScale;

alpha = (0-mu)/sigma;
beta  = (1-mu)/sigma;

PhiAlpha = 0.5*(1+erf(alpha/sqrt(2)));

PhiBeta = 0.5*(1+erf(beta/sqrt(2)));

%%  SOURCE EMPIRICAL DISTRIBUTION

source = Y(:);
N = numel(source);

sourceSorted = sort(source);

q = ((1:N)'-0.5)/N;

%%  TARGET QUANTILES

targetProbability =  PhiAlpha + q*(PhiBeta-PhiAlpha);

targetProbability =  min(max(targetProbability,eps),1-eps);

targetQuantile = mu + sigma*sqrt(2)* erfinv(2*targetProbability-1);

targetQuantile = min(max(targetQuantile,0),1);

%% WASSERSTEIN-2 DISTANCE

quantileDifference = sourceSorted - targetQuantile;

W2_squared = mean(quantileDifference.^2);

W2 = sqrt(W2_squared);

%%  OPTIMAL TRANSPORT MAPPING

[~,sourceIndex] = sort(source);

Y_W2_vector = zeros(N,1);

Y_W2_vector(sourceIndex) = targetQuantile;

Y_W2 = reshape(Y_W2_vector,size(Y));

%%  RGB RECONSTRUCTION

R = I_rgb(:,:,1);
G = I_rgb(:,:,2);
B = I_rgb(:,:,3);

epsilon = 1e-6;

gain = Y_W2 ./ max(Y,epsilon);

% Limit amplification in extremely dark pixels
gain = min(gain,4);

R_W2 = R .* gain;
G_W2 = G .* gain;
B_W2 = B .* gain;

I_W2 = cat(3,R_W2,G_W2,B_W2);

I_W2 = min(max(I_W2,0),1);
end
