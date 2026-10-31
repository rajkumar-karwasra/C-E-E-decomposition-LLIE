clc;
clear;
close all;

imagePath = "D:\paper3 algo\proposed3\dataset2\D13.jpg";

%%  WASSERSTEIN-2 PREPROCESSING

w2OutputFile = 'W2_Preprocessed.png';
tic; 
[RGB,~,W2,W2_squared] = wassersteinOT(imagePath);

fprintf('\nWasserstein-2 preprocessing completed.\n');

%% RGB -> LAB

LAB = rgb2lab(RGB);

L = LAB(:,:,1) ./ 100;
L = min(max(L,0),1);

[H,W] = size(L);

params.sigma1 = 2;
params.sigma3 = 20;
params.cGainMin = 1.00;
params.cGainMax = 1.20;
params.tauC     = 0.05;
params.wMin = 0.70;
params.tauR = 0.05;
alpha = 0.009;
%% C-E-R DECOMPOSITION

E = estimateExposure(L,params);
C = estimateContent(L,params);
R = estimateResidual(L,params);

%% EXPOSURE ENHANCEMENT

E_enhanced = enhanceExposure(E);

%% ADAPTIVE CONTENT ENHANCEMENT

[C_enhanced,W_C,~] = enhanceContentAdaptive(L,C,params);

%%  ADAPTIVE RESIDUAL ENHANCEMENT

[R_enhanced,W_R,~] = enhanceResidualAdaptive(L,R,params);

%% ENHANCED L* RECONSTRUCTION

L_enhanced = E_enhanced + C_enhanced + R_enhanced;

L_enhanced = min(max(L_enhanced,0),1);

%% LAB -> RGB

LAB_enhanced = LAB;
LAB_enhanced(:,:,1) = 100 * L_enhanced;

RGB_enhanced = lab2rgb(LAB_enhanced);
RGB_enhanced = min(max(RGB_enhanced,0),1);

RGB_corrected = applyNCC(RGB_enhanced,alpha);
figure, imshow(imagePath);
figure, imshow(RGB_corrected);

toc;
outputFile = 'finalD14.png';

%imwrite(RGB_corrected,outputFile);