function [R ] = R1( sita,X )
%R Summary of this function goes here
%EXPģ�ͣ�EXPGģ�ͣ���˹ģ�� 
[m,n]=size(X);
sum=0;
p=1%���ݲ�ͬģ�ͣ�ѡ��pֵ��p=1ΪEXPģ�ͣ�p=2Ϊ��˹ģ�ͣ�p���ڣ�0��2��ʱΪEXPGģ��
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

