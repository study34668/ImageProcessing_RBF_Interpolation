name = 'girl';
img_name = ['data/' name '.bmp'];
img_lost1_name = ['data/' name '_lost1.bmp'];
img_lost2_name = ['data/' name '_lost2.bmp'];
img_lost3_name = ['data/' name '_lost3.bmp'];
img_res1_name = ['data/' name '_res1.bmp'];
img_res2_name = ['data/' name '_res2.bmp'];
img_res3_name = ['data/' name '_res3.bmp'];

n = 3;
img = double(imread(img_name)) / 255;
nearestVal = 1:n;
bilinearVal = 1:n;
rbfVal = 1:n;
[rowNum, colNum, ~] = size(img);
imgSize = rowNum * colNum;
maxIt = 10;

img_lost = double(imread(img_lost1_name)) / 255;
notLost = (sum(abs(img - img_lost), 3) < 0.01);
[img_res1_nearest, ~] = nearest(img_lost, notLost);
[img_res1_bilinear, ~] = bilinear(img_lost, notLost);
[img_res1_rbf, ~] = rbf_it(img_lost, notLost);
nearestVal(1) = criteria(img, img_res1_nearest);
bilinearVal(1) = criteria(img, img_res1_bilinear);
rbfVal(1) = criteria(img, img_res1_rbf);

img_lost = double(imread(img_lost2_name)) / 255;
notLost = (sum(abs(img - img_lost), 3) < 0.01);
[img_res2_nearest, ~] = nearest(img_lost, notLost);
[img_res2_bilinear, ~] = bilinear(img_lost, notLost);
[img_res2_rbf, ~] = rbf_it(img_lost, notLost);
nearestVal(2) = criteria(img, img_res2_nearest);
bilinearVal(2) = criteria(img, img_res2_bilinear);
rbfVal(2) = criteria(img, img_res2_rbf);

img_lost = double(imread(img_lost3_name)) / 255;
notLost = (sum(abs(img - img_lost), 3) < 0.01);
[img_res3_nearest, ~] = nearest(img_lost, notLost);
[img_res3_bilinear, ~] = bilinear(img_lost, notLost);
[img_res3_rbf, ~] = rbf_it(img_lost, notLost);
nearestVal(3) = criteria(img, img_res3_nearest);
bilinearVal(3) = criteria(img, img_res3_bilinear);
rbfVal(3) = criteria(img, img_res3_rbf);

x = 1:n;
plot(x, nearestVal);
hold on;
plot(x, bilinearVal);
hold on;
plot(x, rbfVal);
hold on;
legend('nearest', 'bilinear', 'rbf');