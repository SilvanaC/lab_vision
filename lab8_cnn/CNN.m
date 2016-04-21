function CNN(varargin)
% addpath('practical-cnn-2015a');
setup ;

% -------------------------------------------------------------------------
% Part 4.1: prepare the data
% -------------------------------------------------------------------------

% Load character dataset
imdb = load('textonsdb.mat') ;
imdb.images.data = im2single(imdb.images.data);
x = [1:2:25000];
imdb.images.set(x) = 2 ;

% -------------------------------------------------------------------------
% Part 4.2: initialize a CNN architecture
% -------------------------------------------------------------------------
tic
net = initializeCNN() ;
toc

% Take the average image out
imageMean = mean(imdb.images.data(:)) ;
imdb.images.data = imdb.images.data - imageMean ;

% -------------------------------------------------------------------------
% Part 4.6: train with jitter
% -------------------------------------------------------------------------

trainOpts.batchSize = 64;
trainOpts.numEpochs = 20 ;
trainOpts.continue = true ;
trainOpts.useGpu = false ;
trainOpts.learningRate = 0.001 ;
trainOpts.expDir = 'data/CNN_JitterA' ;
trainOpts = vl_argparse(trainOpts, varargin);
mkdir('data','CNN_JitterA');

% Convert to a GPU array if needed
if trainOpts.useGpu
  imdb.images.data = gpuArray(imdb.images.data) ;
end
 
% Call training function in MatConvNet
tic;
[net,info] = cnn_train(net, imdb, @getBatchWithJitter,imageMean, trainOpts) ;
toc;

% Move the CNN back to CPU if it was trained on GPU
if trainOpts.useGpu
  net = vl_simplenn_move(net, 'cpu') ;
end

% Save the result for later use
net.layers(end) = [] ;
net.imageMean = imageMean ;
save('data/CNN_JitterA/charscnn-jit.mat', '-struct', 'net') ;

% --------------------------------------------------------------------
function [im, labels] = getBatchWithJitter(imdb, batch)
% --------------------------------------------------------------------
im = imdb.images.data(:,:,batch) ;
labels = imdb.images.label(1,batch) ;

n = numel(batch) ;
train = find(imdb.images.set == 1) ;

sel = randperm(numel(train), n) ;
im1 = imdb.images.data(:,:,sel) ;

sel = randperm(numel(train), n) ;
im2 = imdb.images.data(:,:,sel) ;

ctx = [im1 im2] ;
ctx(:,65:192,:) = min(ctx(:,65:192,:), im) ;

dx = randi(11) - 6 ;
im = ctx(:,(65:192)+dx,:) ;
sx = (65:192) + dx ;

dy = randi(5) - 2 ;
sy = max(1, min(128, (1:128) + dy)) ;

im = ctx(sy,sx,:) ;

im = 256 * reshape(im, 128, 128, 1, []) ;
