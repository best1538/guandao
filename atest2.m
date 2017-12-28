clear
clc
load('H:\data\20170730101109.mat');
Ef_all=[];
Data_diff_all=[];
pt5_all=[];
for j=372:372
    Data=double(data_c1(j,:));
    number=400;
    [m,~]=size(Data);
    if m==1
        inc=200;
        Data=(enframe(Data,number,inc))';
    end
    [~,seg]=size(Data);
    aparam=2;
    for i=1:seg
        Sp = abs(fft(Data(:,i)));                % FFT变换取幅值
        Sp = Sp(1:number/2+1);	                 % 只取正频率部分
        Esum(i) = log10(1+sum(Sp.*Sp)/aparam);   % 计算对数能量值
        prob = Sp/(sum(Sp));		             % 计算概率
        H(i) = -sum(prob.*log(prob+eps));        % 求谱熵值
        Ef(i) = sqrt(1 + abs(Esum(i)/H(i)));     % 计算能熵比
    end
    Ef_all=[Ef_all,Ef];
    pt1=mean(Data);%平均值
    pt3=max(Data);%峰值
    pt5=pt3./pt1;%脉冲指标
    pt5_all=[pt5_all,pt5];
    %时域指标
    Data_diff=abs(Data(number/2+1:end,:)-Data(1:number/2,:));
    Data_diff=sqrt(sum(power(Data_diff,2))/number/2);
    Data_diff_all=[Data_diff_all,Data_diff];
end
a=mean(Data_diff_all);
b=mean(pt5_all);
c=mean(Ef);
% save('D:\Data_diff_all.mat','Data_diff_all') 
% save('D:\pt5_all.mat','pt5_all') 
% save('D:\Ef.mat','Ef') 