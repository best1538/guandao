%%
%用的时候把后面的注释掉，单独用。
%abp训练
clc
clear
load('no_1.mat');
load('no_2.mat');

% no_1=cut_wave(no_1)     %进行滤波处理
% no_2=cut_wave(no_2)

[no_1,~]=aTeZhengtiqu3(no_1); 
no_1=no_1(:,1:2:end)
[~,a]=size(no_1);
[no_2,~]=aTeZhengtiqu3(no_2);
no_2=no_2(:,1:2:end)
[~,b]=size(no_2);
load('qiao_train.mat');
load('pao_train.mat');
load('wuajue_train.mat');

% qiao_train=cut_wave(qiao_train);
% pao_train=cut_wave(pao_train);
% wuajue_train=cut_wave(wuajue_train);



wuajue_train_bp1=wuajue_train(1,1000000:6500000);%这里只要挖掘一般的数据
no_train=[no_1,no_2];
vibration_train=[qiao_train,pao_train,wuajue_train_bp1];
[vibration_train,x1]=aTeZhengtiqu3(vibration_train);
y1_1=floor(0.8*(a+b));
x1_1=floor(0.8*x1);
no_train_n0=no_train(:,1:y1_1);
vibration_train_yes=vibration_train(:,1:x1_1);
x_train=cat(2,no_train_n0,vibration_train_yes);
T1 = [repmat([1;0],1,y1_1),repmat([0;1],1,x1_1)];%敲击，刨，机械振动，无。
x_test=vibration_train(:,x1_1+1:x1_1+1000);
%设置网络参数
net=newff(x_train,T1,[9,9]);
% net=feedforwardnet(16,'trainlm');  
net.trainParam.lr = 0.1;            % 学习步长 - traingd,traingdm
net.trainParam.epochs = 1000;       % 最大训练次数
net.trainParam.goal = 1e-5;         % 最小均方误差原来为10的-8
% 训练与测试
net = train(net,x_train,T1);             % 训练
save('a_400_200net.mat','net')
%%
%bp2训练
[qiao_train,x1]=aTeZhengtiqu3(qiao_train);
[pao_train,y1]=aTeZhengtiqu3(pao_train);
[wuajue_train,z1]=aTeZhengtiqu3(wuajue_train);  
qiao_train=qiao_train(:,1:2:end);
wuajue_train=wuajue_train(:,1:7:end);
x_train=cat(2,wuajue_train,qiao_train,pao_train);
[~,qiao_train_num]=size(qiao_train);
[~,wuajue_train_num]=size(wuajue_train);

T1 = [repmat([1;0;0],1,wuajue_train_num),repmat([0;1;0],1,qiao_train_num),repmat([0;0;1],1,y1)];%敲击，刨，机械振动，无。
x_test=pao_train(:,3:7:end);
[~,x_test_num]=size(x_test);
%设置网络参数
net=newff(x_train,T1,[9,9]);
% net=feedforwardnet(16,'trainlm');  
net.trainParam.lr = 0.1;            % 学习步长 - traingd,traingdm
net.trainParam.epochs = 1000;       % 最大训练次数
net.trainParam.goal = 1e-5;         % 最小均方误差原来为10的-8
% 训练与测试
net = train(net,x_train,T1);             % 训练
save('b_400_200net.mat','net')

