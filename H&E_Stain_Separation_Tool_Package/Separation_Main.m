%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Histology image H&E stain separation using Macenko's Method with the
% Toolkit created by University of Warwick Department of Computer Science
% 
% Runyu Hong
% 
% David Fenyo Lab
% Institute for Systems Genetics
% New York University School of Medicine 
% NYU Langone Health
% 10/04/2017
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
mkdir ('Samples/Separation');
% Generate report; using diary on/off to record useful info for the report
diary Samples/Separation/Report.txt;
diary on;
% Welcome message
fprintf('\n   Welcome! \n   H&E Stain Separation Using Macenko''s Method 1.0.0 \n');
diary off;
% Read in source images
di = dir('Samples/*.tif'); 
% Job number counter
job = 1;
  
for k= 1:length(di)  
    % Read in source files
    SourceImage = imread(['Samples/', di(k).name]);      
    % Stain Separation using Macenko's Method in progress message
    num = num2str(job);
    note1 = 'Job_#';
    note2 = 'Running '; 
    fprintf(['\n \n', note2, note1, num, '\n']);
    try  
      % White space crash check
      Z = WhiteSpace(SourceImage);
      % Apply mask to source image 
      [ Mask, default] = Maskbeta(SourceImage);
      % white space check; Images contain less than 0.1% of sample are 
      % considered to be grey space image 
      [~, Wh] = whitespixelcount(Mask); 
      % If the masked source image is purely white, then skip separation
      % method and save source image as output
      if (Z == 1 || 0.001 >= Wh)
          diary on;
          % Show that this is a white space image
          disp(['***', note1, num, '  ', di(k).name, ' is white space.***']);
          diary off;
          % Save the white space image as output
          copyfile (['Samples/', di(k).name], ['Samples/Separation/WS-', di(k).name]); 
      else
          diary on;
          % Show that this is a normal image
          disp(['***', note1, num, '  ', di(k).name, ' is normal.***']);
          diary off;
          % Stain Separation using Macenko's Image specific Stain Matrix for H&E 
          MacenkoMatrix = EstUsingMacenko( SourceImage );
          [ DCh, M ] = Deconvolve2( SourceImage, MacenkoMatrix);
          [ H, E, Bg ] = PseudoColourStains(DCh, M);
          % Save H, E, and background results separately
          imwrite(H, ['Samples/Separation/H-', di(k).name]);
          imwrite(E, ['Samples/Separation/E-', di(k).name]);
          imwrite(Bg, ['Samples/Separation/B-', di(k).name]);
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
