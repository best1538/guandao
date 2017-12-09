clc
clear

path_name='I:\项目数据\中卫预警系统项目\数据\二线人工\';
% path_name='C:\Program Files\MATLAB\fl\';
file_name='20170730100857_C1C2_32768_100000_2_8.fig';
h1 = openfig([path_name,'\',file_name],'reuse'); % open figure
observe_cfutline=1;
D1=get(gca,'Children'); %get the handle of the line object  
XData1=get(D1,'XData'); %get the x data  
YData1=get(D1,'YData'); %get the y data  
ZData1=get(D1,'ZData'); %get the y data  
a=0;
ob_x=1:4096;%1:length(XData1);%距离
ob_y=1:length(YData1);%时间
figure(2)
mesh(ob_x,ob_y,ZData1(ob_y,ob_x));
title(['第一通道','观察范围为时间',num2str(ob_y(1)),'至',num2str(ob_y(end)),'距离',num2str(ob_x(1)),'至',num2str(ob_x(end))])
view(0,90)
% figure(3)
% mesh(ob_x+length(XData1)/2,ob_y,ZData1(ob_y,ob_x+length(XData1)/2));
% title(['第二通道','观察范围为时间',num2str(ob_y(1)),'至',num2str(ob_y(end)),'距离',num2str(ob_x(1)+length(XData1)/2),'至',num2str(ob_x(end)+length(XData1)/2)])
% view(0,90)
if observe_cfutline==1
    for i=1:length(YData1)
    figure(3)
    plot(ZData1(i,:))
    ylim([0 12000])
    x1=1000;
    x2=3000;
    xlim([x1 x2])
    title(['观察范围为时间',num2str(x1),'至',num2str(x2),'时间序号为',num2str(i)])
    pause(0.3)
    end
end


