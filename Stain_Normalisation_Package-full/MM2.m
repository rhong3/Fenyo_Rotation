%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Installation script for the Stain Normalisation Toolbox
%
%
% Nicholas Trahearn
% Department of Computer Science, 
% University of Warwick, UK.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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
TargetImage = imread('Images/Ref.png');
di = dir('Samples/*.tif'); 
% try 
  disp(['Stain Separation using an Image specific Stain matrix '...
      'estimated using Macenko''s method']);

      MacenkoMatrix = EstUsingMacenko( TargetImage );

      [ DCh1, M1 ] = Deconvolve2( TargetImage, MacenkoMatrix);
      [ H1, E1, Bg1 ] = PseudoColourStains(DCh1, M1);
% catch WE
%     disp('target_separation_failed');
% end    
  for k= 1:length(di)  
%       mkdir ('Samples/new/', di(k).name);
      SourceImage = imread('Images/1.tif');
%       copyfile (['Images/', di(k).name], ['Samples/new/', di(k).name]);
      
%     try
      % Stain Separation using Macenko's Image specific Stain Matrix for H&E 

      disp(['Stain Separation using an Image specific Stain matrix '...
      'estimated using Macenko''s method']);

      MacenkoMatrix = EstUsingMacenko( SourceImage );

      [ DCh, M ] = Deconvolve2( SourceImage, MacenkoMatrix);
      [ H, E, Bg ] = PseudoColourStains(DCh, M);
      figure,
      imshow(H);
      imwrite(H, 'Samples/new/H.tif');
      figure,
      imshow(E);
      imwrite(E, 'Samples/new/E.tif');
      % Stain Normalisation using Macenko's Method
%       disp('Stain Normalisation using Macenko''s Method');
%       [ NormMMH ] = Norm(H, H1, 'Macenko', 255, 0.15, 1);
%       imwrite( NormMMH,['Samples/new/', di(k).name, '/MMH_', di(k).name]);
%       [ NormMME ] = Norm(E, E1, 'Macenko', 255, 0.15, 1);
%       imwrite( NormMME,['Samples/new/', di(k).name, '/MME_', di(k).name]);
% %       [ NormMMBg ] = Norm(Bg, Bg1, 'Macenko', 255, 0.15, 1);
% %       imwrite( NormMMBg,['Samples/new/', di(k).name, '/MMBg_', di(k).name]);
%       X = imfuse (NormMMH, NormMME);
%       NormMM = imfuse (X, Bg);
%       imwrite( NormMM,['Samples/new/', di(k).name, '/MM_', di(k).name]);
% %     catch ME
% %         disp([di(k).name '_failed']);
% %         continue;
% %     end    
  end