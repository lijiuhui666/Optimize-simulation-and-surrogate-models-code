function [ R ] = R4( sita,X  )
%R4 Summary of this function goes here
%��ģ�ͣ�����ģ�ͣ���������ģ��
[m,n]=size(X);
sum=0;
for i=1:m
    for j=1:m
        for k=1:n
            sum=sum+sita(k)*abs(X(i,k)-X(j,k))
        end
        a=min(1,sum);
         R(i,j)=1-3*a^2+2*a^3;%����ģ��
     sum=0;
    end
end


end

