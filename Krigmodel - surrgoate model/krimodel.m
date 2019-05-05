% ����Kriging���ģ�ͺ�����������8������2��Դ����4��ʱ�ε�ǿ��
function EST_Y=krimodel(X)
load('sita.txt')   % load sita
load('Input_X.mat');  % input ,known
load('Input_Y.mat');  % output
EST_X=X;
[m0,n0]=size(Input_X);  % ��� ���� ����������m*n ,�ں������sigma2���õ�m 
[m1,n1]=size(EST_X);
tt0=numel(Input_X);
tt1=numel(EST_X);
Input_X=reshape(Input_X,tt0,1);   % �������Ϊ������������ʹ��ѭ��,ע�����Ƿ������ȷ!!
EST_X=reshape(EST_X,tt1,1);
%���������ݹ�һ���� �ȱ�Ϊһά����������һ��������ٱ�� m*n!
GYinput_x=Input_X';
GYest_x=EST_X';
[rt,PS]=mapminmax(GYinput_x,0,1);
A2=mapminmax('apply',GYest_x,PS);
GYinput_x=reshape(rt',m0,n0);  %  ��һ�������֪����������
GYest_x=reshape(A2',m1,n1);    %  ��һ�����δ֪������
%% ������֪���ݵ��Ŀռ���ط��̾���R0
r0=[];
R0=zeros(m0);
for k=1:n0              %  ���n ��ʾ���ǲ������ά������һ�����������������ָ������������Ϊ3
  for i=1:m0
    for j=1:m0
        r0=[r0,exp(-sita(k)*abs(GYinput_x(i,k)-GYinput_x(j,k))^2)]; % sita(k) Ϊ���������Ŀǰ��δ����� k��ͬ��sitaҲ��ͬ��
    end
  end
end
for t=1:n0      
    rt=r0(:,1+(t-1)*m0^2:t*m0^2);
    rt=reshape(rt,m0,m0); 
    R0=R0+rt';      %R0Ϊ��֪������֮��Ŀռ���ط��̾�������� R ��ʾδ֪�����㣨�������㣩�����֪�������Ŀռ���ط��̾���
end 
  F=ones(m0,1);  % onesΪ����ȫ1����
   %���� beta����
   M=F'*inv(R0)*F;
   beta=inv(M)*F'*inv(R0)*Input_Y;   % beta��������Train_Y  ��������ͬ��ÿһ�е�beta�Ƿֿ�����ģ�����Ԥ��ʱҲ�Ƿֿ����㣡
   gama=inv(R0)*(Input_Y-F*beta);  

   %%  ����δ֪������֪��֮�����ط��̾��� rt(ÿһ��δ֪���Ӧһ����)
 r1=[];
for i1=1:m1              %  ���n ��ʾ���ǲ������ά������һ�����������������ָ������������Ϊ3
  for j1=1:m0
    for k1=1:n1
        r1=[r1,exp(-sita(k1)*abs(GYest_x(i1,k1)-GYinput_x(j1,k1))^2)]; % sita(k) Ϊ�������������GA�㷨Ѱ�š�
    end
  end
end
rt=[];
  for t1=1:(numel(r1)/n1)     
    rt(t1,:)=r1(:,1+(t1-1)*n1:t1*n1);   % �����СΪ t*n1 
  end 
    rt=sum(rt,2);
 %%  ����δ֪��Ĺ���ֵy��x��
    EST_Y=[];
    rT=[];     % �൱�������е�r��x����ת��
    for p=1:m1
        rT=rt(1+(p-1)*m0:p*m0,:);  
        rT=rT';
        Q=rT*gama;
        yx=beta+Q;
        EST_Y=[EST_Y;yx];
    end
   