function [f] = sita(X,Y,sita)
%SITA Summary of this function goes here
%   Detailed explanation goes here
[m,n]=size(X);
F=base(X);
sum=0;
p=1
for i=1:m
    for j=1:m
        for k=1:n
            sum=sum+sita(k)*abs(X(i,k)-X(j,k))^p
        end
        R(i,j)=exp(-sum);
        sum=0;
    end
end
M=F'*inv(R)*F;
beta=inv(M)*F'*inv(R)*Y;
N=Y-F*beta;
sigama2=N'*inv(R)*N/m;
f=0.5*(m*log(sigama2)+log(det(R)));

end

