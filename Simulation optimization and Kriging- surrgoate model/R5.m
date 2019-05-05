function [ R ] = R5( sita,X  )
%R5 Summary of this function goes here
%球模型，立方模型，样条函数模型
[m,n]=size(X);
sum=0;
for i=1:m
    for j=1:m
        for k=1:n
            sum=sum+sita(k)*abs(X(i,k)-X(j,k))
        end
        a=min(1,sum);
        sum=0;
         if(0.2>=a>=0)
         R(i,j)=1-1.5*a^2+30*a^3;
         end
         if(1>a>0.2)
          R(i,j)=1.25*(1-a)^3;  
         end
         if(1<=a)
              R(i,j)=1;
         end%样条函数
    end
end



end

