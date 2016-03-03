function my_segmentation = segment_by_clustering( varargin)
%The argumnets are: rgb_image, feature_space, clustering method, number of clusters 
% It's necessary to put at least the first 3 arguments.
% feature_space : 'rgb', 'lab', 'hsv', 'rgb+xy', 'lab+xy', 'hsv+xy'
% clustering_method = k-means, gmm, hierarchical or watershed
% The output of the function is a image (or matrix) where each pixel has a cluster label.
% Assume 4 clusters if the 4th by default.
switch nargin
    case 1
        error('No ha ingresado los suficientes argumentos')
    case 2
        error('No ha ingresado los suficientes argumentos')
    case 3
        imagen = varargin{1};
        feature_space =varargin{2};
        clustering_method =varargin{3};
        number_clusters = 4;
    case 4
        imagen = varargin{1};
        feature_space =varargin{2};
        clustering_method =varargin{3};
        number_clusters = varargin{4};
    otherwise
        error('Ha ingresado demasiados argumentos')
end

validateattributes(imagen, {'logical' 'numeric'},{'3d'});

switch feature_space
    case 'rgb'
        if strcmp(clustering_method,'hierarchical')
            im = imagen;
            im = imresize(im,0.3);
            f_e = zeros(size(im,1)*size(im,2),3);
        else
            im = imagen;
            f_e = zeros(size(im,1)*size(im,2),3);
        end
    case 'lab'
        if strcmp(clustering_method,'hierarchical')
            cform = makecform('srgb2lab');
            im = applycform(imagen,cform);
            im = imresize(im,0.3);
            f_e = zeros(size(im,1)*size(im,2),3);
        else
            cform = makecform('srgb2lab');
            im = applycform(imagen,cform);
            f_e = zeros(size(im,1)*size(im,2),3);
        end
    case 'hsv'
        if strcmp(clustering_method,'hierarchical')
            im = rgb2hsv(imagen);
            im = imresize(im,0.3);
            f_e = zeros(size(im,1)*size(im,2),3);
        else
            im = rgb2hsv(imagen);
            f_e = zeros(size(im,1)*size(im,2),3);
        end
    case 'rgb+xy'
        if strcmp(clustering_method,'hierarchical')
            im = imagen;
            im = imresize(im,0.3);
            f_e = zeros(size(im,1)*size(im,2),5);
        else
            im = imagen;
            f_e = zeros(size(im,1)*size(im,2),5);
        end
    case 'lab+xy'
        if strcmp(clustering_method,'hierarchical')
            cform = makecform('srgb2lab');
            im = applycform(imagen,cform);
            im = imresize(im,0.3);
            f_e = zeros(size(im,1)*size(im,2),5);
        else
            cform = makecform('srgb2lab');
            im = applycform(imagen,cform);
            f_e = zeros(size(im,1)*size(im,2),5);
        end
    case 'hsv+xy'
        if strcmp(clustering_method,'hierarchical')
            im = rgb2hsv(imagen);
            im = imresize(im,0.3);
            f_e = zeros(size(im,1)*size(im,2),5);
        else
            im = rgb2hsv(imagen);
            f_e = zeros(size(im,1)*size(im,2),5);
        end
    otherwise
        error('No es un feature espace valido')
end
k=1;
for j=1:size(im,2)
    for i=1:size(im,1)
        
        if size(f_e,2)==3
            f_e(k,1) = im(i,j,1);
            f_e(k,2) = im(i,j,2);
            f_e(k,3) = im(i,j,3);
        else
            f_e(k,1) = im(i,j,1);
            f_e(k,2) = im(i,j,2);
            f_e(k,3) = im(i,j,3);
            f_e(k,4) = i;
            f_e(k,5) = j;
        end
        k = k +1;
    end
end

switch clustering_method
    case 'k-means'
        [cluster_idx, cluster_center] = kmeans(f_e,number_clusters);
        my_segmentation = reshape(cluster_idx,size(im,1),size(im,2));
    case 'gmm'
        gm = fitgmdist(f_e,number_clusters,'RegularizationValue',0.1 );
        c = cluster(gm,f_e);
        my_segmentation = reshape(c,size(im,1),size(im,2));
    case 'hierarchical'
        d = pdist(f_e,'cityblock');
        link = linkage(d, 'average');
        c = cluster(link,number_clusters);
        my_segmentation = reshape(c,size(im,1),size(im,2));
    case 'watershed'
        % codigo de las diapositivas "07_grouping01"
        im=rgb2gray(im);
        hy = fspecial('sobel');
        hx = hy';
        Iy = imfilter(double(im), hy, 'replicate');
        Ix = imfilter(double(im), hx, 'replicate');
        grad = sqrt(Ix.^2 + Iy.^2);
        marker = imextendedmin(grad, 25); %25 is the h-minima of markers (works better with numbers between 20 and 30)
        new_grad = imimposemin(grad, marker);
        my_segmentation = watershed(new_grad);
    otherwise
        error('No es un feature_space valido')
end
end