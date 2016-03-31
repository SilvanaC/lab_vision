test = dir('test');
num = zeros(155,1); %%
predT = load('Predictions_tree.mat');
predNN = load('Predictions_NN.mat');
for i=3:155
   num(i-2) = str2double(test(i).name(2:3)); 
end

tp = 0;
for i=1:length(num)
   if(predT.predictions(i) == num(i))
      tp = tp+1; 
   end
end
porcentajeT = tp/length(num);

tp = 0;
for i=1:length(num)
   if(predNN.predictions(i) == num(i))
      tp = tp+1; 
   end
end
porcentajeNN = tp/length(num);