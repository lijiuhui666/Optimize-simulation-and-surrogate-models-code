function MM= XOptimize(x1)
load('A.mat'); 
load X;
load('sita.mat');
load('beta1.mat'); 
load('beta2.mat'); 
load('beta3.mat'); 
load('beta4.mat'); 
load('gama1.mat'); 
load('gama2.mat'); 
load('gama3.mat');
load('gama4.mat');
load('ct.mat'); 
x=[x1(1,1),x1(1,2),x1(1,3),x1(1,4)];
[m,n]=size(X);
[m1,n1]=size(x);
s=0;
for i=1:n %4���������ά��
    x(:,i)=x(:,i)/A(i);
end
F1=base(x);
for i=1:m1
    for j=1:m
        for k=1:n
               s=s+sita(k)*abs(x(i,k)-X(j,k));
        end
        r1(i,j)=exp(-s);
        s=0;
    end
end
y1=F1*beta1+r1*gama1;%��ȾԴ1���ģ�͵����Ũ��

F2=base(x);
for i=1:m1
    for j=1:m
        for k=1:n
               s=s+sita(k)*abs(x(i,k)-X(j,k));
        end
        r2(i,j)=exp(-s);
        s=0;
    end
end
y2=F2*beta2+r2*gama2;%��ȾԴ2���ģ�͵����Ũ��

F3=base(x);
for i=1:m1
    for j=1:m
        for k=1:n
               s=s+sita(k)*abs(x(i,k)-X(j,k));
        end
        r3(i,j)=exp(-s);
        s=0;
    end
end
y3=F3*beta3+r3*gama3;%��ȾԴ3���ģ�͵����Ũ��

F4=base(x);
for i=1:m1
    for j=1:m
        for k=1:n
               s=s+sita(k)*abs(x(i,k)-X(j,k));
        end
        r4(i,j)=exp(-s);
        s=0;
    end
end
y4=F4*beta4+r4*gama4;%��ȾԴ4���ģ�͵����Ũ��
y=x1(1,5)*y1+x1(1,6)*y2+x1(1,7)*y3+x1(1,8)*y4;
MM=sum((y-ct).^2);
end

