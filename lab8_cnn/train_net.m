function  res=train_net(net ,test_data)
% Load the CNN learned before
test_data = im2single(test_data);
test_data = (test_data - net.imageMean) ;

test_data = 256 * reshape(test_data, 128, 128, 1, []) ;

% Apply the CNN to the larger image
r = vl_simplenn(net, test_data) ;

scores = squeeze(gather(r(end).x)) ;
[bestScore, best] = max(max(scores)) ;
prediccion = reshape(best,25,size(r(end).x,4));
res= zeros(size(r(end).x,4),1);
for i=1:size(r(end).x,4)
 [~,res(i)] = max(prediccion(:,i));
end
end