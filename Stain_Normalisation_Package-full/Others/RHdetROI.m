function [ RHUM ] = RHdetROI(default, mask, target, dirname)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Stain normalization of deteted ROI using Reinhard's Method
%
% Input:
% default          - masked source image
% mask             - binary mask
% target           - normalization target image
% dirname          - name of source image
%
% Output:
% RHUM             - unmasked normalized image
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
        % Make a mask for ROI
        [ mask2, ~ ] = Maskbeta(CRP);
        % Normalize ROI using Macenko's method
        [ NormRH_CRP ] = Norm(CRP, target, 'Reinhard');
        % Remask normalized ROI
        [ NormRH_CRP ] = remask(NormRH_CRP, mask2);
        % Allign spatial coordinate to pixel coordinate and save dimentions
        % ROI start X pixel position
        X = L(1) + 0.5;
        % ROI start Y pixel position
        Y = L(2) + 0.5;
        % Width of ROI in pixel
        W = L(3);
        % Height of ROI in pixel
        H = L(4);
        % ROI number
        j = num2str(i);
        % Save normalized ROI as a file
        imwrite( NormRH_CRP,['Samples/new/', dirname, '/RH_CRP_', j, '_', dirname]);
        % Assemble normalized ROI to masked source image
        [ default ] = recombine(NormRH_CRP, default, X, Y, W, H);
    end
end    

% If no ROI detected, use input masked source image as output; if ROI detected,
% use assembled new masked source image as output
RHUM = default;

end