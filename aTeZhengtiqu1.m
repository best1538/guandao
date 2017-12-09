%��������������SVMģ�͡�
function[x_tezheng,columns]=aTeZhengtiqu1(Data)
%Data���������Ϊ1*n����ʽ��number��ʾ���ٸ����һ������ֵ��
%seg��ʾ�ж����������飬x_tezhengΪ�任���������������
%�б�ʾseg����������ĸ������б�ʾ����ȡ����ֵ��������������
%sum_diff����ֺͣ�;tfx_rms�����;tx_kurtosis���Ͷȣ�;Ef�����رȣ�;p9�����ֵ��
Data=shape(Data);%ת����1*n����ʽ
Data=(enframe(Data,1000,800))';
[~,seg]=size(Data);
number=1000;
% Data_diff=abs(Data(:,2:end)-Data(:,1:end-1));
% Data_diff=[Data_diff,Data_diff(:,end)];
% Data_diff=sum(Data_diff);
%%
%������������ȡ
%%
%ʱ��������ȡ
%p1=power((sum(sqrt(abs(Data)))./number),2);%Square-mean-root
%p3=sqrt(sum(power(Data,2))/number);%Root-mean-square
% p7=p3./p2;%Shape factor   ����1
% p6=max(abs(Data))./p3;
% p8=max(abs(Data))./p1;%Clearance factor
p2=sum(abs(Data))/number;%Mean-absolute
p9=max(abs(Data))./p2;%Impulse Indicator
tx_kurtosis=kurtosis(Data);%�Ͷ�

%%
%Ƶ��ָ��
Y = fft(Data);
Y1 = 2*abs(Y/number);
Y1=Y1(2:number/2+1,:);
fx_kurtosis=kurtosis(Y1);%�Ͷ�

f1=power((sum(sqrt(abs(Y1)))./number),2);%Square-mean-root
f2=sum(abs(Y1))/number;%Mean-absolute
f3=sqrt(sum(power(Y1,2))/number);%Root-mean-square
f6=max(abs(Y1))./f3;%Crest factor
f7=f3./f2;%Shape factor   ����1
f8=max(abs(Y1))./f1;%Clearance factor
f9=max(abs(Y1))./f2;%Impulse Indicator
aparam=2;
for i=1:seg
    Sp = abs(fft(Data(:,i)));                % FFT�任ȡ��ֵ
    Sp = Sp(1:number/2+1);	                 % ֻȡ��Ƶ�ʲ���
    Esum(i) = log10(1+sum(Sp.*Sp)/aparam);   % �����������ֵ
    prob = Sp/(sum(Sp));		             % �������
    H(i) = -sum(prob.*log(prob+eps));        % ������ֵ
    Ef(i) = sqrt(1 + abs(Esum(i)/H(i)));     % �������ر�
end
columns=seg;
x_tezheng=[tx_kurtosis;p9;f6;f7;f8;f9;fx_kurtosis;Ef]';%BP����Ҫ����ת��
end