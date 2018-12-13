Detection of Affordances (DOA)
============

I used this code and the UMD RGB-D Part Affordance Dataset:
A. Myers, C.L. Teo, C. Fermüller and Y. Aloimonos, 
"Affordance Detection of Tool Parts from Geometric Features", Proc. IEEE
Int'l Conference on Robotics and Automation (ICRA), Seattle, WA, 2015


This software was developed under 64-bit Linux with Matlab R2018b. 
There is no guarantee it will run on other operating systems or Matlab versions 
(though it probably will).


Some parts:
Copyright (c) 2015 Ching L. Teo, University of Maryland College Park [cteo-at-cs.umd.edu]
Licensed under the Simplified BSD License [see license.txt]

Modified by 2018 Pegah Vaheb, Queen Mary, University of London

Quick start
-----------
NOTE: if all you want is to run the detector using pre-trained models, just follow steps 5 and 6.

1. Download and unzip the contents of this package into one directory [DOA_v1/].

2. Start Matlab, make sure [DOA_v1/] and its subdirectories are within the search path.

3. cd into [DOA_v1/detection/private/] and run compile.m to compile affDetectMex function.

4. To test a trained SRF affordance model: run DOA_ShowingResults.m.

 
Folder contents and structure
-----------
The main folder [DOA_v1/] contains the following main script files:

a) SRFAff_v1.m 		-- Detects affordance with the actual code of Myers et al.

b) DOA_ShowingResults.m		-- Detects and shows a target affordance given the trained affordance SRF on a folder of RGB-D dataset.

c) DOA_StoringResults.m 	-- Detects and stores a target affordance given the trained affordance SRF on a folder of RGB-D dataset.

d) MakingDemo.m 	-- This code was used to make the demo for viva

e) Evaluation.m		-- Counts the number of detected pixels in each folder of output images
 


The subdirectories contain specific procedures and data: 


1. [data/] 		-- location of dataset + precomputed features. See README_data.txt for details.

2. [detection/] 	-- procedures for detecting a target affordance using a trained SRF.

3. [features/]  	-- procedures for computing fast features (normals, curvatures and shape index) for training/testing the affordance SRF model.

4. [models/] 		-- saves the initial decision trees in [models/tree/] and final affordance SRF in [models/forest/].

5. [toolbox/] 		-- a subset of Piotr's Image & Video Toolbox with precompiled mex functions in [toolbox/private/]. See README_toolbox.txt for details. For documentation and information on using and recompiling the entire toolbox, go to http://vision.ucsd.edu/~pdollar/toolbox/doc/ 

6. [etc/]		-- License of the used code.

 
Evaluating the affordance SRF
-----------
Run Evaluation.m. Detection results will be shown and the number of pixels will be demonstrated in Command Window.


References
-----------
[1] A. Myers, C.L. Teo, C. Fermüller and Y. Aloimonos, "Affordance Detection of Tool Parts from Geometric Features", Proc. IEEE Int'l Conference on Robotics and Automation (ICRA), Seattle, WA, 2015

[2] Ian Lenz, Honglak Lee, Ashutosh Saxena, "Deep Learning for Detecting Robotic Grasps", To appear in International Journal of Robotics Research (IJRR), 2014.






