function output = WhiteSpace(I) 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Test if the masked source image is white space to prevent crashes through
% Macenko's normalization process
%
% Input:
% I            - input masked source image
% 
% Output:
% output       - logical value: 1 if it is a white space; 0 if it is not. 
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

% set initial values
output = 0;
Io = 255;
beta = 0.15; 

I = reshape(double(I), [], 3);

% calculate optical density
OD = -log((I+1)/Io);

% remove transparent pixels
ODhat = OD(~any(OD < beta, 2), :);

% take the covariance matrix
COV = cov(ODhat);

% test if it contains NaN values
y1 = isnan(COV);

% test if it contains Inf values
y2 = isinf(COV);

if (y1 == 1)
    output = 1;
end    

if (y2 == 1)
    output = 1;
end   

end    