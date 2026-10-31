function E = estimateExposure(L,params)

% Convert input to double
L = double(L);

% Get Gaussian parameter
if isfield(params,'sigma3')
    sigma3 = params.sigma3;
else
    sigma3 = 20;
end

% Very-low-frequency exposure component
E = imgaussfilt(L,sigma3);

% Keep exposure within the normalized range
E = min(max(E,0),1);

end
