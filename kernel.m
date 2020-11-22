function [ fai ] = kernel( eps, r )
% ¾¶Ïò»ùº¯Êý
    fai = exp(-(eps * r)^2);
end

