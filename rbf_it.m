function [ res, notLostRes ] = rbf_it( img, notLost )
    % RBF ²åÖµ
    maxIt = 5;
    [rowNum, colNum, ~] = size(img);
    imgSize = rowNum * colNum;
    res = img;
    notLostRes = notLost;
    for i = 1:maxIt
        lostSize = imgSize - size(find(notLostRes), 1);
        if (lostSize > (imgSize / 1000))
            [res, notLostRes] = rbf(res, notLostRes);
        else
            break
        end
    end
end

