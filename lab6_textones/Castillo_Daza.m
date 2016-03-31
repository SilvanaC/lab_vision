addpath('lib')
clear all; close all; clc;

[fb] = fbCreate; % create filter bank
%% Reference images to create the texton dictionary
im = [];
for i=1:25
    category = int2str(i);
    if(i<10)
        category = ['0' category];
    end
    num = randi(30,2,1);
    n1 = int2str(num(1)); n2 = int2str(num(2));
    if(num(1)<10)
        n1 = ['0' n1];
    end
    if(num(2)<10)
        n2 = ['0' n2];
    end
    
    name1 = fullfile('train',['T' category '_' n1 '.jpg']);
    name2 = fullfile('train',['T' category '_' n2 '.jpg']);
    
    im1 = double(imread(name1))/255;
    im2 = double(imread(name2))/255;
    im = [im im1 im2];
end
%% Dictionary creation
k = 50; % numer of textons in the dictionary
[map,textons] = computeTextons(fbRun(fb,im),k); % textons dictionary
save('Map_Castillo_Daza', 'map');
save('Textons_Castillo_Daza', 'textons');
%% Textons map (train set)
train = dir('train');
trainData1 = zeros(length(train)-3,k);
for i=3:length(train)-1
    nameim = fullfile('train',train(i).name);
    im = double(imread(nameim))/255;
    tmap = assignTextons(fbRun(fb,im),textons');
    trainData1(i-2,:) = histcounts(tmap,k);
end
labels = load('labels.mat');
trainData = [trainData1 labels.labels'];
save('trainData', 'trainData');