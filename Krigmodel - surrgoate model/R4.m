function [ R ] = R4( sita,X  )
%R4 Summary of this function goes here
%球模型，立方模型，样条函数模型
[m,n]=size(X);
sum=0;
for i=1:m
    for j=1:m
        for k=1:n
            sum=sum+sita(k)*abs(X(i,k)-X(j,k))
        end
        a=min(1,sum);
         R(i,j)=1-3*a^2+2*a^3;%立方模型
     sum=0;
    end
end


end

