clc
clear all
close all
% my_path='I:\武汉西测试数据\武汉西201702028-数据段-4km处测试';     %读取分析文件的路径D:\data\西宁cot0802_roadbuilding datadatahou640_10yinbao_3gegl5 data560m处敲击踩踏地面1.2km处压路机施工
% pathname='J:\武汉西201702028-数据段-5km-6km处高速并行\';
% filename='20170228100205_C1C2_32768_66666_3_8_pos650_850_t_1_262.sigL';
% dot_T=201; %周期点数
% center_line=66;
pathname='I:\武汉西测试数据\武汉西201702028-数据段-4km处测试\';
filename='20170228093612_C1C2_32768_66666_3_8_pos473_533_t_1_69.sigL';
dot_T=8192; %周期点数
center_line=6;

differ_jump=1;
fid=fopen([pathname,filename],'rb','l');
% % myfile_read1=strcat(my_path,'.dat');
% [filename,pathname]=uigetfile({'*.*';'*CH';'*.dat'},'File Selector');
% fid=fopen([pathname,filename],'rb','l');
Fs=500;

t=1;            %读取时间，每次读取数据的时间长度,秒


fseek(fid,0,'eof');                     %获取读取分析文件的长度  
pozition=ftell(fid);
num=floor(pozition/(2*dot_T*t*Fs));
fseek(fid,0,'bof'); 

A_M=[]; %能量趋势矩阵

for i=1:num
    
    sigall=fread(fid,dot_T*t*Fs,'uint16');   %列向量
    sigreshape=reshape(sigall,dot_T,[]);%转换成以dot-T为行数，剩下为列数的矩阵
    sig_matrix_differ=abs(sigreshape(:,1:end-1)-sigreshape(:,2:end));%后一列减去前一列。
    
    sig_matrix_differ_max=max(sig_matrix_differ);%找出后一列减去前一列的最大值
    
%     clear sigall
    signal=sigreshape(center_line,:);
%     clear sigreshape
    Tsignal1=signal(:,differ_jump+1:end);
    signal(:,end-differ_jump+1:end)=[];
    signaldiff=signal-Tsignal1;
%     [f,Pxx,deltF,peak_percent]=FP_sig(signaldiff,Fs);
%    A1=sum(abs(signaldiff(:,1:Fs*1)),2); %信号绝对值代表了能量
%    A2=sum(abs(signaldiff(:,Fs*1+1:Fs*2)),2);
%    A3=sum(abs(signaldiff(:,Fs*2+1:Fs*3)),2);
%    A4=sum(abs(signaldiff(:,Fs*3+1:Fs*4)),2);
%    A5=sum(abs(signaldiff(:,Fs*4+4:end)),2);
%    A_m=[A1;A2;A3;A4;A5];
%    A_M=[A_M,A_m];

% 
        figure(1)
        subplot(211)
        plot(signal)
%         ylim([0.8e4,1.7e4])
        title('观测点原始信号')
        subplot(212)
        plot(abs(signaldiff))
%         ylim([0,5000])
        title('观测点差分信号')
% %  figure(2)
% %  plot(f,Pxx)
figure(2)
plot(sig_matrix_differ_max)
title('cfut_line')
figure(3)
plot(sigall(1:dot_T*4))
title('原始信号前n个点')
    pause

end

%     for j=1:span
% 
%         figure(1)
%         plot(A_M(j,:))
%         title(['空间为第',num2str(j),'/',num2str(span),'个点'])
%         pause
% %  figure(2)
% %  plot(f,Pxx)
%         
% 
%     end

