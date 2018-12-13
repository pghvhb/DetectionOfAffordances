% Copyright (c) 2018 Pegah Vaheb, Queen Mary University of London
% Please email me if you find bugs, or have suggestions or questions!

clear; close all;
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
model.opts.multiscale=3;            % detect over several scales (slower)
model.opts.nTreesEval=8;            % for top speed set nTreesEval=1
model.opts.nThreads=12;              % max number cpu threads for inference
%% read in data and process and display

rgbfiles = dir('data/test/demo/*.jpg');
depthfiles = dir('data/test/demo/*.png');
nfiles = length(rgbfiles);    % Number of files found
for ii=1:nfiles
    
    rgbfilename = rgbfiles(ii).name;
    RGB = imread(rgbfilename);
    depthfilename = depthfiles(ii).name;
    D = single(imread(depthfilename))./1e3;
    % [optional] resize to make things go a  bit faster...
    D=imresize(D,.5); RGB=imresize(RGB,.5);
    % compute normals
    pcloud=depthtocloud(double(D)); DN = single(pcnormal(pcloud));
    D=single(D); RGB=im2single(RGB);
    I=cat(3,D,DN); %{Depth,Normal}
    E=affDetect_norm(I,model);
    
    % display affordance detection results
    pause(2); close
    figure
    subplot(1,2,1), imshow(RGB) ;
    subplot(1,2,2), imshow(E), title(sprintf('%s affordance detection',target));
    %waitforbuttonpress;   
end

