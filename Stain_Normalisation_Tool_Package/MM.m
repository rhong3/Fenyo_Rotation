%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Histology image stain normalisation using Macenko's Method with the
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
% Make a new folder to contain outputs
mkdir ('Samples/Norm/');
% Generate report; using diary on/off to record useful info for the report
diary Samples/Norm/Report.txt;
diary on;
% Welcome message
fprintf('\n   Welcome! \n   Stain Normalisation Using Macenko''s Method 1.1.0 \n');
% Read in target and source images
diary off;
TargetImage = imread('Images/2.tif');
di = dir('Samples/*.tif'); 
% Job number counter
job = 1;
  for k= 1:length(di)
      % Read in source files
      SourceImage = imread(['Samples/', di(k).name]);
      % Stain Normalisation using Macenko's Method in progress message
      num = num2str(job);
      note1 = 'Job_#';
      note2 = 'Running '; 
      fprintf(['\n \n', note2, note1, num, '\n']);
%       % (optional) Save a copy of source image 
%       copyfile (['Samples/', di(k).name], ['Samples/Norm/', note1, num, '-Ori_', di(k).name]);
    try 
      % White space crash check
      Z = WhiteSpace(SourceImage);
      % Apply mask to source image 
      [ Mask, default] = Maskbeta(SourceImage);
      % If the masked source image is purely white, then skip normalization
      % method and save masked source image as outputs
      if (Z == 1)
          diary on;
          % Show that this is a white space image
          disp(['***', note1, num, '  ', di(k).name, ' is white space.***']);
          diary off;
          % Save the masked white space image as output
          imwrite( default,['Samples/Norm/', note1, num, '-WS_', di(k).name]);    
      else
          % Grey space check; Images contain less than 0.1% of sample are 
          % considered to be grey space image 
          [~, Wh] = whitespixelcount(Mask);
          if ( 0.001 <= Wh )
              diary on;
              % Show that this is a normal image
              disp(['***', note1, num, '  ', di(k).name, ' is normal.***']);
              diary off;
              % Set directory name to be consistent
              dirname = [note1, num, '-', di(k).name];
              % Normalization using Macenko's method to specified ROI
              [ NormMM ] = MMdetROI(default, Mask, TargetImage, dirname);  
              % Remask the raw normalized image with the same mask to generate
              % and save the finally normalized image
              [ MaskedNormMM ] = remask (NormMM, Mask); 
              imwrite( MaskedNormMM,['Samples/Norm/', note1, num, '-', di(k).name]);
          else 
              diary on;
              % Show that this is a grey space image
              disp(['***', note1, num, '  ', di(k).name, ' is grey space.***']); 
              diary off;
              % Save the normalized grey space image as output
              imwrite( default,['Samples/Norm/', note1, num, '-GS_', di(k).name]);
          end    
      end
      fprintf([note1, num, ' is completed.']);
      % Job number counter
      job = job + 1;
    % Catch any runtime errors and print out the failed file names and job numbers  
    catch ME
        diary on;
        disp(['***', note1, num, '  ', di(k).name ' failed.***']);
        diary off;
    end 
  end
diary on;  
% Job summary message   
fprintf(['\n \n All done! ', num,' jobs completed! ']);  
diary off;

