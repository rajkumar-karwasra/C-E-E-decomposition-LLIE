function R = estimateResidual(L,params)
% Convert input to double
L = double(L);

% Get Gaussian parameter
if isfield(params,'sigma1')
    sigma1 = params.sigma1;
else
    sigma1 = 2;
end

% Low-pass representation
G1 = imgaussfilt(L,sigma1);

% Finest-frequency component
R = L - G1;

end
