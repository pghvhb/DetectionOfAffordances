% Script to demonstrate affordance detection via a trained SRF model.
% See the README and script_trainSRFAff.m for details on generating the
% affordance model. Precomputed models for all seven affordances are found in:
% "models/forest/precomputed_models/". Copy them into "models/forest/" 
% to use them here. 
% NOTE: Run "detection/private/compile.m" first before running this script
%
% If you use this code or the UMD RGB-D Part Affordance Dataset, please
% cite:
% A. Myers, C.L. Teo, C. Fermüller and Y. Aloimonos, 
% "Affordance Detection of Tool Parts from Geometric Features", Proc. IEEE
% Int'l Conference on Robotics and Automation (ICRA), Seattle, WA, 2015
%
% For more details and to obtain the RGB-D dataset, visit the project webpage:
% http://www.umiacs.umd.edu/research/POETICON/geometric_affordance/
%
% Copyright (c) 2015 Ching L. Teo, University of Maryland College Park [cteo-at-cs.umd.edu]
% Licensed under the Simplified BSD License [see license.txt]
% Please email me if you find bugs, or have suggestions or questions!

clear all; close all;
addpath(genpath(pwd));
%% load SRF affordance model and data 
target='support';%{'pound', 'scoop', 'support', 'wrap-grasp', 'grasp', 'contain', 'cut'};
label_classes; 
targetID=find(strcmp(affordance_label,target)==1)-1;
model_type='_AF_3Dp_F';

modelFnm=['modelFinal_' target model_type];
forestDir = fullfile(pwd,'models','forest','precomputed_models');
forestFn = fullfile(forestDir, modelFnm);
if(exist([forestFn '.mat'], 'file'))
  load([forestFn '.mat']); 
else
    error('model not found');
end
assert(targetID==model.opts.targetID);

%% SRF model parameters
model.opts.multiscale=0;            % detect over several scales (slower)
model.opts.nTreesEval=8;            % for top speed set nTreesEval=1
model.opts.nThreads=8;              % max number cpu threads for inference
%% read in data and process
tic
rgbFN='data/test/5_rgb.jpg'; depthFN='data/test/5_depth.png';
RGB=imread(rgbFN); 
D=single(imread(depthFN))./1e3;
% [optional] resize to make things go a  bit faster...
D=imresize(D,0.5); RGB=imresize(RGB,0.5);
% compute normals
pcloud=depthtocloud(double(D)); DN = single(pcnormal(pcloud));
D=single(D); RGB=im2single(RGB);
I=cat(3,D,DN); %{Depth,Normal}
E=affDetect_norm(I,model);
toc
%% display affordance detection results

figure
subplot(1,2,1), imshow(RGB), title('Input RGB') ;
subplot(1,2,2), imshow(E), title(sprintf('%s affordance detection',target));
