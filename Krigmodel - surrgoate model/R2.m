function [ R ] = R2( sita,X )
%R2 Summary of this function goes here
%   线性模型
[m,n]=size(X);
sum=0;
for i=1:m
    for j=1:m
        for k=1:n
            sum=sum+sita(k)*abs(X(i,k)-X(j,k))
        end
        R(i,j)=max(0,1-sum);
        sum=0;
    end
end


end

