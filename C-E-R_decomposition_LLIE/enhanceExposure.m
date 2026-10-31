function E_enhanced = enhanceExposure(E)


E = double(E);
E = min(max(E,0),1);

meanE = mean(E(:));

if meanE < 0.20

    gamma = 0.40;

elseif meanE < 0.30

    gamma = 0.50;

elseif meanE < 0.40

    gamma = 0.60;

elseif meanE < 0.50

    gamma = 0.70;

else

    gamma = 0.90;

end

% Apply adaptive gamma correction
E_enhanced = E.^gamma;

% Keep exposure within valid range
E_enhanced = min(max(E_enhanced,0),1);

end
