function [ y] = Kriging( X,Y,x )
%KRIGING 不同的输出用相同的sita模拟
%   Detailed explanation goes here
save X X;
save Y Y;
[m,n]=size(X);
[m1,n1]=size(x);
sum=0;
A=max(X);
for i=1:n
    X(:,i)=X(:,i)/A(i);
    x(:,i)=x(:,i)/A(i);
end
%对输入进行归一化
F=base(X);
sita0=ones(1,n);
sita=fminunc('solsita',sita0);
R=R1(sita,X);
M=F'*inv(R)*F;
beta=inv(M)*F'*inv(R)*Y; 
gama=inv(R)*(Y-F*beta);
F0=base(x);
for i=1:m1
    for j=1:m
        for k=1:n
               sum=sum+sita(k)*abs(x(i,k)-X(j,k));
        end
        r(i,j)=exp(-sum);
        sum=0;
    end
end
y=F0*beta+r*gama;
end

