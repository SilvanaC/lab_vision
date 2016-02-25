%% Imagenes
%original images
io1 = imread('Original-año_viejo.jpg');
io2 = imread('Original-snowman.JPG');

%cut images with similar size
i1 = imread('año_viejo2.jpg');
i2 = imread('snowman2.JPG');

%Final processing
imagen1 = imcrop(i1,[100 120 170 540]);
imagen2 = imcrop(i2,[90 80 170 433]);
imwrite(imagen1,'fixed_año_viejo.jpg');
imwrite(imagen2,'fixedsnowman.jpg');

figure
subplot(2,2,1); imshow(io1);title('Original "Año viejo"');
subplot(2,2,2); imshow(io2);title('Original Snowman');
subplot(2,2,3); imshow(imagen1);title('Fixed "Año viejo"');
subplot(2,2,4); imshow(imagen2);title('Fixed snowman');
%% filters
% cutoff_frequency for each filter
c_f = 5;
c_f2 = 10;
% Gaussian filters
filter = fspecial('Gaussian', c_f*4+1, c_f);
filter2 = fspecial('Gaussian', c_f2*4+1, c_f2);

low = imfilter(imagen1,filter);
high = imagen2 - imfilter(imagen2,filter2);%To calculate a high-pass filtered image, the original image was low-pass filtered and substracted from itself.
hybrid = low + high; %A hybrid image is the sum of a low-pass filtered image and a high-pass filtered image.
imwrite(hybrid,'Snowman on fire.jpg');

figure;
subplot(1,3,1); imshow(low);title('low-pass filtered');
subplot(1,3,2); imshow(high);title('high-pass filtered');
subplot(1,3,3); imshow(hybrid);title('Hybrid image');
%% pyramid
output = vis_hybrid_image(hybrid); %code by James Hays
imwrite(output,'Pyramid.jpg');
figure;
imshow(output); title('Snowman on fire');
%% Look at the fft transforms
%2-D fast Fourier transform
imagen1fft = fft(imagen1);
imagen2fft = fft(imagen2);
lowfft = fft(low);
highfft = fft(high);
hybridfft = fft(hybrid);
figure; title('fft');
subplot(2,3,1); imshow(imagen1fft);title('fft in "Año viejo"');
subplot(2,3,3); imshow(imagen2fft);title('fft in snowman');
subplot(2,3,4); imshow(lowfft);title('fft in low-pass filtered');
subplot(2,3,5); imshow(highfft);title('fft in high-pass filtered');
subplot(2,3,6); imshow(hybridfft);title('fft in hybrid image');