name = 'girl2';
img_name = ['data/' name '.bmp'];
img_lost1_name = ['data/' name '_lost1.bmp'];
img_lost2_name = ['data/' name '_lost2.bmp'];
img_lost3_name = ['data/' name '_lost3.bmp'];
img_res1_nearest_name = ['data/' name '_res1_nearest.bmp'];
img_res1_bilinear_name = ['data/' name '_res1_bilinear.bmp'];
img_res1_rbf_name = ['data/' name '_res1_rbf.bmp'];
img_res2_nearest_name = ['data/' name '_res2_nearest.bmp'];
img_res2_bilinear_name = ['data/' name '_res2_bilinear.bmp'];
img_res2_rbf_name = ['data/' name '_res2_rbf.bmp'];
img_res3_nearest_name = ['data/' name '_res3_nearest.bmp'];
img_res3_bilinear_name = ['data/' name '_res3_bilinear.bmp'];
img_res3_rbf_name = ['data/' name '_res3_rbf.bmp'];

subplot(4, 4, 1);
imshow(imread(img_name)); title('img');
subplot(4, 4, 2);
imshow(imread(img_lost1_name)); title('img lost 0.2');
subplot(4, 4, 3);
imshow(imread(img_lost2_name)); title('img lost 0.5');
subplot(4, 4, 4);
imshow(imread(img_lost3_name)); title('img lost 0.8');
subplot(4, 4, 5);
imshow(imread(img_res1_nearest_name)); title('img nearest');
subplot(4, 4, 6);
imshow(imread(img_res1_bilinear_name)); title('img bilinear');
subplot(4, 4, 7);
imshow(imread(img_res1_rbf_name)); title('img rbf');
subplot(4, 4, 9);
imshow(imread(img_res2_nearest_name)); title('img nearest');
subplot(4, 4, 10);
imshow(imread(img_res2_bilinear_name)); title('img bilinear');
subplot(4, 4, 11);
imshow(imread(img_res2_rbf_name)); title('img rbf');
subplot(4, 4, 13);
imshow(imread(img_res3_nearest_name)); title('img nearest');
subplot(4, 4, 14);
imshow(imread(img_res3_bilinear_name)); title('img bilinear');
subplot(4, 4, 15);
imshow(imread(img_res3_rbf_name)); title('img rbf');