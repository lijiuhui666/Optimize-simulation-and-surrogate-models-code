
function[f]=solsita(sita)
load('X.mat');  % input ,known
load('Y.mat');  % output
[m,n]=size(X);
A=max(X);
for i=1:n
    X(:,i)=X(:,i)/A(i);
end
%% 计算已知数据点间的空间相关方程矩阵R0
sum=0;
p=1;%根据不同模型，选择p值，p=1为EXP模型，p=2为高斯模型，p属于（0，2）时为EXPG模型
for i=1:m
    for j=1:m
        for k=1:n
            sum=sum+sita(k)*abs(X(i,k)-X(j,k))^p;
        end
        R(i,j)=exp(-sum);
        sum=0;
    end
end
   % ones为生成全1矩阵
   F=base(X);
   %计算 beta参数
   M=F'*inv(R)*F;
   beta=inv(M)*F'*inv(R)*Y;
   N=Y-F*beta;
   sigama2=N'*inv(R)*N/m;
   f=0.5*(m*log(trace(sigama2))+log(det(R)));