%% function that creates the .mat files for each image
%% Add paths and create folders
folder = fullfile('BSR','BSDS500','data','images','test');
addpath(folder);
OutDir = 'segs';
if ~exist(OutDir, 'dir')
   mkdir(OutDir);
end
% Create Struct
directorio = dir(folder);
%% Create .mat cells (Hierarchical and RGB)
for i = 3:202
    tic
    im = imread(directorio(i).name);
    segs = cell(1,5);
    for j = 1:5
        segs{j} = segment_by_clustering(im,'lab','k-means',j*5);
    end
    [pathstr,name,ext] = fileparts(directorio(i).name);
    save(fullfile('segs',name), 'segs');
    toc
end