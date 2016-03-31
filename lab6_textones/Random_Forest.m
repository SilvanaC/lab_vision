rng default
addpath('lib')
trainData = load('trainData.mat');
textons = load('Textons_Castillo_Daza.mat');
[fb] = fbCreate;
k = 50; % number of textons
%% Train Forest
features = trainData.trainData(:,(1:k));
classLabels = trainData.trainData(:,k+1);

nTrees = 20; % number of trees
B = TreeBagger(nTrees,features,classLabels, 'Method', 'classification');
%% Use Forest to predict categories of test set
test = dir('test');
predictions = zeros(length(test)-3,1);
for i=3:length(test)-1
    nameim = fullfile('test',test(i).name);
    im = double(imread(nameim))/255;
    tmap = assignTextons(fbRun(fb,im),textons.textons');
    hmap = histcounts(tmap,k);
    predChar1 = B.predict(hmap); 
    predictions(i-2) = str2double(predChar1);
end
save('Predictions_tree', 'predictions');