%function [ c ] = criteria( a, b )
%    c = mean(mse(a-b));
%end

function [ c ] = criteria( a, b )
    c = psnr(b, a);
end

%function [ c ] = criteria( a, b )
%    [c, ~] = ssim(b, a);
%end

