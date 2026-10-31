function RGB_corrected = applyNCC(input_img, alpha)


if nargin < 2
    error('applyNCC requires two inputs: input_img and alpha.');
end

if ndims(input_img) ~= 3 || size(input_img,3) ~= 3
    error('Input image must be an RGB image.');
end


% CONVERT TO DOUBLE


input_img = im2double(input_img);

input_img = min(max(input_img,0),1);


% RGB CHANNELS


R_channel = input_img(:,:,1);

G_channel = input_img(:,:,2);

B_channel = input_img(:,:,3);


% NCC

NCC = 0.299*R_channel +0.587*G_channel + 0.114*B_channel- max(input_img,[],3)+ min(input_img,[],3);


% CONTROLLED NCC CORRECTION

RGB_corrected =input_img + alpha*NCC;


RGB_corrected = min(max(RGB_corrected,0),1);

end