function [B, W] = whitespixelcount(MS)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% White pixel count 
%
% Input:
% MS             - binary mask
% 
% Output:
% B              - black pixel ratio
% W              - white pixel ratio 
% 
% Runyu Hong
% 
% David Fenyo Lab
% Institute for Systems Genetics
% New York University School of Medicine 
% NYU Langone Health
% 09/21/2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Total number of pixel
nTotal = numel(MS);
% Number of white pixel
nWhite = sum(MS(:));
% Number of black pixel
nBlack = nTotal - nWhite;
% Black pixel ratio
B = nBlack / nTotal;
% White pixel ratio
W = nWhite / nTotal; 
end