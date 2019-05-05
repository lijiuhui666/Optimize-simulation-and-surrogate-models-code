function [F ] = base( X )
%BASE Summary of this function goes here
%   Detailed explanation goes here
[m,n]=size(X);
%第一种基函数
F=ones(m,1);
%第二种基函数
F=[ones(m,1),X];
%第三种基函数
for i=1:m
    for j=1:n
        for k=j:n
        F(i,(2*n+2-j)*(j-1)/2+k-j+1)=X(i,j)*X(i,k);
        end
    end
end
F=[ones(m,1),X,F];
end

