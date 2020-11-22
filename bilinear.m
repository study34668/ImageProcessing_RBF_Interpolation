function [ res, notLostRes ] = bilinear(img, notLost)
    % Ë«ÏßÐÔ²åÖµ
    [rowNum, colNum, dimNum] = size(img);
    imgSize = rowNum * colNum;
    neighborSize = 5;
    neighborL = floor(neighborSize / 2);
    notLostLoc = find(notLost);
    locMat = reshape(1:imgSize, rowNum, colNum);    

    rows = zeros(imgSize * neighborSize^2, 1);
    cols = zeros(imgSize * neighborSize^2, 1);
    vals = zeros(imgSize * neighborSize^2, 1);
    tmpVals = zeros(1, neighborSize^2);
    
    imat = 0;
    len = 0;
    for j = 1:colNum
        for i = 1:rowNum
            imat = imat + 1;
            if (~notLost(i, j))
                tmpLen = 0;
                for ii = max(1, i-neighborL):min(i+neighborL, rowNum)
                    for jj = max(1, j-neighborL):min(j+neighborL, colNum)
                        if ((ii ~= i || jj ~= j) && notLost(ii, jj))
                            len = len + 1;
                            tmpLen = tmpLen + 1;
                            rows(len) = imat;
                            cols(len) = locMat(ii, jj);
                            tmpVals(tmpLen) = neighborSize^2 - abs((i-ii) * (j-jj));
                        end
                    end
                end
                if (tmpLen == 0)
                    for ii = max(1, i-1):min(i+1, rowNum)
                        for jj = max(1, j-1):min(j+1, colNum)
                            if (ii ~= i || jj ~= j)
                                len = len + 1;
                                tmpLen = tmpLen + 1;
                                rows(len) = imat;
                                cols(len) = locMat(ii, jj);
                                tmpVals(tmpLen) = 1;
                            end
                        end
                    end
                end
                tmpVals(1:tmpLen) = tmpVals(1:tmpLen) / sum(tmpVals(1:tmpLen));
                vals(len-tmpLen+1:len) = -tmpVals(1:tmpLen);
            end
            len = len + 1;
            rows(len) = imat;
            cols(len) = imat;
            vals(len) = 1;
        end
    end
    
    res = zeros(rowNum, colNum, dimNum);
    notLostRes = ones(rowNum, colNum);
    rows = rows(1:len);
    cols = cols(1:len);
    vals = vals(1:len);
    A = sparse(rows, cols, vals, imgSize, imgSize);
    b = zeros(imgSize, 1);
    for i = 1:dimNum
        img1 = img(:, :, i);
        b(notLostLoc, 1) = img1(notLostLoc);
        x = A \ b;
        res(:, :, i) = reshape(x, rowNum, colNum, 1);
    end   

end
