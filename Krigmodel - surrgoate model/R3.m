function [ R ] = R3( sita,X  )
%R3 Summary of this function goes here
%��ģ�ͣ�����ģ�ͣ���������ģ��
[m,n]=size(X);
sum=0;
for i=1:m
    for j=1:m
        for k=1:n
            sum=sum+sita(k)*abs(X(i,k)-X(j,k))
        end
        a=min(1,sum);
        R(i,j)=1-1.5*a+0.5*a^2;%��ģ��
         sum=0;
    end
end


end

