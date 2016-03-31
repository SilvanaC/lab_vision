addpath('lib')
[fb] = fbCreate;
nt = 50;
train = load('trainData1');
labels = load('labels.mat');
textons = load('Textons_Castillo_Daza.mat');

chiSqrDist = @(x,Z,wt)sqrt((bsxfun(@minus,x,Z).^2)*wt);
k = 1;
w = ones(size(train.trainData1,2),1)/50;
model = fitcknn(train.trainData1,labels.labels,'Distance',@(x,Z)chiSqrDist(x,Z,w),...
    'NumNeighbors',k,'Standardize',1);
%% Textons map (test set)
test = dir('test');
testData = zeros(length(test)-3,nt);
for i=3:length(test)-1
    nameim = fullfile('test',test(i).name);
    im = double(imread(nameim))/255;
    tmap = assignTextons(fbRun(fb,im),textons.textons');
    testData(i-2,:) = histcounts(tmap,nt);
end
save('testData', 'testData');
%%
predictions = predict(model,testData);
save('Predictions_NN', 'predictions');