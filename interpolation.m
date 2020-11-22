name = 'girl2';
img_name = ['data/' name '.bmp'];
img_lost_name = ['data/' name '_lost.bmp'];
img_res_name = ['data/' name '_res.bmp'];

img = double(imread(img_name)) / 255;
[rowNum, colNum, ~] = size(img);
imgSize = rowNum * colNum;

n = 9;
nearestVal = 1:n;
bilinearVal = 1:n;
rbfVal = 1:n;
x = 0.1:0.1:0.9;
for i = 1:n;
    rate = 0.1 * i;
    notLost = rand(rowNum, colNum);
    notLost = (notLost > rate);
    [img_res_nearest, ~] = nearest(img, notLost);
    [img_res_bilinear, ~] = bilinear(img, notLost);
    [img_res_rbf, ~] = rbf_it(img, notLost);
    nearestVal(i) = criteria(img, img_res_nearest);
    bilinearVal(i) = criteria(img, img_res_bilinear);
    rbfVal(i) = criteria(img, img_res_rbf);
end

plot(x, nearestVal);
hold on;
plot(x, bilinearVal);
hold on;
plot(x, rbfVal);
hold on;
legend('nearest', 'bilinear', 'rbf');
