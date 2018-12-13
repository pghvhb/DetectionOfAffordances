% Copyright (c) 2018 Pegah Vaheb, Queen Mary University of London
% Please email me if you find bugs, or have suggestions or questions!

clear all; close all;
addpath(genpath(pwd));
%% load SRF affordance model and data 
target='cut';%{'pound', 'scoop', 'support', 'wrap-grasp', 'grasp', 'contain', 'cut'};
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
rgbFN='data/RawDataset/Scissors2/Scissors2013_rgb.jpg'; 
depthFN='data/RawDataset/Scissors2/Scissors2013_depth.png';
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