pTree = load('Predictions_tree.mat');
pNN = load('Predictions_NN.mat');
%% Obtain true labels
test = dir('test');
labels = zeros(length(test)-3,1);
for i=3:length(test)-1
   labels(i-2) = str2double(test(i).name(2:3)); 
end
%% Confusion matrices
cTree = confusionmat(labels,pTree.predictions);
cNN = confusionmat(labels,pNN.predictions);
%% Show matrices
subplot(1,2,1); imagesc(cTree); title('Random Forest');
subplot(1,2,2); imagesc(cNN); title('Nearest Neighbor');