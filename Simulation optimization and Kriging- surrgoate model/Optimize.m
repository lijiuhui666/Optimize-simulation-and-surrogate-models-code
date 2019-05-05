
function MM= Optimize(x)
load('X.mat'); 
load('Y.mat'); 
load('sita.mat');
[m,n]=size(X);
[m1,n1]=size(x);
s=0;
A=max(X);
for i=1:n
    X(:,i)=X(:,i)/A(i);
    x(:,i)=x(:,i)/A(i);
end
F=base(X);
R=R1(sita,X);
M=F'*inv(R)*F;
beta=inv(M)*F'*inv(R)*Y; 
gama=inv(R)*(Y-F*beta);
F0=base(x);
for i=1:m1
    for j=1:m
        for k=1:n
               s=s+sita(k)*abs(x(i,k)-X(j,k));
        end
        r(i,j)=exp(-s);
        s=0;
    end
end
y=F0*beta+r*gama;
load('ct.mat'); 
MM=sum((y-ct).^2);
end
