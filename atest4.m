clear
clc
wlen=500;
filename=['20170730101109_C1C2_32768_100000_2_8';];
pathname='H:\data\';
name_file= filename(1,1:14);
load([pathname name_file '.mat']);%�м��пո�
y=data_c1(:,1:500);
y=y';
Y=fft(y);                               % FFT�任
N2=wlen/2+1;                            % ȡ��Ƶ�ʲ���
n2=1:N2;
Y_abs=abs(Y(n2,:));                     % ȡ��ֵ
M=fix(N2/4);                            % �����Ӵ���
for k=1 : 4096
    for i=1 : M                         % ÿ���Ӵ�����4������
        j=(i-1)*4+1;
        SY(i,k)=Y_abs(j,k)+Y_abs(j+1,k)+Y_abs(j+2,k)+Y_abs(j+3,k);
    end
    Dvar(k)=var(SY(:,k));               % ����ÿ֡�Ӵ������Ƶ������
end
Dvarm=multimidfilter(Dvar,10);          % ƽ������


