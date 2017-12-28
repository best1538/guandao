clc
clear
number=500;
filename=['20170730101109_C1C2_32768_100000_2_8';];
pathname='H:\data\';
name_file= filename(1,1:14);
load([pathname name_file '.mat']);%�м��пո�
data_c1=data_c1(687,:);
figure(1)
plot(data_c1)
data_c1=data_c1';
[m,~]=size(data_c1);
line_number=floor(m/number);
z=[];
z8=[];
for w=1:line_number
    data1=data_c1((w-1)*number+1:w*number,:);%���Ժ��������˲�����Ҫ�����ı䡣
    %%
    Y=fft(data1);                   % FFT�任
    N2=number/2+1;                            % ȡ��Ƶ�ʲ���
    n2=2:N2;
    Y_abs=abs(Y(n2,:));                     % ȡ��ֵ
    M=fix(N2/8);                            % �����Ӵ���
    for k=1 : 1
        for i=1 : M                         % ÿ���Ӵ�����4������
            j=(i-1)*8+1:i*8;
            SY(i,k)=sum(Y_abs(j,k));
        end
        Dvar(k)=var(SY(:,k));               % ����ÿ֡�Ӵ������Ƶ������
    end
    z=[z,Dvar];
    %%
    Data_diff=abs(data1(number/2+1:end,:)-data1(1:number/2,:));
Data_diff=sqrt(sum(power(Data_diff,2))/number/2);
   z8=[z8,Data_diff];
end
    z1=median(z)
    z2=mean(z)
    z9=median(z8);
    z10=mean(z8);
    figure(2)
   plot(z)