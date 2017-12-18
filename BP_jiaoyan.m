%%校验BP正确率
clc
clear
load('no_1.mat');
load('no_2.mat');
load('qiao_train.mat');
load('pao_train.mat');
load('wuajue_train.mat');
load('net.mat','net');
load('anet.mat')
wuajue_train_bp1=wuajue_train(1,1000000:5500000);%这里只要挖掘一般的数据
no_train=[no_1,no_2];
vibration_train=[qiao_train,pao_train,wuajue_train_bp1];
[vibration_train,x1]=aTeZhengtiqu3(vibration_train);
% [no_train,y1]=aTeZhengtiqu3(no_train);  
% y1_1=floor(0.8*y1);
x1_1=floor(0.8*x1);
x_test=vibration_train(:,x1_1+1:x1_1+1000);
[~,p]=size(x_test);
% y_test=vibration_train(:,y1_1+1:y1_1+1000);
% [~,q]=size(y_test);
test=[x_test];
Y1 = sim(net,test); 
Y1(Y1>0.5)=1;
Y1(Y1<=0.5)=0;
x=[0;1];
% y=[1;0];
x_num=0;
% y_num=0;
 for h=1:p
    c=isequal(Y1(:,h),x);
    if(c==1)
        x_num=x_num+1;
    end
end
% for i=(p+1):(p+q)
%     c=isequal(Y1(:,i),y);
%     if(c==1)
%         y_num=y_num+1;
%     end
% end
bp1_1=x_num/p
% bp1_2=y_num/q
% bp1=(x_num+y_num)/(p+q)
%%
[qiao_train,x1]=aTeZhengtiqu3(qiao_train);
[pao_train,y1]=aTeZhengtiqu3(pao_train);
[wuajue_train,z1]=aTeZhengtiqu3(wuajue_train);  
% qiao_train=qiao_train(:,1:2:end);
% wuajue_train=wuajue_train(:,1:7:end);
z_test1=pao_train(:,3:7:end);
x_test1=wuajue_train(:,1:4:end);
y_test1=qiao_train(:,1:3:end);
[~,a]=size(x_test1);
[~,b]=size(y_test1);
[~,d]=size(z_test1);
bp2_test=[x_test1,y_test1,z_test1];
load('bnet.mat')
Y1 = sim(net,bp2_test); 
Y1(Y1>0.5)=1;
Y1(Y1<=0.5)=0;
x=[1;0;0];
y=[0;1;0];
z=[0;0;1];
x_num=0;
y_num=0;
z_num=0;
for h=1:a
    c=isequal(Y1(:,h),x);
    if(c==1)
        x_num=x_num+1;
    end
end
for i=(a+1):(a+b)
    c=isequal(Y1(:,i),y);
    if(c==1)
        y_num=y_num+1;
    end
end
for j=(a+b+1):(a+b+d)
    c=isequal(Y1(:,j),z);
    if(c==1)
        z_num=z_num+1;
    end
end
num=double(x_num+y_num+z_num);
bp_2_1=x_num/a
bp_2_2=y_num/b
bp_2_3=z_num/c
bp_2=num/(a+b+d)



