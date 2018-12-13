% Copyright (c) 2018 Pegah Vaheb, Queen Mary University of London
% Please email me if you find bugs, or have suggestions or questions!

clear all; close all; clc
addpath(genpath(pwd));

files = dir('data/EvaluationFolder/*.jpg');
nfiles = length(files);    % Number of files found
for ii=1:nfiles
    filename = files(ii).name;
    input = imread(filename);
    [m,n]=size(input);
    %input = im2bw(input,0.25);
    imshow(input);
    count=0;
    for i=1: m
        for j=1: n
            if (input(i,j) > 60)
                count=count+1;
            end
        end
    end
    filename
    count
    %vec(ii)=count;
end