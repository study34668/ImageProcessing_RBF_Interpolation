function [ fai ] = kernel( eps, r )
% ���������
    fai = exp(-(eps * r)^2);
end

