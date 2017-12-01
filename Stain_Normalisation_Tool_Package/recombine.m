function [final] = recombine(normalized, bg, X, Y, W, H)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Assemble normalized ROI to masked source image
%
% Input:
% normalized       - normalized ROI 
% bg               - masked source image
% X                - ROI start X pixel position
% Y                - ROI start Y pixel position
% W                - Width of ROI in pixel
% H                - Height of ROI in pixel
%
% Output:
% final            - Assemble normalized ROI to masked source image
% 
% Runyu Hong
% 
% David Fenyo Lab
% Institute for Systems Genetics
% New York University School of Medicine 
% NYU Langone Health
% 09/21/2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
temp = bg;
% Get size of masked source image in pixel
sz1 = size(temp);
y1 = sz1(1);
x1 = sz1(2);
% Allign and assemble ROI to appropriate position on the maksed source 
% image
% If ROI size exceed the masked source image in any dimension, make sure 
% the assembled image has the same size as the original masked source image
if (Y+H > y1 && X+W <= x1)
    temp(Y:Y+H-1, X:X+W, :) = normalized;    
    final = temp;
elseif (Y+H <= y1 && X+W > x1)
    temp(Y:Y+H, X:X+W-1, :) = normalized;    
    final = temp;
elseif (Y+H > y1 && X+W > x1)
    temp(Y:Y+H-1, X:X+W-1, :) = normalized;    
    final = temp;
else
    temp(Y:Y+H, X:X+W, :) = normalized;
    final = temp;
end
end