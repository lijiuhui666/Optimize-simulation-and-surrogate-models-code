function [R ] = R1( sita,X )
%R Summary of this function goes here
%EXP模型，EXPG模型，高斯模型 
[m,n]=size(X);
sum=0;
p=1%根据不同模型，选择p值，p=1为EXP模型，p=2为高斯模型，p属于（0，2）时为EXPG模型
for i=1:m
    for j=1:m
        for k=1:n
            sum=sum+sita(k)*abs(X(i,k)-X(j,k))^p
        end
        R(i,j)=exp(-sum);
        sum=0;
    end
end

end

