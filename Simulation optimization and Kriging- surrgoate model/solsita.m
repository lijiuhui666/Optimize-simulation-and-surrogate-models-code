
function[f]=solsita(sita)
load('X.mat');  % input ,known
load('Y.mat');  % output
[m,n]=size(X);
A=max(X);
for i=1:n
    X(:,i)=X(:,i)/A(i);
end
%% ������֪���ݵ��Ŀռ���ط��̾���R0
sum=0;
p=1;%���ݲ�ͬģ�ͣ�ѡ��pֵ��p=1ΪEXPģ�ͣ�p=2Ϊ��˹ģ�ͣ�p���ڣ�0��2��ʱΪEXPGģ��
for i=1:m
    for j=1:m
        for k=1:n
            sum=sum+sita(k)*abs(X(i,k)-X(j,k))^p;
        end
        R(i,j)=exp(-sum);
        sum=0;
    end
end
   % onesΪ����ȫ1����
   F=base(X);
   %���� beta����
   M=F'*inv(R)*F;
   beta=inv(M)*F'*inv(R)*Y;
   N=Y-F*beta;
   sigama2=N'*inv(R)*N/m;
   f=0.5*(m*log(trace(sigama2))+log(det(R)));