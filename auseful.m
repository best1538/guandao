%%
%����ѭ������Ҫ
[p,~]=size(filename);
pathname='I:\data\';
for z=1:p
    name_file= filename(z,1:14);
    load([pathname name_file '.mat']);
    a=data_c1(1,:);
    save(['a',num2str(name_file(1:14)),'.mat'],'a')%�������ݵ���ǰĿ¼��
end
%����·��ʱ����
save(strcat('D:\','final',num2str(name_file(1:14)),'.mat'),'a');

%����ʱѭ��������
strcat('0',num2str(i),'time');
%%Ԥ�ȷ����ڴ档
x = zeros(1, 1000);
%%�ɽ���ĺ���
%%
%ѭ�������������
p=[p1;p2;p3;p5;p6;p7;p8;p9]
for i=1:9
    subplot(9,1,i);
    plot(p(i,:));
end
%%i���ܴ�0��ʼ������֮��
for i=(0:m-1)*number
    data_sum=sum(Data(i:i+500,:))
    c=cat(1,c,data_sum);
end
%%ѭ��������ͼ��
%saveas(gcf,['D:\��Ŀ����\ͼ��\',num2str(i),'pao3']);
close(gcf)

saveas(gcf,['D://give/your/path/here/',''filename',bmp);

%������D://give/your/path/here/ �ĳ�����Ҫ�ĵ�ַ�Ϳ�����
%%
%����Ҷ�任
Y = fft(Data);
P2 = abs(Y/L);
P1 = P2(1:L/2+1); %�ͽ�������ʽ�ӳ�N����2����ʾ�����ķ�ֵ
P1(2:end-1) = 2*P1(2:end-1);
%%
%./����ʵ���ڲ����Զ�Ӧ��֮������㡣
%%
%abs�ɱ�ʾģֵ
Y = fft(Data);
P2 = abs(Y);%������(a^2+b^2)^0.5
%%
%������ÿ��ʮ�����עһ��
plot(1000*t(1:50),X(1:50))
%%
%����������������ִ�С�
if n==0
    return
end
b=find(a>10)
%%
svmtrain  svmclassify
%%
%title����ͼ�����ơ��� �������ڵ������ڣ�  xlabel����x��˵������  ylabel����y��˵������
%text��x��y����ͼ��˵������ suptitle
%% ������Ϊfs���ź���STFT: ���ź��ó���Ϊwin�Ĵ��ָ������֡��֡��֮֡���غϵĳ���Ϊnoverlap��ÿһ֡����FFT���ص�Ƶ������Ϊnfft
%(Ҳ�����趨Ƶ��ֱ���Ϊfs/nfft)�����ص�F��T��P��ÿһ��ֵ������ÿһ֡��ÿ��Ƶ���µĹ������ܶȡ�
[S,F,T,P] = spectrogram(a,win,noverlap,nfft,fs)
%% load
load('C:\Program Files\MATLAB\fldata\date16_2_yes.mat')
%% С����������
wavemenu
%% repmat
repmat([1;0;0],1,a)
%% reshape
Data=reshape(Data,number,seg);
%% save��������
save('D:\\jingyan\\example.mat','A') 
saveas(gcf,'pao3','fig')
%% �����ҳ��������ź�
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

%% ���õ����

[x_train,n]=TeZhengtiqu(X1);
t=1:n;
hCircle = figure('Visible', 'on');
set(hCircle,'position',[50 50 1200 500]);
for i=1:7  %����Ӵ���1�Ŀ�ʼ
    subplot(4,3,i);
    data_a=x_train(i,:);
    plot(t,data_a);
end
%% threshold

function [a,b]=threshold (data,number)%th1Ϊ����ֵ��th2Ϊ����ֵ
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

