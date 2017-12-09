clc
clear
number=1000;
load('train_pao.mat');
load('train_qiao.mat');
load('train_wajue.mat');
load('no_train.mat');
load('wuajue16_10_3.mat'); wuajue16_10_3=wuajue16_10_3
x_test=wuajue16_10_3;
% load('net.mat');
[train_qiao,x1]=aTeZhengtiqu(qiao_train);
[train_pao,y1]=aTeZhengtiqu(pao_train);
[train_wajue,z1]=aTeZhengtiqu(wuajue_train);
[train_no,w1]=aTeZhengtiqu(no_train);
x_train=cat(2,train_qiao,train_pao,train_wajue,train_no);
T1 = [repmat([1;0;0;0],1,x1),repmat([0;1;0;0],1,y1),repmat([0;0;1;0],1,z1),repmat([0;0;0;1],1,w1)];%敲击，刨，机械振动，无。

%设置网络参数
net=feedforwardnet(35,'trainlm');  
net=init(net); 
net.trainParam.lr = 0.3;            % 学习步长 - traingd,traingdm
net.trainParam.epochs = 1000;       % 最大训练次数
net.trainParam.goal = 1e-8;         % 最小均方误差

% 训练与测试
net = train(net,x_train,T1);             % 训练

Y1 = sim(net,x_test); 
Y1(Y1>0.5)=1;
Y1(Y1<=0.5)=0;
% 
% x=[1;0;0;0];
% y=[0;1;0;0];
% z=[0;0;1;0];
% w=[0;0;0;1];
% x_num=0;
% y_num=0;
% z_num=0;
% u_num=0;
% for h=1:p
%     c=isequal(Y1(:,h),x);
%     if(c==1)
%         x_num=x_num+1;
%     end
% end
% for i=(p+1):(p+q)
%     c=isequal(Y1(:,i),y);
%     if(c==1)
%         y_num=y_num+1;
%     end
% end
% for j=(p+q+1):(p+q+r)
%     c=isequal(Y1(:,j),z);
%     if(c==1)
%         z_num=z_num+1;
%     end
% end
% for k=(p+q+r+1):(p+q+r+s)
%     c=isequal(Y1(:,k),w);
%     if(c==1)
%         u_num=u_num+1;
%     end
% end
% num=double(x_num+y_num+z_num+u_num);
% p=num/(p+q+r+s)



