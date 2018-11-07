% This matlab code implements the NRAM model for infrared small target 
% detection.
%
% Reference:
% Landan Zhang, Lingbing Peng, Tianfang Zhang, Siying Cao and Zhenming Peng*
% "Infrared Small Target Detection via Non-Convex Rank Approximation 
% Minimization Joint l2,1 Norm" in Remote Sensing (minor revision)
%
%
% Written by Landan Zhang 
% 2018-11-05
clc;
clear;
close all;

addpath('functions/')
saveDir = 'results/';
imgpath = 'images/';
imgDir = dir([imgpath '*.bmp']);

% patch parameters
patchSize = 50;
slideStep = 10;

len = length(imgDir);
for i=1:len
    
    img = imread([imgpath imgDir(i).name]);
    figure,subplot(131)
    imshow(img),title('Original image')

    if ndims( img ) == 3
        img = rgb2gray( img );
    end
    img = double(img);

    % constrcut patch image
    D = construct(img, patchSize, slideStep);     
    [m, n] = size(D);
    D = mat2gray(D);         
    
    % The proposed NRAM procedure
    lambda = 1 / sqrt(min(m, n)); 
    [hatA, hatE] = nram(D, lambda); 
    
    % recover the target and background image
    tarImg = reconstruct(hatE, img, patchSize, slideStep);
    backImg = reconstruct(hatA, img, patchSize, slideStep);

    maxv = max(max(double(img)));
    E = uint8( mat2gray(tarImg)*maxv );
    A = uint8( mat2gray(backImg)*maxv );
    subplot(132),imshow(E,[]),title('Target image')
    subplot(133),imshow(A,[]),title('Background image')

    % save the results
    imwrite(E, [saveDir 'target/' imgDir(i).name]);
    imwrite(A, [saveDir 'background/' imgDir(i).name]);
    
end
