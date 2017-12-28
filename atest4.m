clear
clc
wlen=500;
filename=['20170730101109_C1C2_32768_100000_2_8';];
pathname='H:\data\';
name_file= filename(1,1:14);
load([pathname name_file '.mat']);%中间有空格
y=data_c1(:,1:500);
y=y';
Y=fft(y);                               % FFT变换
N2=wlen/2+1;                            % 取正频率部分
n2=1:N2;
Y_abs=abs(Y(n2,:));                     % 取幅值
M=fix(N2/4);                            % 计算子带数
for k=1 : 4096
    for i=1 : M                         % 每个子带中有4条谱线
        j=(i-1)*4+1;
        SY(i,k)=Y_abs(j,k)+Y_abs(j+1,k)+Y_abs(j+2,k)+Y_abs(j+3,k);
    end
    Dvar(k)=var(SY(:,k));               % 计算每帧子带分离的频带方差
end
Dvarm=multimidfilter(Dvar,10);          % 平滑处理


