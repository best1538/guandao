clc
clear
load('C:\Program Files\MATLAB\data\20170730101742.mat')
a=data_c1(926,:);
load('C:\Program Files\MATLAB\data\20170730103048.mat')
b=data_c1(926,:);
load('C:\Program Files\MATLAB\data\20170730104355.mat')
c=data_c1(926,:);
load('C:\Program Files\MATLAB\data\20170730111008.mat')
d=data_c1(926,:);
load('C:\Program Files\MATLAB\data\20170802123506.mat')
e=data_c1(926,:);
load('C:\Program Files\MATLAB\data\20170802125656.mat')
f=data_c1(926,:);
load('C:\Program Files\MATLAB\data\20170802164914.mat')
g=data_c1(926,:);
subplot(7,1,1);
plot(a);
subplot(7,1,2);
plot(b);
subplot(7,1,3);
plot(c);
subplot(7,1,4);
plot(d);
subplot(7,1,5);
plot(e);
title('7.6km机械挖掘处')
xlabel('点')
ylabel('幅值')
subplot(7,1,6);
plot(f);
subplot(7,1,7);
plot(g);
suptitle('7.6km处机械挖掘不同时刻振动')






