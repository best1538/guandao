clear
clc
% temp1=[];
% fzzb=[];
% power=[];
% temp=[];
% windows=1000;
% move_windows=500;
% load('H:\ͨ������\20170730100857.mat'); 
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

% load('D:\��������\���������\a20170730100434.mat'); 
% name_file='20170730100434';
%     imagesc(state);  %�������е�Ԫ�ذ���ֵ��С�Ĳ�ͬת���ɲ�ͬ��ɫ�������������϶�Ӧλ����������ɫȾɫ��
%     colormap(flipud(gray));
%     ylabel('1��4096��');xlabel('��130���ڷ������ֵ�ʱ��')
%     save(strcat('D:\��������\12.25ͼ��mat\','a',num2str(name_file(1:14)),'.mat'),'state');
%     saveas(gcf,strcat('D:\��������\12.25ͼ��mat\','a',num2str(name_file(1:14)),'.tif'));
load('H:\ͨ������\20170730100857.mat'); 
Data1=data_c1(360,1:end);
Data1_1=cut_wave(Data1);
subplot(6,1,1)
plot(Data1_1)
number=1000;
inc=500;
Data1=(enframe(Data1,number,inc))';
pt2=rms(Data1);%������
pt3=max(Data1);%��ֵ
pt4=pt3./pt2;%��ֵָ��
pt7=kurtosis(Data1);%�Ͷ�
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
% pt2=rms(Data2);%������
% pt3=max(Data2);%��ֵ
% pt4=pt3./pt2;%��ֵָ��
% pt7=kurtosis(Data2);%�Ͷ�
% subplot(6,1,5)
% plot(pt4)
% subplot(6,1,6)
% plot(pt7)

