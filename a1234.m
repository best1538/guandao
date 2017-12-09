
clc
clear
load('qiao12_1_yes.mat')
load('qiao6_4_yes.mat')
load('qiao4_0_yes.mat')
load('qiao3_0_yes.mat')
load('pao5_1_yes.mat')
load('pao4_0_yes.mat')
load('pao3_0_yes.mat')
load('date16_2_yes.mat')
load('date11_3_yes.mat')
load('date7_6_yes_righ.mat')

load('pao6_4_yes_test.mat')
load('date16_2_yes_test.mat')
load('date11_3_yes_test.mat')
load('date7_6_yes_test_righ.mat')
load('date7_6_yes_test.mat')
load('rengong4_0_yes_test.mat')
[qiao12_1_yes] = shape1234(qiao12_1_yes);
[qiao3_0_yes] = shape1234(qiao3_0_yes);
[pao3_0_yes] = shape1234(pao3_0_yes);
[date16_2_yes_test] = shape1234(date16_2_yes_test);
[date16_2_yes] = shape1234(date16_2_yes);
[date11_3_yes_test] = shape1234(date11_3_yes_test);
[date11_3_yes] = shape1234(date11_3_yes);
win=300; inc=270;                 % 设置帧长、帧移
X1=enframe(qiao12_1_yes,win,inc)';            % 分帧
X2=enframe(qiao6_4_yes,win,inc)'; 
X3=enframe(qiao3_0_yes,win,inc)';

Y1=enframe(pao5_1_yes,win,inc)'; 
Y2=enframe(pao4_0_yes,win,inc)'; 
Y3=enframe(pao3_0_yes,win,inc)'; 
Y4_all=enframe(pao6_4_yes_test,win,inc)'; 
Y4=Y4_all(:,1:80);
Y_test=Y4_all(:,81:end);

Z1=enframe(date16_2_yes,win,inc)'; 
Z2=enframe(date11_3_yes,win,inc)'; 
Z3=enframe(date7_6_yes_righ,win,inc)'; 

Z_test1=enframe(date11_3_yes_test,win,inc)'; 
Z_test2=enframe(date7_6_yes_test_righ,win,inc)'; 
Z_test3=enframe(date16_2_yes_test,win,inc)'; 
Y_test1=enframe(pao6_4_yes_test,win,inc)'; 
X_test1=enframe(rengong4_0_yes_test,win,inc)'; 

X=[X1,X2,X3];
Y=[Y1,Y2,Y3,Y4];
Z=[Z1,Z2,Z3];
Z_test=[Z_test1,Z_test2,Z_test3];
Test=[X_test1,Y_test,Z_test]
[~,R]=size(X_test1);
[~,p]=size(Y_test);
[~,q]=size(Z_test);

[data_qiao,a]=TeZhengtiqu(X);
[data_pao,b]=TeZhengtiqu(Y);
[data_jixie,c]=TeZhengtiqu(Z);
[data_test,d]=TeZhengtiqu(Test);
x_train=cat(2,data_qiao,data_pao,data_jixie);
T1 = [repmat([1;0;0],1,a),repmat([0;1;0],1,b),repmat([0;0;1],1,c)];%敲击，刨，机械振动

%设置网络参数
net=feedforwardnet(17,'trainlm');  
net=init(net); 
net.trainParam.lr = 0.3;            % 学习步长 - traingd,traingdm
net.trainParam.epochs = 1000;       % 最大训练次数
net.trainParam.goal = 1e-8;         % 最小均方误差

% 训练与测试
net = train(net,x_train,T1);             % 训练
Y1 = sim(net,data_test); 
Y1(Y1>0.5)=1;
Y1(Y1<=0.5)=0;

x=[1;0;0];
y=[0;1;0];
z=[0;0;1];

x_num=0;
y_num=0;
z_num=0;

for h=1:R
    c=isequal(Y1(:,h),x);
    if(c==1)
        x_num=x_num+1;
    end
end
for i=R+1:R+p
    c=isequal(Y1(:,i),y);
    if(c==1)
        y_num=y_num+1;
    end
end
for j=R+p+1:R+p+q
    c=isequal(Y1(:,j),z);
    if(c==1)
        z_num=z_num+1;
    end
end

num=double(x_num+y_num+z_num);
p1=x_num/R;
p2=y_num/p;
p3=z_num/q;
p=num/d

save data_jixie.mat data_jixie;
save data_pao.mat data_pao;
save data_qiao.mat data_qiao;






