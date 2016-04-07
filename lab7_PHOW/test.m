file = fopen('test.txt','w');
tic;
run('vlfeat-0.9.20/toolbox/vl_setup');
testDir = '/datos1/vision/imagenet_small/test/';
addpath(genpath('/datos1/vision/imagenet_small/'));
categorias = dir(testDir);
categorias = categorias(~ismember({categorias.name},{'.','..'}));
fol = [250 400];
for itemp= 1:2 %5:25:105
    i = fol(itemp);
    count = 1;
    mod=strcat('baseline-model',int2str(i),'.mat');
    load(mod);
    for j=1:numel(model.classes)
        cat = categorias(j).name;
        files = dir(fullfile(testDir,cat));
        files = files(~ismember({files.name},{'.','..'}));
        for k=1:numel(files)
            im = imread(files(k).name);
            label = model.classify(model,im);
            label = cellstr(label);
            cat = cellstr(cat);
            prediccion(count) = label;
            anotaciones(count) = cat;
            count = count+1;
        end
    end
    toc;
    matriz = confusionmat(anotaciones,prediccion);
    save(['test-result' int2str(i)], 'matriz');
    tp = trace(matriz);
    tot = sum(sum(matriz));
    accu = 100*(tp/tot);
    fprintf(file,'%d %.3f %.3f\n',i,accu,toc);
end
