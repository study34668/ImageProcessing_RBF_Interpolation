name = 'girl';
img_name = ['data/' name '.bmp'];
img_lost_name = ['data/' name '_lost.bmp'];
img_res_name = ['data/' name '_res.bmp'];
img = double(imread(img_name)) / 255;
img_lost = double(imread(img_lost_name)) / 255;
notLost = (sum(abs(img - img_lost), 3) < 0.01);
%img_lost_gray = rgb2gray(img_lost);
img = img_lost;

%function [ res ] = rbf(img, notLost)
    % rbf²åÖµ
    [rowNum, colNum, dimNum] = size(img);
    imgSize = rowNum * colNum;
    neighborSize = 7;
    neighborSize2 = neighborSize^2;
    l = floor(neighborSize / 2);
    eps = sqrt(-log(0.01) / 2 / l^2);
    locMat = reshape(1:imgSize, rowNum, colNum);
    kernelMat = zeros(neighborSize2, neighborSize2);
    for i = 1:neighborSize
        for j = 1:neighborSize
            r = norm([i-1, j-1], 2);
            kernelMat(i, j) = kernel(eps, r);
        end
    end
    
    rows = zeros(neighborSize2, 1);
    cols = zeros(neighborSize2, 1);
    locs = zeros(neighborSize2, 1);
    % tmpVals = zeros(neighborSize^2, 1);
    
    res = img;
    for j = 1:colNum
        for i = 1:rowNum
            if (~notLost(i, j))
                len = 0;
                for ii = max(1, i-l):min(i+l, rowNum)
                    for jj = max(1, j-l):min(j+l, colNum)
                        if ((i ~= ii || j ~= jj) && notLost(ii, jj))
                            len = len + 1;
                            rows(len) = ii;
                            cols(len) = jj;
                            locs(len) = locMat(ii, jj);
                        end
                    end
                end
                if (len > 0)
                    A = zeros(len, len);
                    w = zeros(len, 1);
                    b = zeros(len, 1);
                    for k = 1:len
                        for h = k:len
                            iDis = abs(rows(k) - rows(h)) + 1;
                            jDis = abs(cols(k) - cols(h)) + 1;
                            val = kernelMat(iDis, jDis);
                            A(k, h) = val;
                            A(h, k) = val;
                        end
                    end
                    for d = 1:dimNum
                        img1 = img(:, :, d);
                        b(:, 1) = img1(locs(1:len));
                        w(:, 1) = A \ b;
                        val = 0;
                        for k = 1:len
                            iDis = abs(rows(k) - i) + 1;
                            jDis = abs(cols(k) - j) + 1;
                            val = val + w(k) * kernelMat(iDis, jDis);
                        end
                        res(i, j, d) = val;
                    end
                end
            end
        end
    end
    
%end

imshow(res);

