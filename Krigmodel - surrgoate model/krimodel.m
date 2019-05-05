% 建立Kriging替代模型函数，变量有8个，即2个源各自4个时段的强度
function EST_Y=krimodel(X)
load('sita.txt')   % load sita
load('Input_X.mat');  % input ,known
load('Input_Y.mat');  % output
EST_X=X;
[m0,n0]=size(Input_X);  % 求得 输入 的行列数，m*n ,在后面计算sigma2中用到m 
[m1,n1]=size(EST_X);
tt0=numel(Input_X);
tt1=numel(EST_X);
Input_X=reshape(Input_X,tt0,1);   % 将输入变为列向量，方便使用循环,注意检查是否变形正确!!
EST_X=reshape(EST_X,tt1,1);
%将输入数据归一化！ 先变为一维行向量，归一化计算后，再变回 m*n!
GYinput_x=Input_X';
GYest_x=EST_X';
[rt,PS]=mapminmax(GYinput_x,0,1);
A2=mapminmax('apply',GYest_x,PS);
GYinput_x=reshape(rt',m0,n0);  %  归一化后的已知点输入数据
GYest_x=reshape(A2',m1,n1);    %  归一化后的未知点输入
%% 计算已知数据点间的空间相关方程矩阵R0
r0=[];
R0=zeros(m0);
for k=1:n0              %  这里，n 表示的是采样点的维数，即一个采样点输入包括的指标数，本例中为3
  for i=1:m0
    for j=1:m0
        r0=[r0,exp(-sita(k)*abs(GYinput_x(i,k)-GYinput_x(j,k))^2)]; % sita(k) 为待求参数，目前还未解决！ k不同，sita也不同！
    end
  end
end
for t=1:n0      
    rt=r0(:,1+(t-1)*m0^2:t*m0^2);
    rt=reshape(rt,m0,m0); 
    R0=R0+rt';      %R0为已知采样点之间的空间相关方程矩阵！下面的 R 表示未知采样点（即待估点）与各已知采样点间的空间相关方程矩阵！
end 
  F=ones(m0,1);  % ones为生成全1矩阵
   %计算 beta参数
   M=F'*inv(R0)*F;
   beta=inv(M)*F'*inv(R0)*Input_Y;   % beta的列数与Train_Y  的列数相同，每一列的beta是分开计算的，最终预测时也是分开计算！
   gama=inv(R0)*(Input_Y-F*beta);  

   %%  计算未知点与已知点之间的相关方程矩阵 rt(每一个未知点对应一个！)
 r1=[];
for i1=1:m1              %  这里，n 表示的是采样点的维数，即一个采样点输入包括的指标数，本例中为3
  for j1=1:m0
    for k1=1:n1
        r1=[r1,exp(-sita(k1)*abs(GYest_x(i1,k1)-GYinput_x(j1,k1))^2)]; % sita(k) 为待求参数，利用GA算法寻优。
    end
  end
end
rt=[];
  for t1=1:(numel(r1)/n1)     
    rt(t1,:)=r1(:,1+(t1-1)*n1:t1*n1);   % 矩阵大小为 t*n1 
  end 
    rt=sum(rt,2);
 %%  计算未知点的估计值y（x）
    EST_Y=[];
    rT=[];     % 相当于文献中的r（x）的转置
    for p=1:m1
        rT=rt(1+(p-1)*m0:p*m0,:);  
        rT=rT';
        Q=rT*gama;
        yx=beta+Q;
        EST_Y=[EST_Y;yx];
    end
   