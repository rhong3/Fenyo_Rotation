%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Histology image stain normalisation using Reinhard's Method with the
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
TargetImage = imread('Images/2.tif');
di = dir('Samples/*.tif'); 
  for k= 1:length(di) 
      mkdir ('Samples/new/', di(k).name);
      SourceImage = imread(['Samples/', di(k).name]);
      % Save a copy of source image 
      copyfile (['Samples/', di(k).name], ['Samples/new/', di(k).name]);
      % Stain Normalisation using Reinhard's Method
      disp('Stain Normalisation using Reinhard''s Method');
    try
      % apply mask to source image and save a copy of masked source image  
      [ Mask, MaskedSourceImage, default ] = Maskbeta (SourceImage); 
%       imwrite( default,['Samples/new/', di(k).name, '/default_', di(k).name]);
      % normalization using Reinhard's method and save a copy of raw
      % normalized image
      [ NormRH ] = Norm(default, TargetImage, 'Reinhard');
%       imwrite( NormRH,['Samples/new/', di(k).name, '/RH_UM_', di(k).name]);
      % remask the raw normalized image with the same mask to generate
      % and save the finally normalized image
      [ MaskedNormRH ] = remask (NormRH, Mask); 
      imwrite( MaskedNormRH,['Samples/new/', di(k).name, '/RH_', di(k).name]);
    % catch any runtime errors and print out the failed file names  
    catch ME
        disp([di(k).name '_failed']);
        continue;
    end    
  end