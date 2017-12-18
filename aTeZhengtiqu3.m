%��������������SVMģ�͡���Ч���ܲ���
function[x_tezheng,seg]=aTeZhengtiqu3(Data)
Data=double(Data);
number=1000;
%%ע�ʹ�Ϊsvm_productʹ�ã�ʹ��ʱ��ע��ע�͵���
[m,~]=size(Data);
if m==1
    inc=1000;
    Data=(enframe(Data,number,inc))';
end
[~,seg]=size(Data);

pt1=mean(Data);%ƽ��ֵ
pt2=rms(Data);%������
pt3=max(Data);%��ֵ
pt4=pt3./pt2;%��ֵָ��
pt5=pt3./pt1;%����ָ��
pt6=skewness(Data);%ƫ��
pt7=kurtosis(Data);%�Ͷ�
pt8=var(Data);%����
%%
%ʱ��ָ��
Data_diff=abs(Data(number/2+1:end,:)-Data(1:number/2,:));
Data_diff=sqrt(sum(power(Data_diff,2))/number/2);

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
pf2=var(Y);%Ƶ�򷽲�
pf3=mean(Y);%Ƶ��ƽ��ֵ
x_tezheng=[Data_diff;pt4;pt6;pt5;pt7;f6;f7;f8;f9;pt1;pt2;fx_kurtosis;pf2;Ef;pf3];%BP�����ʽΪ15*72668����ʽ
end