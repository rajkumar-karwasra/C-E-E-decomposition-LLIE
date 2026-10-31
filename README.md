**Overview**
This MATLAB project implements a low-light image enhancement framework combining Wasserstein-2 (W2) optimal transport preprocessing with LAB-based Content–Exposure–Residual (C-E-R) decomposition.

**Methodology**
The proposed pipeline consists of the following stages:
1. W2 Preprocessing: Enhances luminance distribution using Wasserstein-2 optimal transport.
2. C-E-R Decomposition: Decomposes the LAB L* channel into Content (C), Exposure (E), and Residual (R) components using Gaussian filtering.
3. Exposure Enhancement: Applies adaptive gamma correction to improve image brightness.
4. Content Enhancement: Uses gradient-guided adaptive weighting to enhance structural information.
5. Residual Enhancement: Applies adaptive gradient-based weighting to enhance fine details.
6. Reconstruction: Combines the enhanced components and performs final NCC-based color correction.
   
**Requirements**
- MATLAB
- Image Processing Toolbox

**How to Run**
1. Extract the project folder.
2. Open MATLAB and set the project directory as the current folder.
3. Update the input image path in main.m.
4. Run main.m to obtain the enhanced image.

**Project Structure**
- main.m – Main enhancement pipeline.
- wassersteinOT.m – W2 optimal transport preprocessing.
- estimateExposure.m – Exposure estimation.
- estimateContent.m – Content estimation.
- estimateResidual.m – Residual estimation.
- enhanceExposure.m – Adaptive exposure enhancement.
- enhanceContentAdaptive.m – Adaptive content enhancement.
- enhanceResidualAdaptive.m – Adaptive residual enhancement.
- applyNCC.m – Final color correction.
  
**Output**
The framework produces an enhanced RGB image with improved brightness, structural details, and visual quality.
