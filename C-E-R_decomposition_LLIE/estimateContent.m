function C = estimateContent(L,params)


L = double(L);

% Get Gaussian parameters
if isfield(params,'sigma1')
    sigma1 = params.sigma1;
else
    sigma1 = 2;
end

if isfield(params,'sigma3')
    sigma3 = params.sigma3;
else
    sigma3 = 20;
end

% Gaussian representations
G1 = imgaussfilt(L,sigma1);
G3 = imgaussfilt(L,sigma3);

% Intermediate-frequency content
C = G1 - G3;

end
