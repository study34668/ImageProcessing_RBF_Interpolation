name = 'woman';
img_name = ['data/' name '.bmp'];
img_lost_name = ['data/' name '_lost.bmp'];
img_res_nearest_name = ['data/' name '_res_nearest.bmp'];
img_res_bilinear_name = ['data/' name '_res_bilinear.bmp'];
img_res_rbf_name = ['data/' name '_res_rbf.bmp'];

img = double(imread(img_name)) / 255;
[rowNum, colNum, ~] = size(img);
imgSize = rowNum * colNum;

img_lost = double(imread(img_lost_name)) / 255;
notLost = (sum(abs(img - img_lost), 3) < 0.01);
[img_res_nearest, ~] = nearest(img_lost, notLost);
[img_res_bilinear, ~] = bilinear(img_lost, notLost);
[img_res_rbf, ~] = rbf_it(img_lost, notLost);

imwrite(img_res_nearest, img_res_nearest_name);
imwrite(img_res_bilinear, img_res_bilinear_name);
imwrite(img_res_rbf, img_res_rbf_name);
