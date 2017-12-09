%本函数用来产生SVM模型。且效果很不错。
function[x_tezheng,seg]=aTeZhengtiqu3(Data)
number=500;
inc=450;
a_Data=shape(Data);%转换成1*n的形式
Data=(enframe(a_Data,number,inc))';
[~,seg]=size(Data);
%%
%时域指标
Data_diff=abs(Data(:,2:end)-Data(:,1:end-1));
Data_diff=[Data_diff,Data_diff(:,end)];
Data_diff=sqrt(sum(power(Data_diff,2))/number);

p2=sum(abs(Data))/number;%Mean-absolute
p9=max(abs(Data))./p2;%效果比较好，可以作为端点检测。

p_r=periodogram(Data);
p_r=sum(p_r(2:251,:))/250;
%%
%频域指标
Y = abs(fft(Data));
aparam=2;
for i=1:seg
    Sp = abs(fft(Data(:,i)));                % FFT变换取幅值
    Sp = Sp(1:number/2+1);	                 % 只取正频率部分
    Esum(i) = log10(1+sum(Sp.*Sp)/aparam);   % 计算对数能量值
    prob = Sp/(sum(Sp));		             % 计算概率
    H(i) = -sum(prob.*log(prob+eps));        % 求谱熵值
    Ef(i) = sqrt(1 + abs(Esum(i)/H(i)));     % 计算能熵比
end

f1=power((sum(sqrt(abs(Y)))./number),2);%Square-mean-root
f2=sum(abs(Y))/number;%Mean-absolute
f3=sqrt(sum(power(Y,2))/number);%Root-mean-square
f6=max(abs(Y))./f3;%Crest factor

f7=f3./f2;%Shape factor   等于1
f8=max(abs(Y))./f1;%Clearance factor
f9=max(abs(Y))./f2;%Impulse Indicator
fx_kurtosis=kurtosis(Y);
x_tezheng=[Data_diff;p9;f6;f7;f8;f9;fx_kurtosis;Ef]';%BP不需要进行转置
end