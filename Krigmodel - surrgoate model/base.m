function [F ] = base( X )
%BASE Summary of this function goes here
%   Detailed explanation goes here
[m,n]=size(X);
%��һ�ֻ�����
F=ones(m,1);
%�ڶ��ֻ�����
F=[ones(m,1),X];
%�����ֻ�����
for i=1:m
    for j=1:n
        for k=j:n
        F(i,(2*n+2-j)*(j-1)/2+k-j+1)=X(i,j)*X(i,k);
        end
    end
end
F=[ones(m,1),X,F];
end

