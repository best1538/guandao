%%
%变量循环超重要
[p,~]=size(filename);
pathname='I:\data\';
for z=1:p
    name_file= filename(z,1:14);
    load([pathname name_file '.mat']);
    a=data_c1(1,:);
    save(['a',num2str(name_file(1:14)),'.mat'],'a')%保存数据到当前目录下
end
%加入路径时保存
save(strcat('D:\','final',num2str(name_file(1:14)),'.mat'),'a');

%连接时循环变量、
strcat('0',num2str(i),'time');
%%预先分配内存。
x = zeros(1, 1000);
%%可借鉴的函数
%%
%循环变量的输出。
p=[p1;p2;p3;p5;p6;p7;p8;p9]
for i=1:9
    subplot(9,1,i);
    plot(p(i,:));
end
%%i不能从0开始，错误之处
for i=(0:m-1)*number
    data_sum=sum(Data(i:i+500,:))
    c=cat(1,c,data_sum);
end
%%循环中生成图像
%saveas(gcf,['D:\项目数据\图像\',num2str(i),'pao3']);
close(gcf)

saveas(gcf,['D://give/your/path/here/',''filename',bmp);

%在这里D://give/your/path/here/ 改成你需要的地址就可以了
%%
%傅里叶变换
Y = fft(Data);
P2 = abs(Y/L);
P1 = P2(1:L/2+1); %和接下来的式子除N乘以2，表示真正的幅值
P1(2:end-1) = 2*P1(2:end-1);
%%
%./可以实现内部各自对应点之间的运算。
%%
%abs可表示模值
Y = fft(Data);
P2 = abs(Y);%即根号(a^2+b^2)^0.5
%%
%横坐标每五十个点标注一次
plot(1000*t(1:50),X(1:50))
%%
%满足条件后不再向下执行。
if n==0
    return
end
b=find(a>10)
%%
svmtrain  svmclassify
%%
%title（’图形名称’） （都放在单引号内）  xlabel（’x轴说明’）  ylabel（’y轴说明’）
%text（x，y，’图形说明’） suptitle
%% 采样率为fs的信号做STFT: 把信号用长度为win的窗分割成若干帧，帧与帧之间重合的长度为noverlap，每一帧下做FFT返回的频率数量为nfft
%(也就是设定频域分辨率为fs/nfft)。返回的F，T，P中每一个值代表是每一帧下每个频率下的功率谱密度。
[S,F,T,P] = spectrogram(a,win,noverlap,nfft,fs)
%% load
load('C:\Program Files\MATLAB\fldata\date16_2_yes.mat')
%% 小波包工具箱
wavemenu
%% repmat
repmat([1;0;0],1,a)
%% reshape
Data=reshape(Data,number,seg);
%% save语句的运用
save('D:\\jingyan\\example.mat','A') 
saveas(gcf,'pao3','fig')
%% 用来找出振动完整信号
clc
clear
load('20170730101532.mat')
a1=data_c1(375,:);
load('20170730101742.mat')
b1=data_c1(375,:);
pao3=[a1,b1];
save pao3.mat pao3
load('20170730100646.mat')
a1=data_c1(375,:);
load('20170730100857.mat')
b1=data_c1(375,:);
load('20170730101109.mat')
c1=data_c1(375,:);
% c=[a1,b1];
qiao3=[a1,b1,c1];
save qiao3.mat qiao3

%% 有用的语句

[x_train,n]=TeZhengtiqu(X1);
t=1:n;
hCircle = figure('Visible', 'on');
set(hCircle,'position',[50 50 1200 500]);
for i=1:7  %必须从大于1的开始
    subplot(4,3,i);
    data_a=x_train(i,:);
    plot(t,data_a);
end
%% threshold

function [a,b]=threshold (data,number)%th1为上阈值，th2为下阈值
[Data2,seg] = shape(data,number);
for i=1:seg
    x_mean=mean(Data2(:,i));
    x_max=max(Data2(:,i));
    if x_mean>0.075*x_max
        th1=0.015*x_max;
        th2=0.005*x_max;
        
    else
        th1=0.05*x_max;
        th2=0.01*x_max;
    end
    a(i)=th1;
    b(i)=th2;
    
end
end
% 
%% 

