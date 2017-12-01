function [bbox, range] = ROI(bg)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Stain Normalization ROI Detection
%
% Input:
% bg             - binary mask
% 
% Output:
% bbox           - dimensions of all ROI detected
% range          - total number of ROI detected 
% 
% Runyu Hong
% 
% David Fenyo Lab
% Institute for Systems Genetics
% New York University School of Medicine 
% NYU Langone Health
% 09/21/2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Ignore objects less than 50000 pixels as ROI candidates
foreground = bwareaopen(bg, 50000);
% ROI detection
labeledImage = logical(foreground);
% Bounding box structure array containing detected ROI dimensions
bb = regionprops(labeledImage, 'BoundingBox');
% Total number of ROI detected
range = numel(bb);
% If no ROI detected, set an all 0 bbox
if (range == 0)
    bbox = zeros(1,4);
% Get ROI dimensions and store them in bbox
else
    bbox = zeros(range, 4);
    for i = 1 : range
        % Get the i'th bounding box and copy it to bbox
        bbox(i, :) = bb(i).BoundingBox;
    end
end
end