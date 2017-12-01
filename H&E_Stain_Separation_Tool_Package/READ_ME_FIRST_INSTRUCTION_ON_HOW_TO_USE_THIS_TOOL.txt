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

Instructions on How to Use This Tool
Runyu Hong
10/04/2017

1. Move the folder that contains all the images (preferably normalized images) you would like to stain-separate into this tool package folder.

2. Rename the folder you just moved in to “Samples”. Be sure that all your images are .tif RGB images of H&E stained histology.

3. In this tool package folder, qsub your job by typing “qsub run_matlab.bash Separation_Main”. Your job should be submitted and you will get a job number. You may type “qstat” to check your job status.

4. The running time depends on your image size and quality. Typically, the time should be 20 seconds per image. 

5. Once your job is done, the separated images should be in a folder called “Separation” under the “Samples” folder. 

6. The Separated image are named using this format: "H-" is the H stain; "E-" is the E stain; "B-" is the background of stains; "WS-" means the original image is white space.

7. There is also a “Report.txt” file, which contains the runtime info of all your images. It includes which job is white space, normal, or failed and the total number of jobs. 



Bottom Line

Since histology images can have different properties, there might be some images that are not properly separated. Should this happened, please try to run them locally or try stain separation methods other than Macenko’s method.
