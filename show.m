name = 'sea';
img_name = ['data/' name '.bmp'];
img_lost_name = ['data/' name '_lost3.bmp'];
img_res_nearest_name = ['data/' name '_res_nearest.bmp'];
img_res_bilinear_name = ['data/' name '_res_bilinear.bmp'];
img_res_rbf_name = ['data/' name '_res_rbf.bmp'];

subplot(2, 3, 1);
imshow(imread(img_name)); title('img');
subplot(2, 3, 2);
imshow(imread(img_lost_name)); title('img lost');
subplot(2, 3, 4);
imshow(imread(img_res_nearest_name)); title('img nearest');
subplot(2, 3, 5);
imshow(imread(img_res_bilinear_name)); title('img bilinear');
subplot(2, 3, 6);
imshow(imread(img_res_rbf_name)); title('img rbf');