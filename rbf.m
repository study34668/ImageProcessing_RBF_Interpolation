function [ res, notLostRes ] = rbf(img, notLost)
    % RBF²åÖµ
    [rowNum, colNum, dimNum] = size(img);
    imgSize = rowNum * colNum;
    neighborSize = 5;
    l = floor(neighborSize / 2);
    notLostLoc = find(notLost);
    notLostSize = size(notLostLoc, 1);
    eps = sqrt(-log(0.01) / l^2);
    locMat = reshape(1:imgSize, rowNum, colNum);
    notLostLocNoMat = zeros(rowNum, colNum);
    w = zeros(imgSize, dimNum);
    
    rows = zeros(notLostSize * neighborSize^2, 1);
    cols = zeros(notLostSize * neighborSize^2, 1);
    vals = zeros(notLostSize * neighborSize^2, 1);
    tmpVals = zeros(1, neighborSize^2);
    
    for i = 1:notLostSize
        loc = notLostLoc(i);
        ii = mod(loc-1, rowNum) + 1;
        jj = floor((loc-1) / rowNum) + 1;
        notLostLocNoMat(ii, jj) = i;
    end
    
    len = 0;
    imat = 0;
    for j = 1:colNum
        for i = 1:rowNum
            if (notLost(i, j))
                imat = imat + 1;
                tmpLen = 0;
                for ii = max(1, i-l):min(i+l, rowNum)
                    for jj = max(1, j-l):min(j+l, colNum)
                        if (notLost(ii, jj))
                            len = len + 1;
                            tmpLen = tmpLen + 1;
                            rows(len) = imat;
                            cols(len) = notLostLocNoMat(ii, jj);
                            r = sqrt((i-ii)^2 + (j-jj)^2);
                            tmpVals(tmpLen) = exp(-(eps * r).^2);
                        end
                    end
                end
                vals(len-tmpLen+1:len) = tmpVals(1:tmpLen) / sum(tmpVals(1:tmpLen));
                if (tmpLen == 0)
                    len = len + 1;
                    rows(len) = imat;
                    cols(len) = imat;
                    vals(len) = 1;
                end
            end
        end
    end
    
    rows = rows(1:len);
    cols = cols(1:len);
    vals = vals(1:len);
    A = sparse(rows, cols, vals, notLostSize, notLostSize);
    b = zeros(notLostSize, 1);
    for i = 1:dimNum
        img1 = img(:, :, i);
        b(:, 1) = img1(notLostLoc);
        x = A \ b;
        w(notLostLoc, i) = x;
    end
    
    rows = zeros(imgSize * neighborSize^2, 1);
    cols = zeros(imgSize * neighborSize^2, 1);
    vals = zeros(imgSize * neighborSize^2, 1);
    
    imat = 0;
    len = 0;
    notLostRes = notLost;
    for j = 1:colNum
        for i = 1:rowNum
            imat = imat + 1;
            tmpLen = 0;
            for ii = max(1, i-l):min(i+l, rowNum)
                for jj = max(1, j-l):min(j+l, colNum)
                    if (notLost(ii, jj))
                        len = len + 1;
                        tmpLen = tmpLen + 1;
                        rows(len) = imat;
                        cols(len) = locMat(ii, jj);
                        r = sqrt((i-ii)^2 + (j-jj)^2);
                        tmpVals(tmpLen) = exp(-(eps * r).^2);
                    end
                end
            end
            vals(len-tmpLen+1:len) = tmpVals(1:tmpLen) / sum(tmpVals(1:tmpLen));
            if (tmpLen > 0)
                notLostRes(i, j) = 1;
            end
        end
    end
    
    res = zeros(rowNum, colNum, dimNum);
    rows = rows(1:len);
    cols = cols(1:len);
    vals = vals(1:len);
    A = sparse(rows, cols, vals, imgSize, imgSize);
    for i = 1:dimNum
        x = A * w(:, i);
        res(:, :, i) = reshape(x, rowNum, colNum, 1);
    end
    
    %res = zeros(rowNum, colNum, dimNum);
    %for j = 1:colNum
    %    for i = 1:rowNum
    %        len = 0;
    %        for ii = max(1, i-l):min(i+l, rowNum)
    %            for jj = max(1, j-l):min(j+l, colNum)
    %                if (notLost(ii, jj))
    %                    len = len + 1;
    %                    r = sqrt((i-ii)^2 + (j-jj)^2);
    %                    fai = exp(-(eps * r).^2);
    %                    for k = 1:dimNum
    %                        res(i, j, k) = res(i, j, k) + fai * w(ii + (jj-1) * rowNum, k);
    %                    end
    %                end
    %            end
    %        end
    %        if (len > 0)
    %            notLost(i, j) = 1;
    %        end
    %    end
    %end
    
 end