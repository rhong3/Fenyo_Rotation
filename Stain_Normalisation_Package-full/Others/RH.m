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
% 09/21/2017
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
% Job number counter
job = 1;
  for k= 1:length(di)
      % Make new folder to contain images
      mkdir ('Samples/new/', di(k).name);
      % Read in source files
      SourceImage = imread(['Samples/', di(k).name]);
      % Save a copy of source image 
      copyfile (['Samples/', di(k).name], ['Samples/new/', di(k).name]);
      % Stain Normalisation using Reinhard's Method in progress message
      num = num2str(job);
      note1 = '--Stain Normalisation using Reinhard''s Method.';
      note2 = 'Now running job #';
      disp([note2, num, note1]);
%     try 
      % White space crash check
      Z = WhiteSpace(SourceImage);
      % Apply mask to source image 
      [ Mask, default] = Maskbeta(SourceImage);
      % If the masked source image is purely white, then skip normalization
      % method and save masked source image as outputs
      if (Z == 1)
          % Show that this is a white space image
          disp(['***', di(k).name, ' is white space.***']); 
          % Save the masked white space image as output
          imwrite( default,['Samples/new/', di(k).name, '/RH_WS_', di(k).name]);    
      else
          % Grey space check; Images contain less than 0.2% of sample are 
          % considered to be grey space image 
          [~, Wh] = whitespixelcount(Mask);
          if ( 0.002 <= Wh )
              % Normalization using Macenko's method to specified ROI
              [ NormRH ] = RHdetROI(default, Mask, TargetImage, di(k).name);  
              % Remask the raw normalized image with the same mask to generate
              % and save the finally normalized image
              [ MaskedNormRH ] = remask (NormRH, Mask); 
              imwrite( MaskedNormRH,['Samples/new/', di(k).name, '/RH_', di(k).name]);
          else 
              % Show that this is a grey space image
              disp(['***', di(k).name, ' is grey space.***']);   
              % Save the normalized grey space image as output
              imwrite( default,['Samples/new/', di(k).name, '/RH_GS_', di(k).name]);
          end    
      end
      % Job number counter
      job = job + 1;
    % Catch any runtime errors and print out the failed file names  
%     catch ME
%         disp([di(k).name '_failed']);
%     end 
  end
% Job summary message   
disp(['All done! ', num,' Jobs completed! ']);  
