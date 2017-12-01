function [ MMUM ] = MMdetROI(default, mask, target, dirname)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Stain normalization of deteted ROI using Macenko's Method
%
% Input:
% default          - masked source image
% mask             - binary mask
% target           - normalization target image
% dirname          - name of source image
%
% Output:
% MMUM             - unmasked normalized image
% 
% Runyu Hong
% 
% David Fenyo Lab
% Institute for Systems Genetics
% New York University School of Medicine 
% NYU Langone Health
% 09/21/2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    

% Generate ROI
[bbox, range] = ROI(mask);
if (range ~= 0)
    % Normalize all detected ROI and reassemble them to masked source image
    for i = 1:range
        % Get dimention of ROI 
        L = bbox (i, :);
        % Crop the ROI from the masked source image
        CRP = imcrop(default, L);
        % Normalize ROI using Macenko's method
        [ NormMM_CRP ] = Norm(CRP, target, 'Macenko', 255, 0.15, 1);
        % Allign spatial coordinate to pixel coordinate and save dimentions
        % ROI start X pixel position
        X = L(1) + 0.5;
        % ROI start Y pixel position
        Y = L(2) + 0.5;
        % Width of ROI in pixel
        W = L(3);
        % Height of ROI in pixel
        H = L(4);
%         % (optional) ROI number
%         j = num2str(i);
%         % (optional) Save normalized ROI as a file
%         imwrite( NormMM_CRP,['Samples/Norm/CRP_', j, '_', dirname]);
        % Check if the ROI is yellow or blue (caused by dirt not sample)
        BWY = YellowMask(NormMM_CRP);
        BWB = BlueMask(NormMM_CRP);
        [ A, ~ ] = whitespixelcount(BWY);
        [ B, ~ ] = whitespixelcount(BWB);
        % If the ROI pass the dirt check, it will be assembled
        if ( A < 0.1 && B < 0.1)
            % Assemble normalized ROI to masked source image
            [ default ] = recombine(NormMM_CRP, default, X, Y, W, H);
        end    
    end
end    

% If no ROI detected, use input masked source image as output; if ROI detected,
% use assembled new masked source image as output
MMUM = default;

end