%��������������SVMģ�͡���Ч���ܲ���
function[x_tezheng,seg]=aTeZhengtiqu3(Data)
number=500;
inc=450;
a_Data=shape(Data);%ת����1*n����ʽ
Data=(enframe(a_Data,number,inc))';
[~,seg]=size(Data);
%%
%ʱ��ָ��
Data_diff=abs(Data(:,2:end)-Data(:,1:end-1));
Data_diff=[Data_diff,Data_diff(:,end)];
Data_diff=sqrt(sum(power(Data_diff,2))/number);

p2=sum(abs(Data))/number;%Mean-absolute
p9=max(abs(Data))./p2;%Ч���ȽϺã�������Ϊ�˵��⡣

p_r=periodogram(Data);
p_r=sum(p_r(2:251,:))/250;
%%
%Ƶ��ָ��
Y = abs(fft(Data));
aparam=2;
for i=1:seg
    Sp = abs(fft(Data(:,i)));                % FFT�任ȡ��ֵ
    Sp = Sp(1:number/2+1);	                 % ֻȡ��Ƶ�ʲ���
    Esum(i) = log10(1+sum(Sp.*Sp)/aparam);   % �����������ֵ
    prob = Sp/(sum(Sp));		             % �������
    H(i) = -sum(prob.*log(prob+eps));        % ������ֵ
    Ef(i) = sqrt(1 + abs(Esum(i)/H(i)));     % �������ر�
end

f1=power((sum(sqrt(abs(Y)))./number),2);%Square-mean-root
f2=sum(abs(Y))/number;%Mean-absolute
f3=sqrt(sum(power(Y,2))/number);%Root-mean-square
f6=max(abs(Y))./f3;%Crest factor

f7=f3./f2;%Shape factor   ����1
f8=max(abs(Y))./f1;%Clearance factor
f9=max(abs(Y))./f2;%Impulse Indicator
fx_kurtosis=kurtosis(Y);
x_tezheng=[Data_diff;p9;f6;f7;f8;f9;fx_kurtosis;Ef]';%BP����Ҫ����ת��
end