function [ remaskedimage ] = remask ( RGB, BW ) 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Remask the normalized images with the same mask created before
%
% Input:
% RGB            - input normalized image
% BW             - mask created before
% 
% Output:
% remaskedimage  - remasked normalized image with the mask created before
%
% 
% Runyu Hong
% 
% David Fenyo Lab
% Institute for Systems Genetics
% New York University School of Medicine 
% NYU Langone Health
% 09/15/2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
maskedRGBImage = RGB;
% Set background pixels where BW is false to 255.
maskedRGBImage(repmat(~BW,[1 1 3])) = 255;

remaskedimage = maskedRGBImage;

end