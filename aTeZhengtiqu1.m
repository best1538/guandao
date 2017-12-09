%本函数用来产生SVM模型。
function[x_tezheng,columns]=aTeZhengtiqu1(Data)
%Data输入的数据为1*n的形式，number表示多少个算出一组特征值。
%seg表示有多少这样的组，x_tezheng为变换后的特征向量矩阵。
%行表示seg，即向量组的个数，列表示所提取特征值个数，本次用了
%sum_diff（差分和）;tfx_rms（方差）;tx_kurtosis（峭度）;Ef（能熵比）;p9（冲击值）
Data=shape(Data);%转换成1*n的形式
Data=(enframe(Data,1000,800))';
[~,seg]=size(Data);
number=1000;
% Data_diff=abs(Data(:,2:end)-Data(:,1:end-1));
% Data_diff=[Data_diff,Data_diff(:,end)];
% Data_diff=sum(Data_diff);
%%
%对特征进行提取
%%
%时域特征提取
%p1=power((sum(sqrt(abs(Data)))./number),2);%Square-mean-root
%p3=sqrt(sum(power(Data,2))/number);%Root-mean-square
% p7=p3./p2;%Shape factor   等于1
% p6=max(abs(Data))./p3;
% p8=max(abs(Data))./p1;%Clearance factor
p2=sum(abs(Data))/number;%Mean-absolute
p9=max(abs(Data))./p2;%Impulse Indicator
tx_kurtosis=kurtosis(Data);%峭度

%%
%频域指标
Y = fft(Data);
Y1 = 2*abs(Y/number);
Y1=Y1(2:number/2+1,:);
fx_kurtosis=kurtosis(Y1);%峭度

f1=power((sum(sqrt(abs(Y1)))./number),2);%Square-mean-root
f2=sum(abs(Y1))/number;%Mean-absolute
f3=sqrt(sum(power(Y1,2))/number);%Root-mean-square
f6=max(abs(Y1))./f3;%Crest factor
f7=f3./f2;%Shape factor   等于1
f8=max(abs(Y1))./f1;%Clearance factor
f9=max(abs(Y1))./f2;%Impulse Indicator
aparam=2;
for i=1:seg
    Sp = abs(fft(Data(:,i)));                % FFT变换取幅值
    Sp = Sp(1:number/2+1);	                 % 只取正频率部分
    Esum(i) = log10(1+sum(Sp.*Sp)/aparam);   % 计算对数能量值
    prob = Sp/(sum(Sp));		             % 计算概率
    H(i) = -sum(prob.*log(prob+eps));        % 求谱熵值
    Ef(i) = sqrt(1 + abs(Esum(i)/H(i)));     % 计算能熵比
end
columns=seg;
x_tezheng=[tx_kurtosis;p9;f6;f7;f8;f9;fx_kurtosis;Ef]';%BP不需要进行转置
end