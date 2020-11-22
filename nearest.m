function [ res, notLostRes ] = nearest( img, notLost )
% ×î½üÁÚ²åÖµ
    [rowNum, colNum, ~] = size(img);
    neighborSize = 7;
    
    res = img;
    notLostRes = notLost;
    for j = 1:colNum
        for i = 1:rowNum
            if (~notLost(i, j))
                found = 0;
                for k = 1:neighborSize
                    for h = -k:k
                        ii = min(max(1, i + h), rowNum);
                        jj1 = min(max(1, j + k - abs(h)), colNum);
                        jj2 = min(max(1, j - k + abs(h)), colNum);
                        if (notLost(ii, jj1))
                            res(i, j, :) = img(ii, jj1, :);
                            found = 1;
                        end
                        if (notLost(ii, jj2))
                            res(i, j, :) = img(ii, jj2, :);
                            found = 1;
                        end
                    end
                    if (found > 0)
                        break
                    end
                end
                if (found > 0)
                    notLostRes(i, j) = 1;
                end
            end
        end
    end
    
end
