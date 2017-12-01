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

Instructions on How to Use This Tool
Runyu Hong
09/26/2017

1. Move the folder that contains all the images you would like to normalize into this tool package folder.

2. Rename the folder you just moved in to “Samples”. Be sure that all your images are .tif RGB images.

3. In this tool package folder, qsub your job by typing “qsub run_matlab.bash MM”. Your job should be submitted and you will get a job number. You may type “qstat” to check your job status.

4. The running time depends on your image size and quality. Typically, the time should be 1 min per image. 

5. Once your job is done, the normalized images should be in a folder called “Norm” under the “Samples” folder. 

6. The normalized image are named using this format: “Job_#(unique job number for each image)-(GS or WS if it is a grey or white space image)_(name of the original image)”

7. There is also a “Report.txt” file, which contains the runtime info of all your images. It includes which job is white space, grey space, normal, or failed and the total number of jobs. 


Customize the Normalization

1. You may customize the threshold for grey space image at MM.m line 77. The default for grey space image is that it contains less than 0.1% of sample pixels.

2. You may customize the threshold for the size of ROI to be normalized at ROI.m line 22. The default minimum for ROI size is 50000 pixels. 

3. You may customize the background mask threshold in Maskbeta.m. The default range for RGB background values are 206 to 255.


Bottom Line

Since histology images can have different properties, there might be some images that are not properly normalized. Should this happened, please try to run them locally or try normalization methods other than Macenko’s method.
