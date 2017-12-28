%本函数用来产生SVM模型。且效果很不错。
function[x_tezheng,seg]=aTeZhengtiqu3(Data)
Data=double(Data);
number=500;
%%注释处为svm_product使用，使用时把注释注释掉。
[m,~]=size(Data);
if m==1
    inc=400;
    Data=(enframe(Data,number,inc))';
end
[~,seg]=size(Data);

pt1=mean(Data);%平均值
% pt2=rms(Data);%均方差
pt3=max(Data);%峰值
% pt4=pt3./pt2;%峰值指标
pt5=pt3./pt1;%脉冲指标
pt7=kurtosis(Data);%峭度
%%
%时域指标
Data_diff=abs(Data(number/2+1:end,:)-Data(1:number/2,:));
Data_diff=sqrt(sum(power(Data_diff,2))/number/2);
%     Data_diff=abs(Data(number/2+1:end,:)-Data(1:number/2,:));
%     Data_diff=sqrt(sum(power(Data_diff,2))/number/2);
%%
%频域指标
Y = abs(fft(Data));
aparam=2;
Esum=zeros(1,seg);
H=zeros(1,seg);
Ef=zeros(1,seg);
for i=1:seg
    Sp = abs(fft(Data(:,i)));                % FFT变换取幅值
    Sp = Sp(1:number/2+1);	                 % 只取正频率部分
    Esum(i) = log10(1+sum(Sp.*Sp)/aparam);   % 计算对数能量值
    prob = Sp/(sum(Sp));		             % 计算概率
    H(i) = -sum(prob.*log(prob+eps));        % 求谱熵值
    Ef(i) = sqrt(1 + abs(Esum(i)/H(i)));     % 计算能熵比
end
Sp = abs(fft(Data));         % FFT变换取幅值
Sp = Sp(2:number/2+1,:);
sp=log(std(Sp));

f1=power((sum(sqrt(abs(Y)))./number),2);%Square-mean-root
f2=sum(abs(Y))/number;%Mean-absolute
f3=sqrt(sum(power(Y,2))/number);%Root-mean-square
% f6=max(abs(Y))./f3;%Crest factor

f7=f3./f2;%Shape factor   等于1
f8=max(abs(Y))./f1;%Clearance factor
f9=max(abs(Y))./f2;%Impulse Indicator
pf2=var(Y);%频域方差
pf3=mean(Y);%频域平均值
x_tezheng=[Data_diff;pt5;pt7;f7;f8;f9;pf2;pf3;Ef;sp];%BP结果形式为15*72668的形式
end