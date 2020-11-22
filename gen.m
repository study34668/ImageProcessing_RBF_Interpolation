name = 'woman';
img_name = ['data/' name '.bmp'];
img_lost_name = ['data/' name '_lost.bmp'];

rate = 0.75;
img = double(imread(img_name)) / 255;
[rowNum, colNum, dimNum] = size(img);
notLost = rand(rowNum, colNum);
notLost = (notLost > rate);
for i = 1:rowNum
    for j = 1:colNum
        if (~notLost(i, j))
            for k = 1:dimNum
                img(i, j, k) = 1;
            end
        end
    end
end

imwrite(img, img_lost_name);