name = 'sea';
img_lost1_name = ['data/' name '_lost1.bmp'];
img_lost2_name = ['data/' name '_lost2.bmp'];
img_lost3_name = ['data/' name '_lost3.bmp'];

subplot(1, 3, 1);
imshow(imread(img_lost1_name));
subplot(1, 3, 2);
imshow(imread(img_lost2_name));
subplot(1, 3, 3);
imshow(imread(img_lost3_name));