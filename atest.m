clear
clc
% temp1=[];
% fzzb=[];
% power=[];
% temp=[];
% windows=1000;
% move_windows=500;
% load('H:\通道数据\20170730100857.mat'); 
% [m,n]=size(data_c1);
% for i=1:m
%     for j=0:(floor(n-windows)/move_windows)-1
%         c=data_c1(i,move_windows*(j+1)+1:move_windows*(j+1)+windows);
%         d=max(c);
%         e=rms(c');
%         f=d./e;
%         temp1=[temp1,f]
%          
%     end
%     temp1=[];
% end

% load('D:\处理数据\处理后数据\a20170730100434.mat'); 
% name_file='20170730100434';
%     imagesc(state);  %将矩阵中的元素按数值大小的不同转化成不同颜色，并在坐标轴上对应位置以这种颜色染色。
%     colormap(flipud(gray));
%     ylabel('1到4096点');xlabel('在130秒内发生入侵的时间')
%     save(strcat('D:\处理数据\12.25图和mat\','a',num2str(name_file(1:14)),'.mat'),'state');
%     saveas(gcf,strcat('D:\处理数据\12.25图和mat\','a',num2str(name_file(1:14)),'.tif'));
load('H:\通道数据\20170730100857.mat'); 
Data1=data_c1(360,1:end);
Data1_1=cut_wave(Data1);
subplot(6,1,1)
plot(Data1_1)
number=1000;
inc=500;
Data1=(enframe(Data1,number,inc))';
pt2=rms(Data1);%均方差
pt3=max(Data1);%峰值
pt4=pt3./pt2;%峰值指标
pt7=kurtosis(Data1);%峭度
subplot(6,1,2)
plot(pt4)
subplot(6,1,3)
plot(pt7)
% 
% Data2=data_c2(360,1:end);
% Data2_2=cut_wave(Data2);
% Data1_1=cut_wave(Data1);
% subplot(6,1,4)
% plot(Data2_2)
% number=400;
% inc=200;
% Data2=(enframe(Data2,number,inc))';
% pt2=rms(Data2);%均方差
% pt3=max(Data2);%峰值
% pt4=pt3./pt2;%峰值指标
% pt7=kurtosis(Data2);%峭度
% subplot(6,1,5)
% plot(pt4)
% subplot(6,1,6)
% plot(pt7)

