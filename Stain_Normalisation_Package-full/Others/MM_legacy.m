%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Histology image stain normalisation using Macento's Method with the
% Toolkit created by University of Warwick Department of Computer Science
% 
% Runyu Hong
% 
% David Fenyo Lab
% Institute for Systems Genetics
% New York University School of Medicine 
% NYU Langone Health
% 09/15/2017
% 
%
% Installation script for the Stain Normalisation Toolbox was created by
% Nicholas Trahearn
% Department of Computer Science, 
% University of Warwick, UK.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Installation Scripts
% Add this folder to the Matlab path.
functionDir = mfilename('fullpath');
functionDir = functionDir(1:(end-length(mfilename)));

addpath(genpath(functionDir));

% Set up colour deconvolution C code.
mex colour_deconvolution.c;

clear functionDir;

%% Clear all previous data
clc, clear all, close all;

%% Main Loop
% read in target and source images
TargetImage = imread('Images/1.tif');
di = dir('Samples/*.tif'); 
  for k= 1:length(di) 
      mkdir ('Samples/new/', di(k).name);
      SourceImage = imread(['Samples/', di(k).name]);
      % Save a copy of source image 
      copyfile (['Samples/', di(k).name], ['Samples/new/', di(k).name]);
      % Stain Normalisation using Macenko's Method
      disp('Stain Normalisation using Macenko''s Method');
    try
      % apply mask to source image and save a copy of masked source image  
      [ Mask, MaskedSourceImage, default ] = Maskbeta (SourceImage); 
%       imwrite( default,['Samples/new/', di(k).name, '/default_', di(k).name]);
      % white space crash check
      Z = WhiteSpace(SourceImage);
      % if the masked source image is purely white, then skip normalization
      % method and save masked source image as outputs
      if (Z == 1)
          [ NormMM ] = default;
%           imwrite( NormMM,['Samples/new/', di(k).name, '/MM_UM_', di(k).name]);
          [ MaskedNormMM ] = default; 
          imwrite( MaskedNormMM,['Samples/new/', di(k).name, '/MM_', di(k).name]);    
      else  
          % normalization using Macenko's method and save a copy of raw
          % normalized image
          [ NormMM ] = Norm(default, TargetImage, 'Macenko', 255, 0.15, 1);
%           imwrite( NormMM,['Samples/new/', di(k).name, '/MM_UM_', di(k).name]);
          % remask the raw normalized image with the same mask to generate
          % and save the finally normalized image
          [ MaskedNormMM ] = remask (NormMM, Mask); 
          imwrite( MaskedNormMM,['Samples/new/', di(k).name, '/MM_', di(k).name]);
      end
    % catch any runtime errors and print out the failed file names  
    catch ME
        disp([di(k).name '_failed']);
        continue;
    end    
  end